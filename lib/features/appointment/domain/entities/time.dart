import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final DateTime startTime;
  final DateTime endTime;

  const Time({required this.startTime, required this.endTime});

  @override
  List<Object?> get props => throw UnimplementedError();
}
