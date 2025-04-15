import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/domain/entities/staff_shift.dart';

class StaffShiftModel extends StaffShift {
  final ShiftModel shift;

  const StaffShiftModel(
      {required super.id,
      required super.staffId,
      required super.shiftId,
      required super.workDate,
      required super.status,
      required super.dayOfWeek,
      required this.shift});

  factory StaffShiftModel.fromJson(Map<String, dynamic> json) {
    return StaffShiftModel(
      id: json['scheduleId'],
      staffId: json['staffId'],
      shiftId: json['shiftId'],
      workDate: DateTime.parse(json['workDate'] as String),
      status: json['status'] as String,
      dayOfWeek: json['dayOfWeek'] as int,
      shift: ShiftModel.fromJson(json['shift']),
    );
  }
}
