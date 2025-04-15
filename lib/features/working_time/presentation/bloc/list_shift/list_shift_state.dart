part of 'list_shift_bloc.dart';

@immutable
sealed class ListShiftState {}

final class ListShiftInitial extends ListShiftState {}

final class ListShiftLoading extends ListShiftState {}

final class ListShiftLoaded extends ListShiftState {
  final List<ShiftModel> shifts;

  ListShiftLoaded(this.shifts);
}

final class ListShiftError extends ListShiftState {
  final String message;

  ListShiftError(this.message);
}
