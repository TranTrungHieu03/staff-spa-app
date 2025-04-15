part of 'working_time_bloc.dart';

@immutable
sealed class WorkingTimeState {}

final class WorkingTimeInitial extends WorkingTimeState {}

final class WorkingTimeLoading extends WorkingTimeState {}

final class WorkingTimeLoaded extends WorkingTimeState {
  final List<StaffShiftModel> shifts;

  WorkingTimeLoaded(this.shifts);
}

final class WorkingTimeError extends WorkingTimeState {
  final String message;

  WorkingTimeError(this.message);
}
