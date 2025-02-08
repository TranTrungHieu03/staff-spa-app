part of 'remember_me_cubit.dart';

@immutable
sealed class RememberMeState {}

final class RememberMeInitial extends RememberMeState {
  final bool isRemember;

  RememberMeInitial({this.isRemember = true});
}

final class RememberMeToggle extends RememberMeState {
  final bool isRemember;

  RememberMeToggle(this.isRemember);
}
