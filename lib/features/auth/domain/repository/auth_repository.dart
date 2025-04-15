import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/auth/domain/usecases/forget_password.dart';
import 'package:staff_app/features/auth/domain/usecases/login.dart';
import 'package:staff_app/features/auth/domain/usecases/resend_otp.dart';
import 'package:staff_app/features/auth/domain/usecases/reset_password.dart';
import 'package:staff_app/features/auth/domain/usecases/sign_up.dart';
import 'package:staff_app/features/auth/domain/usecases/verify_otp.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, String>> signUp(SignUpParams params);

  Future<Either<Failure, String>> login(LoginParams params);

  Future<Either<Failure, String>> verifyOtp(VerifyOtpParams params);

  Future<Either<Failure, String>> resetPassword(ResetPasswordParams params);

  Future<Either<Failure, String>> forgetPassword(ForgetPasswordParams params);

  Future<Either<Failure, String>> resendOtp(ResendOtpParams params);

  Future<Either<Failure, UserModel>> getUserInfo();

  Future<Either<Failure, StaffModel>> getStaffInfo();

  Future<Either<Failure, String>> logout();
}
