import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/response/api_response.dart';
import 'package:staff_app/features/appointment/data/model/order_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';

abstract class AppointmentRemoteDataSource {
  Future<OrderAppointmentModel> getAppointment(GetAppointmentParams params);

  Future<int> checkIn(CheckInParams params);
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final NetworkApiService _apiService;

  AppointmentRemoteDataSourceImpl(this._apiService);

  @override
  Future<OrderAppointmentModel> getAppointment(GetAppointmentParams params) async {
    try {
      final response = await _apiService.getApi('/Order/detail-booking?orderId=${params.id}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return OrderAppointmentModel.fromJson(apiResponse.result!.data!);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      AppLogger.info(e.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> checkIn(CheckInParams params) async {
    try {
      final response = await _apiService.putApi('/Appointments/update/${params.orderId}', params.toJson());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return apiResponse.result!.data;
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      AppLogger.info(e.toString());
      throw AppException(e.toString());
    }
  }
}
