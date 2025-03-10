import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';

class ResetPassword implements UseCase<Either, ResetPasswordParams> {
  final AuthRepository _authRepository;

  ResetPassword(this._authRepository);

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) async {
    return await _authRepository.resetPassword(params);
  }
}

class ResetPasswordParams {
  final String email;
  final String password;
  final String passwordConfirm;

  ResetPasswordParams({required this.email, required this.password, required this.passwordConfirm});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "confirmPassword": passwordConfirm};
  }
}
