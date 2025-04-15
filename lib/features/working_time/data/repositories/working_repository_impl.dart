import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/working_time/data/datasources/working_remote_data_source.dart';
import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/repository/working_repository.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_working_time.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_day_off.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';

class WorkingRepositoryImpl implements WorkingRepository {
  final WorkingRemoteDataSource _authRemoteDataSource;

  WorkingRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, String>> registerWorkingTime(RegisterWorkingTimeParams params) async {
    try {
      String result = await _authRemoteDataSource.registerWorkingTime(params);
      return right(result);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, List<ShiftModel>>> getShifts() async {
    try {
      List<ShiftModel> result = await _authRemoteDataSource.getShifts();
      return right(result);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, List<StaffShiftModel>>> getWorkingTime(GetWorkingTimeParams params) async {
    try {
      List<StaffShiftModel> result = await _authRemoteDataSource.getWorkingTime(params);
      return right(result);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> registerDayOff(RegisterDayOffParams params) async {
    try {
      String result = await _authRemoteDataSource.registerDayOff(params);
      return right(result);
    } on AppException catch (e) {
      return left(ApiFailure(
        message: e.toString(),
      ));
    }
  }
}
