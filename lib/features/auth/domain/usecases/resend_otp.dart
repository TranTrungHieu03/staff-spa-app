import 'package:dartz/dartz.dart';
import 'package:spa_mobile/core/errors/failure.dart';
import 'package:spa_mobile/core/usecase/usecase.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';

class ResendOtp implements UseCase<Either, ResendOtpParams> {
  final AuthRepository _authRepository;

  ResendOtp(this._authRepository);

  @override
  Future<Either<Failure, String>> call(ResendOtpParams params) async {
    return await _authRepository.resendOtp(params);
  }
}

class ResendOtpParams {
  final String email;

  ResendOtpParams({required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
