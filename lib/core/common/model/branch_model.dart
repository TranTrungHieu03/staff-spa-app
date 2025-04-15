import 'package:staff_app/core/common/entities/branch.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';

class BranchModel extends Branch {
  final UserModel? managerBranch;

  const BranchModel({
    required super.branchId,
    required super.branchName,
    required super.branchAddress,
    required super.branchPhone,
    required super.longAddress,
    required super.latAddress,
    required super.status,
    required super.managerId,
    this.managerBranch,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    AppLogger.debug(json);
    return BranchModel(
      branchId: json['branchId'],
      branchName: json['branchName'],
      branchAddress: json['branchAddress'],
      branchPhone: json['branchPhone'],
      longAddress: json['longAddress'],
      latAddress: json['latAddress'],
      status: json['status'],
      managerId: json['managerId'],
      managerBranch: json['managerBranch'] != null ? UserModel.fromJson(json['managerBranch']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'branchAddress': branchAddress,
      'branchPhone': branchPhone,
      'longAddress': longAddress,
      'latAddress': latAddress,
      'status': status,
      'managerId': managerId,
      'managerBranch': managerBranch?.toJson(),
    };
  }

  Branch copyWith({
    int? branchId,
    String? branchName,
    String? branchAddress,
    String? branchPhone,
    String? longAddress,
    String? latAddress,
    String? status,
    int? managerId,
    UserModel? managerBranch,
  }) {
    return BranchModel(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      branchPhone: branchPhone ?? this.branchPhone,
      longAddress: longAddress ?? this.longAddress,
      latAddress: latAddress ?? this.latAddress,
      status: status ?? this.status,
      managerId: managerId ?? this.managerId,
      managerBranch: managerBranch ?? this.managerBranch,
    );
  }
}
