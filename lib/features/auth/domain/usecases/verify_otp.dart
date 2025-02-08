import 'package:dartz/dartz.dart';
import 'package:spa_mobile/core/errors/failure.dart';
import 'package:spa_mobile/core/usecase/usecase.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';

class VerifyOtp implements UseCase<Either, VerifyOtpParams> {
  final AuthRepository _authRepository;

  VerifyOtp(this._authRepository);

  @override
  Future<Either<Failure, String>> call(VerifyOtpParams params) async {
    return _authRepository.verifyOtp(params);
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {"email": email, "otp": otp};
  }
}
