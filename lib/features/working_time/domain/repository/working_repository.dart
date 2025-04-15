import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_working_time.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_day_off.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';

abstract class WorkingRepository {
  Future<Either<Failure, String>> registerWorkingTime(RegisterWorkingTimeParams params);

  Future<Either<Failure, String>> registerDayOff(RegisterDayOffParams params);

  Future<Either<Failure, List<ShiftModel>>> getShifts();

  Future<Either<Failure, List<StaffShiftModel>>> getWorkingTime(GetWorkingTimeParams params);
}
