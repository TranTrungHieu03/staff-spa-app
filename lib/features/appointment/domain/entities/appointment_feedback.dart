import 'package:equatable/equatable.dart';

class AppointmentFeedback extends Equatable {
  final int id;
  final int customerId;
  final int staffId;
  final int appointmentId;
  final String imageBefore;
  final String imageAfter;
  final String note;

  const AppointmentFeedback({
    required this.id,
    required this.customerId,
    required this.staffId,
    required this.appointmentId,
    required this.imageBefore,
    required this.imageAfter,
    required this.note,
  });

  @override
  List<Object?> get props => [
    id,
    customerId,
    staffId,
    appointmentId,
    imageBefore,
    imageAfter,
    note,
  ];
}
