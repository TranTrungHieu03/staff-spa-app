import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spa_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:spa_mobile/features/auth/domain/usecases/forget_password.dart';
import 'package:spa_mobile/features/auth/domain/usecases/login.dart';
import 'package:spa_mobile/features/auth/domain/usecases/resend_otp.dart';
import 'package:spa_mobile/features/auth/domain/usecases/reset_password.dart';
import 'package:spa_mobile/features/auth/domain/usecases/sign_up.dart';
import 'package:spa_mobile/features/auth/domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<FacebookLoginEvent>(_onFacebookLoginEvent);
    on<VerifyEvent>(_onVerifyEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ResendOtpEvent>(_onResendOtpEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _authRepository
        .login(LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "Login successfully")),
    );
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _authRepository.signUp(SignUpParams(
        email: event.email,
        password: event.password,
        role: event.role,
        userName: event.userName,
        phoneNumber: event.phoneNumber));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "SignUp Successful")),
    );
  }

  Future<void> _onGoogleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _authRepository.loginWithGoogle();

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "SignUp With Google Successful")),
    );
  }

  Future<void> _onFacebookLoginEvent(
      FacebookLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _authRepository.loginWithFacebook();

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "SignUp With Facebook Successful")),
    );
  }

  Future<void> _onVerifyEvent(
      VerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authRepository.verifyOtp(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess("", "Verify Successful")),
    );
  }

  Future<void> _onForgetPasswordEvent(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authRepository.forgetPassword(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess("", "Forget password success")),
    );
  }

  Future<void> _onResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authRepository.resetPassword(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess("", "Reset password success")),
    );
  }

  Future<void> _onResendOtpEvent(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authRepository.resendOtp(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess("", "Resend Otp success")),
    );
  }
}
