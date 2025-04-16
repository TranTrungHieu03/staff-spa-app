import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/appointment/data/model/appointment_feedback_model.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/data/model/staff_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_feeback.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/submit_feedback.dart';
import 'package:staff_app/features/appointment/domain/usecases/update_feedback.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentModel>> getAppointment(GetAppointmentParams params);

  Future<Either<Failure, int>> submitFeedback(SubmitFeedbackParams params);

  Future<Either<Failure, AppointmentFeedbackModel>> getFeedback(GetFeedbackParams params);

  Future<Either<Failure, int>> updateFeedback(UpdateFeedbackParams params);

  Future<Either<Failure, int>> checkIn(CheckInParams params);

  Future<Either<Failure, StaffAppointmentModel>> getListAppointment(GetListAppointmentParams params);
}
