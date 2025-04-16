import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/response/api_response.dart';
import 'package:staff_app/features/appointment/data/model/appointment_feedback_model.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/data/model/staff_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_feeback.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/submit_feedback.dart';
import 'package:staff_app/features/appointment/domain/usecases/update_feedback.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> getAppointment(GetAppointmentParams params);

  Future<AppointmentFeedbackModel> getFeedbackOfAppointment(GetFeedbackParams params);

  Future<int> submitFeedback(SubmitFeedbackParams params);

  Future<int> updateFeedback(UpdateFeedbackParams params);

  Future<int> checkIn(CheckInParams params);

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
  Future<int> checkIn(CheckInParams params) async {
    try {
      final response = await _apiService.patch(
          '/Appointments/update-status-appointment?appointmentId=${params.orderId}&status=${params.status}', params.toJson());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return apiResponse.result!.data!;
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

  @override
  Future<AppointmentFeedbackModel> getFeedbackOfAppointment(GetFeedbackParams params) async {
    try {
      final response = await _apiService.getApi('/AppointmentFeedback/get-by-appointment/${params.appointmentId}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return AppointmentFeedbackModel.fromJson((apiResponse.result!.data as List<dynamic>).first);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> submitFeedback(SubmitFeedbackParams params) async {
    try {
      final response = await _apiService.postApi('/AppointmentFeedback/create', await params.toFormData());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return (apiResponse.result!.data);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> updateFeedback(UpdateFeedbackParams params) async {
    try {
      final response = await _apiService.postApi('/AppointmentFeedback/update/${params.feedbackId}', await params.toFormData());

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        AppLogger.info(apiResponse.result!.data!);
        return (apiResponse.result!.data);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
