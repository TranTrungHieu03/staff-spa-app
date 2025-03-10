import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
  final int voucherId;
  final String code;
  final int quantity;
  final int remainQuantity;
  final String status;
  final String description;
  final double discountAmount;
  final double minOrderAmount;
  final DateTime validFrom;
  final DateTime validTo;
  final DateTime createdDate;
  final DateTime updatedDate;

  Voucher({
    required this.voucherId,
    required this.code,
    required this.quantity,
    required this.remainQuantity,
    required this.status,
    required this.description,
    required this.discountAmount,
    required this.minOrderAmount,
    required this.validFrom,
    required this.validTo,
    required this.createdDate,
    required this.updatedDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [code];
}
