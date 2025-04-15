import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/domain/repository/working_repository.dart';

class GetShifts implements UseCase<Either, NoParams> {
  final WorkingRepository repository;

  GetShifts(this.repository);

  @override
  Future<Either<Failure, List<ShiftModel>>> call(NoParams params) async {
    return await repository.getShifts();
  }
}
