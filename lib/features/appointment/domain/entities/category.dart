import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int categoryId;
  final String name;
  final String description;

  final String status;
  final String thumbnail;

  const Category({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.status,
    required this.thumbnail,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId];
}
