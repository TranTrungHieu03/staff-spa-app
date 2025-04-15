import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/working_time/domain/repository/working_repository.dart';

class RegisterDayOffParams {
  final int staffId;
  final DateTime leaveDate;
  final String reason;

  Map<String, dynamic> toJson() => {
        "staffId": staffId,
        "leaveDate": leaveDate.toIso8601String(),
        "reason": reason,
      };

  RegisterDayOffParams({
    required this.staffId,
    required this.leaveDate,
    required this.reason,
  });
}

class RegisterDayOff implements UseCase<Either, RegisterDayOffParams> {
  final WorkingRepository repository;

  RegisterDayOff(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterDayOffParams params) async {
    return await repository.registerDayOff(params);
  }
}
