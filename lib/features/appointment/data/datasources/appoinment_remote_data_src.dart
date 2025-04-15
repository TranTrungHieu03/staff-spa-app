import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/response/api_response.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/data/model/staff_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_appointment.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> getAppointment(GetAppointmentParams params);

  Future<String> checkIn(CheckInParams params);

  Future<StaffAppointmentModel> getListAppointment(GetListAppointmentParams params);
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final NetworkApiService _apiService;

  AppointmentRemoteDataSourceImpl(this._apiService);

  @override
  Future<AppointmentModel> getAppointment(GetAppointmentParams params) async {
    try {
      final response = await _apiService.getApi('/Appointments/get-by-id/${params.id}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return AppointmentModel.fromJson(apiResponse.result!.data!);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      AppLogger.info(e.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<String> checkIn(CheckInParams params) async {
    try {
      final response = await _apiService.putApi('/Appointments/update/${params.orderId}', params.toJson());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return apiResponse.result!.message.toString();
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      AppLogger.info(e.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<StaffAppointmentModel> getListAppointment(GetListAppointmentParams params) async {
    try {
      final response = await _apiService.postApi('/Staff/get-staff-appointments', params.toJson());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return StaffAppointmentModel.fromJson(apiResponse.result!.data);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
