part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginParams params;

  LoginEvent(this.params);
}

class SignUpEvent extends AuthEvent {
  final SignUpParams params;

  SignUpEvent(this.params);
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

class GetUserInformationEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
