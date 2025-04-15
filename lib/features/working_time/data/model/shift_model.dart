import 'package:staff_app/features/working_time/domain/entities/shift.dart';

class ShiftModel extends Shift {
  ShiftModel({required super.id, required super.name, required super.startTime, required super.endTime});

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['shiftId'],
      name: json['shiftName'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }
}
