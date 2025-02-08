import 'package:dartz/dartz.dart';
import 'package:spa_mobile/core/usecase/usecase.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';

class LoginWithFacebook implements UseCase<Either, NoParams> {
  final AuthRepository _authRepository;

  LoginWithFacebook(this._authRepository);

  @override
  Future<Either> call(NoParams params) async {
    return await _authRepository.loginWithFacebook();
  }
}

class LoginWithFacebookParams {
  final String email;
  final String userName;
  final String imageUrl;
  final String phone;
  final String role;

  LoginWithFacebookParams(
      {required this.email,
      required this.role,
      required this.userName,
      required this.imageUrl,
      required this.phone});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'userName': userName,
      'fullName': userName,
      'avatar': imageUrl,
      'phone': phone,
      'typeAccount': role
    };
  }
}
