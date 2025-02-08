import 'dart:ffi';

import 'package:spa_mobile/core/response/response.dart';

class Result<T> {
  T? data;
  String? message;

  Result({this.data, this.message});
}

class ApiResponse<T> {
  Status? status;
  Result<T>? result;
  bool success;

  // T? data;
  // String? message;

  ApiResponse._({required this.status, this.result, required this.success});

  ApiResponse.loading() : this._(status: Status.loading, success: false);

  ApiResponse.completed(T data)
      : this._(
            status: Status.completed,
            result: Result(data: data),
            success: true);

  ApiResponse.error(String message)
      : this._(
            status: Status.error,
            result: Result(message: message),
            success: false);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse._(
      status: json['success'] ? Status.completed : Status.error,
      result: json['result'] != null ? Result<T>(
        data: json['result']['data'],
        message: json['result']['message'] ?? json['message'],
      ) : null,
      success: json['success'] ?? false,
    );
  }

  @override
  String toString() {
    return "Status : $status \n Message : ${result?.message} \n Data: ${result?.data}";
  }
}
