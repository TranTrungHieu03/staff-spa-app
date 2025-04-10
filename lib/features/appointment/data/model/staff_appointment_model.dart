import 'package:staff_app/features/appointment/data/model/appointment_model.dart';

class StaffAppointmentModel {
  final int staffId;
  final List<AppointmentModel> appointments;

  StaffAppointmentModel({
    required this.staffId,
    required this.appointments,
  });

  factory StaffAppointmentModel.fromJson(Map<String, dynamic> json) {
    return StaffAppointmentModel(
      staffId: json['staffId'],
      appointments: (json['appointments'] as List<dynamic>).map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
