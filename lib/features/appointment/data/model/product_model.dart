import 'package:staff_app/features/appointment/data/model/product_category_model.dart';
import 'package:staff_app/features/appointment/domain/entities/product.dart';

class ProductModel extends Product {
  final ProductCategoryModel category;

  ProductModel(
      {required super.productId,
      required super.productName,
      required super.skinTypeSuitable,
      required super.productDescription,
      required super.price,
      required super.dimension,
      required super.brand,
      required super.quantity,
      required super.discount,
      required super.status,
      required super.categoryId,
      required this.category,
      required super.companyId,
      required super.volume,
      required super.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      skinTypeSuitable: json['skinTypeSuitable'],
      productId: json['productId'],
      productName: json['productName'],
      brand: json['brand'] ?? "",
      productDescription: json['productDescription'],
      price: json['price'],
      dimension: json['dimension'],
      quantity: json['quantity'],
      volume: json['volume'],
      discount: json['discount'],
      status: json['status'],
      categoryId: json['categoryId'],
      companyId: json['companyId'],
      category: ProductCategoryModel.fromJson(json['category']),
      images: (json['images'] is List) ? (json['images'] as List).map((e) => e.toString()).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'price': price,
      'volume': volume,
      'quantity': quantity,
      'dimension': dimension,
      'discount': discount,
      'status': status,
      'brand': brand,
      'categoryId': categoryId,
      'skinTypeSuitable': skinTypeSuitable,
      'companyId': companyId,
      'category': category.toJson(),
      'images': (images as List).map((e) => e.toString()).toList(),
    };
  }
}
