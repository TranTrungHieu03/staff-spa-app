part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentEvent {}

final class GetAppointmentEvent extends AppointmentEvent {
  final String id;

  GetAppointmentEvent(this.id);
}

final class CheckInEvent extends AppointmentEvent {
  final CheckInParams params;

  CheckInEvent(this.params);
}

final class ClearAppointmentEvent extends AppointmentEvent {}
