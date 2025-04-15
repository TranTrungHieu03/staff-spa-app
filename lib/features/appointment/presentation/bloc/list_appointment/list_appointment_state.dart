part of 'list_appointment_bloc.dart';

@immutable
sealed class ListAppointmentState {}

final class ListAppointmentInitial extends ListAppointmentState {}

final class ListAppointmentLoading extends ListAppointmentState {}

final class ListAppointmentLoaded extends ListAppointmentState {
  final List<AppointmentModel> appointments;

  ListAppointmentLoaded({required this.appointments});
}

final class ListAppointmentError extends ListAppointmentState {
  final String message;

  ListAppointmentError(this.message);
}
