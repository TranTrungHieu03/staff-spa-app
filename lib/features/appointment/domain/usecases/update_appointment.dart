// import 'package:dartz/dartz.dart';
// import 'package:staff_app/core/errors/failure.dart';
// import 'package:staff_app/core/usecase/usecase.dart';
// import 'package:staff_app/features/appointment/domain/repository/appointment_repository.dart';
//
// class UpdateAppointment implements UseCase<Either, UpdateAppointmentParams> {
//   final AppointmentRepository _appointmentRepository;
//
//   UpdateAppointment(this._appointmentRepository);
//
//   @override
//   Future<Either<Failure, int>> call(UpdateAppointmentParams params) async {
//     return await _appointmentRepository.createAppointment(params);
//   }
// }
//
// class UpdateAppointmentParams {
//   final List<int> staffId;
//   final List<int> serviceId;
//   final int branchId;
//   final DateTime appointmentsTime;
//   final String notes;
//   final int voucherId;
//   final String? feedback;
//   final int totalMinutes;
//
//   UpdateAppointmentParams(
//       {this.staffId,
//       this.serviceId,
//       this.branchId,
//       this.appointmentsTime,
//       this.notes,
//       this.feedback,
//       this.voucherId = 0,
//       this.totalMinutes = 0});
//
//   // Phương thức toJson
//   Map<String, dynamic> toJson() {
//     return {
//       'staffId': staffId,
//       'serviceId': serviceId,
//       'branchId': branchId,
//       'appointmentsTime': appointmentsTime.toIso8601String(), // Chuyển DateTime thành chuỗi ISO 8601
//       'notes': notes,
//       'voucherId': voucherId,
//       'feedback': feedback,
//     };
//   }
//
//   // Phương thức copyWith
//   UpdateAppointmentParams copyWith(
//       {List<int>? staffId,
//       List<int>? serviceId,
//       int? branchId,
//       DateTime? appointmentsTime,
//       String? notes,
//       int? voucherId,
//       String? feedback,
//       int? totalMinutes}) {
//     return UpdateAppointmentParams(
//       staffId: staffId ?? this.staffId,
//       serviceId: serviceId ?? this.serviceId,
//       branchId: branchId ?? this.branchId,
//       appointmentsTime: appointmentsTime ?? this.appointmentsTime,
//       notes: notes ?? this.notes,
//       voucherId: voucherId ?? this.voucherId,
//       feedback: feedback ?? this.feedback,
//       totalMinutes: totalMinutes ?? this.totalMinutes,
//     );
//   }
// }
