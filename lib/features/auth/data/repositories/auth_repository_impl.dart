import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spa_mobile/core/errors/exceptions.dart';
import 'package:spa_mobile/core/errors/failure.dart';
import 'package:spa_mobile/core/network/connection_checker.dart';
import 'package:spa_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:spa_mobile/features/auth/domain/usecases/forget_password.dart';
import 'package:spa_mobile/features/auth/domain/usecases/login.dart';
import 'package:spa_mobile/features/auth/domain/usecases/login_with_facebook.dart';
import 'package:spa_mobile/features/auth/domain/usecases/login_with_google.dart';
import 'package:spa_mobile/features/auth/domain/usecases/resend_otp.dart';
import 'package:spa_mobile/features/auth/domain/usecases/reset_password.dart';
import 'package:spa_mobile/features/auth/domain/usecases/sign_up.dart';
import 'package:spa_mobile/features/auth/domain/usecases/verify_otp.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepositoryImpl(this._authRemoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      String token = await _authRemoteDataSource.login(params);

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
  Future<Either<Failure, String>> loginWithGoogle() async {
    try {
      _firebaseAuth.setLanguageCode('en');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const ApiFailure(message: "Google sign-in aborted"));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception("Failed to retrieve Google tokens");
      }
      final AuthCredential credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception("Failed to retrieve Google tokens");
      }
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      final User? user = userCredential.user;

      final String email = user?.email ?? '';
      final String userName = user?.displayName ?? '';
      final String imageUrl = user?.photoURL ?? '';
      final String phone = user?.phoneNumber ?? '';

      print("$email $userName $phone");

      String token = await _authRemoteDataSource.loginWithGoogle(
        LoginWithGoogleParams(
            email: email,
            userName: userName,
            imageUrl: imageUrl,
            phone: phone,
            role: "Customer"),
      );

      return right(token);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> loginWithFacebook() async {
    try {
      print("Login with Facebook");

      final LoginResult loginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      print(userData["name"]);
      print("end");
      if (loginResult.status != LoginStatus.success) {
        print("Facebook login failed: ${loginResult.status}");
        return left(const ApiFailure(message: "Facebook sign-in aborted"));
      }

      final AccessToken accessToken = loginResult.accessToken!;

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final String email = userData["email"] ?? '';
      final String userName = userData["name"] ?? '';
      final String imageUrl = userData["picture"]?['data']?["url"] ?? '';

      print("$email $userName $imageUrl");

      String token = await _authRemoteDataSource.loginWithFacebook(
        LoginWithFacebookParams(
            email: email,
            userName: userName,
            imageUrl: imageUrl,
            phone: "",
            role: "Customer"),
      );

      return right(token);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "FAILED") {
          return left(const ApiFailure(
              message: "Choose other way to login."));
        }
      }
      return left(ApiFailure(message: e.toString()));
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
  Future<Either<Failure, String>> forgetPassword(
      ForgetPasswordParams params) async {
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
  Future<Either<Failure, String>> resetPassword(
      ResetPasswordParams params) async {
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
}
