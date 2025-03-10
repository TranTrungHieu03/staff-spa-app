import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int page;
  final int totalPage;
  final int totalCount;

  const Pagination({
    required this.page,
    required this.totalPage,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [page];
}
