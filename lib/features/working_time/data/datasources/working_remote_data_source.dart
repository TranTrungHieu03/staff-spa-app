import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/response/api_response.dart';
import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_working_time.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_day_off.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';

abstract class WorkingRemoteDataSource {
  Future<String> registerWorkingTime(RegisterWorkingTimeParams params);

  Future<String> registerDayOff(RegisterDayOffParams params);

  Future<List<ShiftModel>> getShifts();

  Future<List<StaffShiftModel>> getWorkingTime(GetWorkingTimeParams params);
}

class WorkingRemoteDataSourceImpl implements WorkingRemoteDataSource {
  final NetworkApiService _apiServices;

  WorkingRemoteDataSourceImpl(this._apiServices);

  @override
  Future<String> registerWorkingTime(RegisterWorkingTimeParams params) async {
    try {
      final response = await _apiServices.postApi("/WorkSchedule/create-work-schedule-multi-shift", params.toJson());

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success) {
        return apiResponse.result!.message!;
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<ShiftModel>> getShifts() async {
    try {
      final response = await _apiServices.getApi("/Staff/get-list-shifts");

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success) {
        return (apiResponse.result!.data! as List).map((x) => ShiftModel.fromJson(x)).toList();
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<StaffShiftModel>> getWorkingTime(GetWorkingTimeParams params) async {
    try {
      final response = await _apiServices.getApi("/Staff/slot-working?fromDate=${params.fromDate}&toDate=${params.toDate}");

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success) {
        return (apiResponse.result!.data!['slotWorkings'] as List).map((x) => StaffShiftModel.fromJson(x)).toList();
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<String> registerDayOff(RegisterDayOffParams params) async {
    try {
      final response = await _apiServices.postApi("/Staff/create-staff-leave", params.toJson());

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success) {
        return apiResponse.result!.message!;
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
