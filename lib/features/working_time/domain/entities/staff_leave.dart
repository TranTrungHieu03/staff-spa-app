class StaffLeave {
  final int staffLeaveId;
  final int staffId;
  final DateTime leaveDate;
  final String reason;
  final String status;
  final DateTime createdDate;
  final DateTime updatedDate;

  StaffLeave({
    required this.staffLeaveId,
    required this.staffId,
    required this.leaveDate,
    required this.reason,
    required this.status,
    required this.createdDate,
    required this.updatedDate,
  });
}
