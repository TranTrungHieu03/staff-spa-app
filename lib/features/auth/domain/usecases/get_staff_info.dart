import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';
import 'package:staff_app/features/auth/domain/repository/auth_repository.dart';

class GetStaffInformation implements UseCase<Either, NoParams> {
  final AuthRepository _repository;

  GetStaffInformation(this._repository);

  @override
  Future<Either<Failure, StaffModel>> call(NoParams params) async {
    return await _repository.getStaffInfo();
  }
}
