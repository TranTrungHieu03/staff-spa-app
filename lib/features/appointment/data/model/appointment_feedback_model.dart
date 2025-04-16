import 'package:staff_app/features/appointment/domain/entities/appointment_feedback.dart';

class AppointmentFeedbackModel extends AppointmentFeedback {
  const AppointmentFeedbackModel({
    required super.id,
    required super.customerId,
    required super.staffId,
    required super.appointmentId,
    required super.imageBefore,
    required super.imageAfter,
    required super.note,
  });

  factory AppointmentFeedbackModel.fromJson(Map<String, dynamic> json) {
    return AppointmentFeedbackModel(
      id: json['id'] as int,
      customerId: json['customerId'] as int,
      staffId: json['staffId'] as int,
      appointmentId: json['appointmentId'] as int,
      imageBefore: json['imageBefore'] as String,
      imageAfter: json['imageBfter'] as String,
      note: json['comment'] as String,
    );
  }
}
