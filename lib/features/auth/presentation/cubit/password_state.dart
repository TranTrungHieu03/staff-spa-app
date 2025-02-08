part of 'password_cubit.dart';

@immutable
sealed class PasswordState {}

final class PasswordInitial extends PasswordState {
  final bool isPasswordHidden;

  PasswordInitial({this.isPasswordHidden = true});
}

final class PasswordVisibilityToggled extends PasswordState {
  final bool isPasswordHidden;

  PasswordVisibilityToggled(this.isPasswordHidden);
}
