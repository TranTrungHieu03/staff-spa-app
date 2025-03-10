import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final int branchId;
  final String branchName;
  final String branchAddress;
  final String branchPhone;
  final String longAddress;
  final String latAddress;
  final String status;
  final int managerId;

  const Branch({
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchPhone,
    required this.longAddress,
    required this.latAddress,
    required this.status,
    required this.managerId,
  });

  @override
  List<Object?> get props => [branchId];
}
