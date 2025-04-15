class StaffModel {
  final int staffId;
  final int branchId;
  final int userId;
  final int roleId;

  StaffModel({
    required this.staffId,
    required this.branchId,
    required this.userId,
    required this.roleId,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      staffId: json['staffId'] as int,
      branchId: json['branchId'] as int,
      userId: json['userId'] as int,
      roleId: json['roleId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staffId': staffId,
      'branchId': branchId,
      'userId': userId,
      'roleId': roleId,
    };
  }
}
