import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';

class GetUserInformation implements UseCase<Either, NoParams> {
  final AuthRepository _repository;

  GetUserInformation(this._repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await _repository.getUserInfo();
  }
}
