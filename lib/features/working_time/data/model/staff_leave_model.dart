import 'package:staff_app/features/working_time/domain/entities/staff_leave.dart';

class StaffLeaveModel extends StaffLeave {
  StaffLeaveModel(
      {required super.staffLeaveId,
      required super.staffId,
      required super.leaveDate,
      required super.reason,
      required super.status,
      required super.createdDate,
      required super.updatedDate});

  factory StaffLeaveModel.fromJson(Map<String, dynamic> json) => StaffLeaveModel(
        staffLeaveId: json["staffLeaveId"],
        staffId: json["staffId"],
        leaveDate: DateTime.parse(json["leaveDate"]),
        reason: json["reason"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );
}
