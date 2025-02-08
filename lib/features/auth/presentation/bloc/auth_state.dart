part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  final String message;

  const AuthSuccess(this.token, this.message);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
