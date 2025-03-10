import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/model/order_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, OrderAppointmentModel>> getAppointment(GetAppointmentParams params);

  Future<Either<Failure, int>> checkIn(CheckInParams params);
}
