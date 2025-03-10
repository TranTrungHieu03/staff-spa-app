import 'package:staff_app/core/common/model/branch_model.dart';
import 'package:staff_app/features/appointment/data/model/service_model.dart';
import 'package:staff_app/features/appointment/domain/entities/appointment.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';

class AppointmentModel extends Appointment {
  final UserModel? customer;

  final UserModel? staff;
  final BranchModel? branch;
  final ServiceModel service;

  const AppointmentModel({
    required super.customerId,
    required super.appointmentId,
    required super.staffId,
    required super.serviceId,
    required super.branchId,
    required super.appointmentsTime,
    required super.status,
    required super.notes,
    required super.feedback,
    this.customer,
    this.staff,
    this.branch,
    required this.service,
    required super.quantity,
    required super.unitPrice,
    required super.subTotal,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'],
      customerId: json['customerId'],
      staffId: json['staffId'],
      serviceId: json['serviceId'],
      branchId: json['branchId'],
      appointmentsTime: DateTime.parse(json['appointmentsTime']),
      status: json['status'],
      notes: json['notes'],
      feedback: json['feedback'],
      customer: json['customer'] != null ? UserModel.fromJson(json['customer']) : null,
      staff: json['staff'] != null ? UserModel.fromJson(json['staff']['staffInfo']) : null,
      branch: json['branch'] != null ? BranchModel.fromJson(json['branch']) : null,
      service: ServiceModel.fromJson(json['service']),
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0.0,
    );
  }

// Appointment copyWith({
//   int? customerId,
//   int? appointmentId,
//   int? staffId,
//   int? serviceId,
//   int? branchId,
//   DateTime? appointmentsTime,
//   String? status,
//   String? notes,
//   String? feedback,
//   UserModel? customer,
//   UserModel? staff,
//   BranchModel? branch,
//   ServiceModel? service,
// }) {
//   return AppointmentModel(
//     appointmentId: appointmentId ?? this.appointmentId,
//     customerId: customerId ?? this.customerId,
//     staffId: staffId ?? staffId,
//     serviceId: serviceId ?? this.serviceId,
//     branchId: branchId ?? this.branchId,
//     appointmentsTime: appointmentsTime ?? this.appointmentsTime,
//     status: status ?? this.status,
//     notes: notes ?? this.notes,
//     feedback: feedback ?? this.feedback,
//     customer: customer ?? this.customer,
//     // staff: staff ?? this.staff,
//     branch: branch ?? this.branch,
//     service: service ?? this.service,
//   );
// }
}
