import 'package:equatable/equatable.dart';

class StaffShift extends Equatable {
  final int id;
  final int staffId;
  final int shiftId;
  final DateTime workDate;
  final String status;
  final int dayOfWeek;

  const StaffShift({
    required this.id,
    required this.staffId,
    required this.shiftId,
    required this.workDate,
    required this.status,
    required this.dayOfWeek,
  });

  @override
  List<Object?> get props => [id, staffId, shiftId, workDate, status];
}
