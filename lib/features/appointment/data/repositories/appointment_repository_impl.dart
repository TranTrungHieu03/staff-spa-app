import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/datasources/appoinment_remote_data_src.dart';
import 'package:staff_app/features/appointment/data/model/order_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;

  AppointmentRepositoryImpl(this._appointmentRemoteDataSource);

  @override
  Future<Either<Failure, OrderAppointmentModel>> getAppointment(GetAppointmentParams params) async {
    try {
      OrderAppointmentModel response = await _appointmentRemoteDataSource.getAppointment(params);
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> checkIn(CheckInParams params) async {
    try {
      String response = await _appointmentRemoteDataSource.checkIn(params);
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
