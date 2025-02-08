import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkbox_cart_state.dart';

class CheckboxCartCubit extends Cubit<CheckboxCartState> {
  CheckboxCartCubit()
      : super(CheckboxCartInitial(itemStates: const {
          '0': false,
          '1': false,
          '2': false,
          '3': false,
          '4': false,
          '5': false
        }, isAllSelected: false));

  void toggleItemCheckbox(String id, bool value) {
    if (state is CheckboxCartInitial) {
      final currentState = state as CheckboxCartInitial;
      final updateItemStates = Map<String, bool>.from(currentState.itemStates)
        ..[id] = value;

      final isAllSelected =
          updateItemStates.values.every((isChecked) => isChecked);

      emit(currentState.copyWith(
          itemStates: updateItemStates, isAllSelected: isAllSelected));
    }
  }

  void toggleSelectAll(bool value) {
    if (state is CheckboxCartInitial) {
      final currentState = state as CheckboxCartInitial;
      final updatedItemStates =
          currentState.itemStates.map((key, _) => MapEntry(key, value));
      emit(currentState.copyWith(
          itemStates: updatedItemStates, isAllSelected: value));
    }
  }
}
