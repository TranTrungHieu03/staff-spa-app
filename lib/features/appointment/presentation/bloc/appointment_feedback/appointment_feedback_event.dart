part of 'appointment_feedback_bloc.dart';

@immutable
sealed class AppointmentFeedbackEvent {}

final class GetAppointmentFeedbackEvent extends AppointmentFeedbackEvent {
  final GetFeedbackParams params;

  GetAppointmentFeedbackEvent(this.params);
}

final class SubmitAppointmentFeedbackEvent extends AppointmentFeedbackEvent {
  final SubmitFeedbackParams params;

  SubmitAppointmentFeedbackEvent(this.params);
}

final class UpdateAppointmentFeedbackImageEvent extends AppointmentFeedbackEvent {
  final UpdateFeedbackParams params;

  UpdateAppointmentFeedbackImageEvent(this.params);
}
