import 'package:staff_app/features/appointment/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel(
      {required super.categoryId, required super.name, required super.description, required super.status, required super.imageUrl});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}
