part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}
