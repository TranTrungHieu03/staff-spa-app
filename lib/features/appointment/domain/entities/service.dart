import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int serviceId;
  final String name;
  final String description;
  final double price;
  final String duration;
  final List<String> images;
  final String status;
  final String steps;
  final int serviceCategoryId;

  const Service({
    required this.serviceId,
    required this.serviceCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.status,
    required this.images,
    required this.steps,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
