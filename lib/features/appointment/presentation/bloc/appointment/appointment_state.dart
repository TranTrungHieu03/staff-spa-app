part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentState {
  const AppointmentState();
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentLoaded extends AppointmentState {
  final OrderAppointmentModel appointment;

  const AppointmentLoaded(this.appointment);
}

final class AppointmentIdLoaded extends AppointmentState {
  final String id;

  const AppointmentIdLoaded(this.id);
}

final class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);
}
