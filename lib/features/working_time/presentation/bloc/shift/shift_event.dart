part of 'shift_bloc.dart';

@immutable
sealed class ShiftEvent {}

final class RegisterShiftEvent extends ShiftEvent {
  final RegisterWorkingTimeParams params;

  RegisterShiftEvent(this.params);
}

final class RegisterShiftOffEvent extends ShiftEvent {
  final RegisterDayOffParams params;

  RegisterShiftOffEvent(this.params);
}
