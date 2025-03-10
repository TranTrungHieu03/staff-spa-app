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

class AuthClear extends AuthState {
  final String message;

  const AuthClear(this.message);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}

class AuthLoaded extends AuthState {
  final UserModel user;

  const AuthLoaded(this.user);
}

class AuthVerify extends AuthState {
  final String message;

  const AuthVerify(this.message);
}
