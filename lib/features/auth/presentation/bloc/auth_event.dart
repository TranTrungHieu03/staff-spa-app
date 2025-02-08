part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  final String userName;
  final String phoneNumber;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.role,
    required this.userName,
    required this.phoneNumber,
  });
}

class VerifyEvent extends AuthEvent {
  final VerifyOtpParams params;

  VerifyEvent({required this.params});
}

class ResendOtpEvent extends AuthEvent {
  final ResendOtpParams params;

  ResendOtpEvent({required this.params});
}

class ForgetPasswordEvent extends AuthEvent {
  final ForgetPasswordParams params;

  ForgetPasswordEvent({required this.params});
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordParams params;

  ResetPasswordEvent({required this.params});
}

class GoogleLoginEvent extends AuthEvent {}

class FacebookLoginEvent extends AuthEvent {}
