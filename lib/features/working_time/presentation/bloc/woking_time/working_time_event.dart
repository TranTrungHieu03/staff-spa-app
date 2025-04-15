part of 'working_time_bloc.dart';

@immutable
sealed class WorkingTimeEvent {}

final class GetWorkingTimeEvent extends WorkingTimeEvent {
  final GetWorkingTimeParams params;

  GetWorkingTimeEvent(this.params);
}
