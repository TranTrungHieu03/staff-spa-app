part of 'appointment_feedback_bloc.dart';

@immutable
sealed class AppointmentFeedbackState {}

final class AppointmentFeedbackInitial extends AppointmentFeedbackState {}

final class AppointmentFeedbackLoading extends AppointmentFeedbackState {}

final class AppointmentFeedbackLoaded extends AppointmentFeedbackState {
  final AppointmentFeedbackModel feedback;

  AppointmentFeedbackLoaded(this.feedback);
}

final class AppointmentFeedbackError extends AppointmentFeedbackState {
  final String message;

  AppointmentFeedbackError(this.message);
}

final class AppointmentFeedbackSubmitted extends AppointmentFeedbackState {
  final int id;

  AppointmentFeedbackSubmitted(this.id);
}
