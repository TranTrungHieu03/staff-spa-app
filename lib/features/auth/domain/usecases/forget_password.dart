import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';

class ForgetPassword implements UseCase<Either, ForgetPasswordParams> {
  final AuthRepository _authRepository;

  ForgetPassword(this._authRepository);

  @override
  Future<Either<Failure, String>> call(ForgetPasswordParams params) async {
    return await _authRepository.forgetPassword(params);
  }
}

class ForgetPasswordParams {
  final String email;

  ForgetPasswordParams({required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
