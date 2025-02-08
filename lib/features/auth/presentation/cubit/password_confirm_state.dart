part of 'password_confirm_cubit.dart';

@immutable
sealed class PasswordConfirmState {}

final class PasswordConfirmInitial extends PasswordConfirmState {
  final bool isHide;

  PasswordConfirmInitial({this.isHide = true});
}

final class PasswordConfirmToggled extends PasswordConfirmState {
  final bool isHide;

  PasswordConfirmToggled(this.isHide);
}
