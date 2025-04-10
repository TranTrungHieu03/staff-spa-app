import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';

class Login implements UseCase<Either, LoginParams> {
  final AuthRepository _authRepository;

  Login(this._authRepository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _authRepository.login(params);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'identifier': email, 'password': password};
  }
}
