import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final int categoryId;
  final String name;
  final String description;

  final String status;
  final String imageUrl;

  const ProductCategory({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.status,
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
