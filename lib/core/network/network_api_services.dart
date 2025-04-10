import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/network/base_api_services.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/service/auth_service.dart';

/// Class for handling network API requests.
class NetworkApiService implements BaseApiServices {
  final Dio _dio;
  final AuthService authService;
  String? _cachedToken;

  // Constructor to initialize Dio and set up the interceptor
  NetworkApiService({required String baseUrl, required this.authService})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    // Add the interceptor after Dio is initialized
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          AppLogger.info(options.path);
          if (options.path != '/Auth/register' && options.path != '/Auth/login' && options.path != '/Auth/first-step') {
            _cachedToken = _cachedToken ??= await authService.getToken();
            options.headers['Authorization'] = 'Bearer $_cachedToken';
          }
          // _cachedToken = _cachedToken ??= await authService.getToken();

          // options.headers['Authorization'] = 'Bearer $_cachedToken';
          if (options.data is! FormData) {
            options.headers['Content-Type'] = 'application/json';
          }
          if (kDebugMode) {
            AppLogger.info("==> Request Interceptor Triggered \nToken: $_cachedToken\nURL: ${options.uri}\nHeaders: ${options.headers}");
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // Handle token refresh on 401 Unauthorized error
          if (error.response?.statusCode == 401) {
            final newToken = await _refreshToken();
            if (newToken != null) {
              _cachedToken = newToken;

              // Retry the failed request with new token
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer $newToken';

              try {
                final response = options.data is FormData
                    ? await _dio.request(
                        options.path,
                        options: Options(
                          method: options.method,
                          headers: options.headers,
                        ),
                        data: await refreshFormData(options.data),
                        queryParameters: options.queryParameters,
                      )
                    : await _dio.request(
                        options.path,
                        options: Options(
                          method: options.method,
                          headers: options.headers,
                        ),
                        data: options.data,
                        queryParameters: options.queryParameters,
                      );

                return handler.resolve(response);
              } on DioException catch (e) {
                return handler.reject(e);
              }
            }
          }

          return handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        responseHeader: true,
      ),
    );
  }

  Future<String?> _refreshToken() async {
    try {
      final response = await _dio.get('/Auth/refresh-token');
      final newToken = response.data['result']['data'] as String?;
      if (newToken != null) {
        await authService.saveToken(newToken);
        _cachedToken = newToken;
        return newToken;
      }
    } catch (e) {
      AppLogger.info('Failed to refresh token: $e');
      _handleSessionExpired();
    }
    return null;
  }

  void _handleSessionExpired() {
    AppLogger.info('Session expired. Redirecting to login...');
    goLoginNotBack();
  }

  /// Sends a GET request to the specified [url] and returns the response.
  ///
  /// Throws a [NoInternetException] if there is no internet connection.
  /// Throws a [FetchDataException] if the network request times out.
  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(url);
      responseJson = returnResponse(response);

      if (kDebugMode) {
        // AppLogger.debug(responseJson);
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  /// Sends a POST request to the specified [url] with the provided [data]
  /// and returns the response.
  ///
  /// Throws a [NoInternetException] if there is no internet connection.
  /// Throws a [FetchDataException] if the network request times out.
  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    if (kDebugMode) {
      AppLogger.debug(data);
    }

    dynamic responseJson;
    try {
      AppLogger.debug("1######### ${data is FormData}");
      if (data is FormData) {
        AppLogger.debug("FormData fields: ${data.fields}");
        AppLogger.debug("FormData files: ${data.files}");
        for (final file in data.files) {
          final String key = file.key;
          final MultipartFile multipartFile = file.value;

          AppLogger.debug("File Field Key: $key");
          AppLogger.debug("File Name: ${multipartFile.filename}");
          AppLogger.debug("File Content-Type: ${multipartFile.contentType}");
          AppLogger.debug("File Length: ${multipartFile.length}");
        }
      }

      final Response response = await _dio.post(
        url,
        data: data,
        options: data is FormData ? Options(headers: {'Content-Type': 'multipart/form-data'}) : null,
      );
      responseJson = returnResponse(response);
      if (kDebugMode) {
        AppLogger.debug(responseJson);
      }
      return responseJson;
    } on DioException catch (e) {
      if (kDebugMode) {
        AppLogger.error(e);
        AppLogger.error(e.error);
        AppLogger.error(e.message);
      }
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  void _handleDioException(DioException e) {
    AppLogger.error('❌ DioException: ${e.message}');
    AppLogger.error('📄 Response Data: ${e.response?.data}');
    AppLogger.error('🔗 Request Data: ${e.requestOptions.data}');
    AppLogger.error('🔗 Request Headers: ${e.requestOptions.headers}');
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      throw FetchDataException('Network request timed out');
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.statusCode == 401) {
        _handleSessionExpired();
      }
      throw FetchDataException('Bad response: ${e.response?.statusMessage}');
    } else if (e.type == DioExceptionType.badResponse) {
      throw FetchDataException('Bad response: ${e.response?.statusMessage}');
    } else if (e.type == DioExceptionType.connectionError) {
      throw NoInternetException('No internet connection');
    }
    throw FetchDataException('Try again later');
  }

  /// Parses the [response] and returns the corresponding JSON data.
  ///
  /// Throws a [FetchDataException] with the appropriate error message if the response status code is not successful.
  dynamic returnResponse(Response response) {
    if (kDebugMode) {
      AppLogger.debug(response.statusCode);
    }

    switch (response.statusCode) {
      case 200:
      case 400:
        // AppLogger.debug(response.data);
        if (response.data is String) {
          return jsonDecode(response.data);
        } else {
          return response.data;
        }
      case 401:
      // throw UnauthorisedException(response.data.toString());
      case 500:
      case 404:
        // throw BadRequestException(response.data['message']);
        return response.data;
      default:
        throw FetchDataException('Error occurred while communicating with server');
    }
  }

  void clearTokenCache() async {
    _cachedToken = null;
    if (kDebugMode) {
      AppLogger.info("==> Token cache cleared");
    }
  }

  Future<FormData> refreshFormData(FormData originalFormData) async {
    final files = originalFormData.files;
    final newFormData = FormData();

    // Copy non-file fields
    for (final entry in originalFormData.fields) {
      newFormData.fields.add(MapEntry(entry.key, entry.value));
    }

    // Handle file fields
    for (final fileEntry in files) {
      final filePath = fileEntry.value.filename!;
      final file = File(filePath);

      if (await file.exists()) {
        AppLogger.info('File found: $filePath');
        newFormData.files.add(MapEntry(
          fileEntry.key,
          MultipartFile.fromFileSync(file.path, filename: filePath),
        ));
      } else {
        print('File not found: $filePath');
        // Handle the error (e.g., skip the file or throw an exception)
      }
    }

    return newFormData;
  }

  @override
  Future deleteApi(String url) async {
    dynamic responseJson;
    try {
      final response = await _dio.delete(url);
      responseJson = returnResponse(response);

      if (kDebugMode) {
        AppLogger.debug(responseJson);
      }
      return responseJson;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future putApi(String url, dynamic data) async {
    if (kDebugMode) {
      AppLogger.debug(data);
    }

    dynamic responseJson;
    try {
      AppLogger.debug("1######### ${data is FormData}");
      if (data is FormData) {
        AppLogger.debug("FormData fields: ${data.fields}");
        AppLogger.debug("FormData files: ${data.files}");
        for (final file in data.files) {
          final String key = file.key;
          final MultipartFile multipartFile = file.value;

          AppLogger.debug("File Field Key: $key");
          AppLogger.debug("File Name: ${multipartFile.filename}");
          AppLogger.debug("File Content-Type: ${multipartFile.contentType}");
          AppLogger.debug("File Length: ${multipartFile.length}");
        }
      }

      final Response response = await _dio.put(
        url,
        data: data,
        options: data is FormData ? Options(headers: {'Content-Type': 'multipart/form-data'}) : null,
      );
      responseJson = returnResponse(response);
      if (kDebugMode) {
        AppLogger.debug(responseJson);
      }
      return responseJson;
    } on DioException catch (e) {
      if (kDebugMode) {
        AppLogger.error(e);
      }
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future patch(String url, dynamic data) async {
    if (kDebugMode) {
      AppLogger.debug(data);
    }

    dynamic responseJson;
    try {
      AppLogger.debug("1######### ${data is FormData}");
      if (data is FormData) {
        AppLogger.debug("FormData fields: ${data.fields}");
        AppLogger.debug("FormData files: ${data.files}");
        for (final file in data.files) {
          final String key = file.key;
          final MultipartFile multipartFile = file.value;

          AppLogger.debug("File Field Key: $key");
          AppLogger.debug("File Name: ${multipartFile.filename}");
          AppLogger.debug("File Content-Type: ${multipartFile.contentType}");
          AppLogger.debug("File Length: ${multipartFile.length}");
        }
      }

      final Response response = await _dio.patch(
        url,
        data: data,
        options: data is FormData ? Options(headers: {'Content-Type': 'multipart/form-data'}) : null,
      );
      responseJson = returnResponse(response);
      if (kDebugMode) {
        AppLogger.debug(responseJson);
      }
      return responseJson;
    } on DioException catch (e) {
      if (kDebugMode) {
        AppLogger.error(e);
      }
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }
}
