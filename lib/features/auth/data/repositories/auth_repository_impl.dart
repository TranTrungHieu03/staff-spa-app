import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/network/connection_checker.dart';
import 'package:staff_app/core/utils/service/auth_service.dart';
import 'package:staff_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';
import 'package:staff_app/features/auth/domain/usecases/forget_password.dart';
import 'package:staff_app/features/auth/domain/usecases/login.dart';
import 'package:staff_app/features/auth/domain/usecases/resend_otp.dart';
import 'package:staff_app/features/auth/domain/usecases/reset_password.dart';
import 'package:staff_app/features/auth/domain/usecases/sign_up.dart';
import 'package:staff_app/features/auth/domain/usecases/verify_otp.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthService _authService;

  AuthRepositoryImpl(this._authRemoteDataSource, this._connectionChecker, this._authService);

  @override
  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      String token = await _authRemoteDataSource.login(params);

      await _authService.saveToken(token);
      await LocalStorage.saveData(LocalStorageKey.isLogin, "true");
      await LocalStorage.saveData(LocalStorageKey.isCompletedOnBoarding, "true");

      return right(token);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(SignUpParams params) async {
    try {
      String message = await _authRemoteDataSource.signUp(params);
      return right(message);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(VerifyOtpParams params) async {
    try {
      String message = await _authRemoteDataSource.verifyOtp(params);
      return right(message);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(ForgetPasswordParams params) async {
    try {
      String message = await _authRemoteDataSource.forgetPassword(params);
      return right(message);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPasswordParams params) async {
    try {
      String message = await _authRemoteDataSource.resetPassword(params);
      return right(message);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> resendOtp(ResendOtpParams params) async {
    try {
      String message = await _authRemoteDataSource.resendOtp(params);
      return right(message);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserInfo() async {
    try {
      UserModel userModel = await _authRemoteDataSource.getUserInfo();
      if (userModel.roleID == 4 || userModel.roleID == 2) {
        await LocalStorage.saveData(LocalStorageKey.userKey, jsonEncode(userModel));
        await LocalStorage.saveData(LocalStorageKey.isStaff, "true");
        return right(userModel);
      } else {
        return left(const ApiFailure(
          message: 'Only staff or manager can access this app',
        ));
      }
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await _authRemoteDataSource.logout();
      await LocalStorage.saveData(LocalStorageKey.isLogin, "false");
      await LocalStorage.removeData(LocalStorageKey.userKey);
      await _authService.removeToken();
      return right("Logout success");
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }
}
