part of 'list_shift_bloc.dart';

@immutable
sealed class ListShiftEvent {}

final class GetListShiftEvent extends ListShiftEvent {
  GetListShiftEvent();
}
