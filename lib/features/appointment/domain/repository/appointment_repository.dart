import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/data/model/staff_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentModel>> getAppointment(GetAppointmentParams params);

  Future<Either<Failure, String>> checkIn(CheckInParams params);

  Future<Either<Failure, StaffAppointmentModel>> getListAppointment(GetListAppointmentParams params);
}
