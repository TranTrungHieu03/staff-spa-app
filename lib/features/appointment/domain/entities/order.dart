import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int orderId;
  final int orderCode;
  final int customerId;
  final int? voucherId;
  final double totalAmount;
  final String orderType;
  final String status;
  final String? notes;
  final String? feedback;
  final int quantity;
  final double unitPrice;
  final double subTotal;
  final String statusPayment;
  final String note;
  final DateTime createdDate;
  final DateTime updatedDate;

  const Order({
    required this.orderId,
    required this.orderCode,
    required this.customerId,
    required this.voucherId,
    required this.totalAmount,
    required this.orderType,
    required this.status,
    required this.notes,
    required this.feedback,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
    required this.statusPayment,
    required this.note,
    required this.createdDate,
    required this.updatedDate,
  });

  @override
  List<Object?> get props => [orderCode];
}
