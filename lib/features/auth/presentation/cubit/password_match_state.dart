part of 'password_match_cubit.dart';

@immutable
sealed class PasswordMatchState {}

final class PasswordMatchInitial extends PasswordMatchState {
  final String password;
  final String confirmPassword;
  final bool isMatch;

  PasswordMatchInitial({
    this.password = '',
    this.confirmPassword = '',
    this.isMatch = true,
  });
}

final class PasswordMatchUpdated extends PasswordMatchState {
  final String password;
  final String confirmPassword;
  final bool isMatch;

  PasswordMatchUpdated({
    required this.password,
    required this.confirmPassword,
    required this.isMatch,
  });
}

