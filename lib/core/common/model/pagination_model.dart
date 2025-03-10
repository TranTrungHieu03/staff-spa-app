import 'package:staff_app/core/common/entities/pagination.dart';

class PaginationModel extends Pagination {
  const PaginationModel({required super.page, required super.totalPage, required super.totalCount});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] as int,
      totalPage: json['totalPage'] as int,
      totalCount: json['totalCount'] as int,
    );
  }

  factory PaginationModel.isEmty() {
    return const PaginationModel(
      page: 0,
      totalPage: 0,
      totalCount: 0,
    );
  }
}
