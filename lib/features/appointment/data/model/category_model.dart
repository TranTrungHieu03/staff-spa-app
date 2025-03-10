import 'package:staff_app/features/appointment/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.categoryId, required super.name, required super.description, required super.status, required super.thumbnail});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['serviceCategoryId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'status': status,
      'thumbnail': thumbnail,
    };
  }
}
