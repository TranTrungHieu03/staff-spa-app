part of 'shift_bloc.dart';

@immutable
sealed class ShiftState {}

final class ShiftInitial extends ShiftState {}

final class ShiftLoading extends ShiftState {}

final class ShiftLoaded extends ShiftState {}

final class ShiftError extends ShiftState {
  final String message;

  ShiftError(this.message);
}

final class ShiftSuccess extends ShiftState {
  final String message;

  ShiftSuccess(this.message);
}
