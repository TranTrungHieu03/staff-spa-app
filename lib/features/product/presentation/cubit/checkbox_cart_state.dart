part of 'checkbox_cart_cubit.dart';

@immutable
sealed class CheckboxCartState {}

final class CheckboxCartInitial extends CheckboxCartState {
  final Map<String, bool> itemStates;
  final bool isAllSelected;

  CheckboxCartInitial({required this.itemStates, required this.isAllSelected});

  CheckboxCartState copyWith(
      {Map<String, bool>? itemStates, bool? isAllSelected}) {
    return CheckboxCartInitial(
        itemStates: itemStates ?? this.itemStates,
        isAllSelected: isAllSelected ?? this.isAllSelected);
  }
}
