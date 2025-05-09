import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';

class GetAppointment implements UseCase<Either, GetAppointmentParams> {
  final AppointmentRepository _appointmentRepository;

  GetAppointment(this._appointmentRepository);

  @override
  Future<Either<Failure, AppointmentModel>> call(GetAppointmentParams params) async {
    return await _appointmentRepository.getAppointment(params);
  }
}

class GetAppointmentParams {
  final String id;

  GetAppointmentParams({required this.id});
}
