import 'package:staff_app/core/common/entities/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel(
      {required super.voucherId,
      required super.code,
      required super.quantity,
      required super.remainQuantity,
      required super.status,
      required super.description,
      required super.discountAmount,
      required super.minOrderAmount,
      required super.validFrom,
      required super.validTo,
      required super.createdDate,
      required super.updatedDate});

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherId: json['voucherId'],
      code: json['code'],
      quantity: json['quantity'],
      remainQuantity: json['remainQuantity'],
      status: json['status'],
      description: json['description'],
      discountAmount: (json['discountAmount'] as num).toDouble(),
      minOrderAmount: (json['minOrderAmount'] as num).toDouble(),
      validFrom: DateTime.parse(json['validFrom']),
      validTo: DateTime.parse(json['validTo']),
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucherId': voucherId,
      'code': code,
      'quantity': quantity,
      'remainQuantity': remainQuantity,
      'status': status,
      'description': description,
      'discountAmount': discountAmount,
      'minOrderAmount': minOrderAmount,
      'validFrom': validFrom.toIso8601String(),
      'validTo': validTo.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
