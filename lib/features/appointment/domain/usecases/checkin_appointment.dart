import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';

import '../repository/appointment_repository.dart';

class CheckIn implements UseCase<Either, CheckInParams> {
  final AppointmentRepository _appointmentRepository;

  CheckIn(this._appointmentRepository);

  @override
  Future<Either> call(CheckInParams params) async {
    return await _appointmentRepository.checkIn(params);
  }
}

class CheckInParams {
  final String orderId;
  final String status;

  CheckInParams({required this.orderId, this.status = "Arrived"});

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'status': status,
    };
  }
}
