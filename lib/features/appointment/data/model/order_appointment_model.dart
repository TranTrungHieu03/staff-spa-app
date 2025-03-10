import 'package:staff_app/core/common/model/voucher_model.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/domain/entities/order.dart';

class OrderAppointmentModel extends Order {
  final UserModel? customer;
  final VoucherModel? voucher;
  final List<AppointmentModel> appointments;

  const OrderAppointmentModel({
    required super.orderId,
    required super.orderCode,
    required super.customerId,
    required super.voucherId,
    required super.totalAmount,
    required super.orderType,
    required super.status,
    required super.notes,
    required super.feedback,
    required super.quantity,
    required super.unitPrice,
    required super.subTotal,
    required super.statusPayment,
    required super.note,
    required super.createdDate,
    required super.updatedDate,
    required this.appointments,
    this.customer,
    this.voucher,
  });

  factory OrderAppointmentModel.fromJson(Map<String, dynamic> json) {
    return OrderAppointmentModel(
      customer: json['customer'] != null ? UserModel.fromJson(json['customer']) : null,
      voucher: json['voucher'] != null ? VoucherModel.fromJson(json['voucher']) : null,
      orderId: json['orderId'] ?? '',
      orderCode: json['orderCode'] ?? '',
      customerId: json['customerId'] ?? '',
      voucherId: json['voucherId'] ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderType: json['orderType'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      feedback: json['feedback'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0.0,
      statusPayment: json['statusPayment'] ?? '',
      note: json['note'] ?? '',
      createdDate: json['createdDate'] != null ? DateTime.tryParse(json['createdDate']) ?? DateTime(1970, 1, 1) : DateTime(1970, 1, 1),
      updatedDate: json['updatedDate'] != null ? DateTime.tryParse(json['updatedDate']) ?? DateTime(1970, 1, 1) : DateTime(1970, 1, 1),
      appointments: (json['appointments'] is List)
          ? (json['appointments'] as List).map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>)).toList()
          : [],
    );
  }
}
