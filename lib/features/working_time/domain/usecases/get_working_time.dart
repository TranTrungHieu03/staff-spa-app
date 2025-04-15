import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/repository/working_repository.dart';

class GetWorkingTimeParams {
  final int month;
  final int year;

  const GetWorkingTimeParams({
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      "month": month,
      "year": year,
    };
  }
}

class GetWorkingTime implements UseCase<Either, GetWorkingTimeParams> {
  final WorkingRepository repository;

  GetWorkingTime(this.repository);

  @override
  Future<Either<Failure, List<StaffShiftModel>>> call(GetWorkingTimeParams params) async {
    return await repository.getWorkingTime(params);
  }
}
