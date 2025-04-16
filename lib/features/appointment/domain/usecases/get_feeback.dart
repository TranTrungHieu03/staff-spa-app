import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';

class GetFeedbackParams {
  final String appointmentId;

  GetFeedbackParams({required this.appointmentId});
}

class GetFeedback implements UseCase<Either, GetFeedbackParams> {
  final AppointmentRepository repository;

  GetFeedback(this.repository);

  @override
  Future<Either> call(GetFeedbackParams params) async {
    return await repository.getFeedback(params);
  }
}
