import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/working_time/domain/repository/working_repository.dart';

class RegisterWorkingTimeParams {
  final String staffId;
  final DateTime fromDate;
  final DateTime toDate;
  final List<int> shiftIds;

  RegisterWorkingTimeParams({
    required this.staffId,
    required this.fromDate,
    required this.toDate,
    required this.shiftIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'staffId': staffId,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'shiftIds': shiftIds,
    };
  }
}

class RegisterWorkingTime implements UseCase<Either, RegisterWorkingTimeParams> {
  final WorkingRepository repository;

  RegisterWorkingTime(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterWorkingTimeParams params) async {
    return await repository.registerWorkingTime(params);
  }
}
