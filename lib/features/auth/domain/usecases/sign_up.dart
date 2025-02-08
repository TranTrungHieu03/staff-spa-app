import 'package:dartz/dartz.dart';
import 'package:spa_mobile/core/errors/failure.dart';
import 'package:spa_mobile/core/usecase/usecase.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';

class SignUp implements UseCase<Either, SignUpParams> {
  final AuthRepository _authRepository;

  SignUp(this._authRepository);

  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await _authRepository.signUp(params);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String role;
  final String userName;
  final String phoneNumber;

  SignUpParams(
      {required this.email,
      required this.password,
      required this.role,
      required this.userName,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'typeAccount': role,
      'userName': userName,
      'phone': phoneNumber,
    };
  }
}
