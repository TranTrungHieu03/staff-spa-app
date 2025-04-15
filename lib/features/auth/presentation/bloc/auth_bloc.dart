import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/auth/domain/usecases/forget_password.dart';
import 'package:staff_app/features/auth/domain/usecases/get_staff_info.dart';
import 'package:staff_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:staff_app/features/auth/domain/usecases/login.dart';
import 'package:staff_app/features/auth/domain/usecases/logout.dart';
import 'package:staff_app/features/auth/domain/usecases/resend_otp.dart';
import 'package:staff_app/features/auth/domain/usecases/reset_password.dart';
import 'package:staff_app/features/auth/domain/usecases/sign_up.dart';
import 'package:staff_app/features/auth/domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final SignUp _signUp;
  final VerifyOtp _verifyOtp;
  final ForgetPassword _forgetPassword;
  final ResetPassword _resetPassword;
  final ResendOtp _resendOtp;
  final GetUserInformation _getUserInformation;
  final Logout _logout;
  final GetStaffInformation _getStaffInformation;

  AuthBloc({
    required Login login,
    required SignUp signUp,
    required VerifyOtp verifyEvent,
    required ForgetPassword forgetPassword,
    required ResetPassword resetPassword,
    required ResendOtp resendOtp,
    required GetUserInformation getUserInformation,
    required Logout logout,
    required GetStaffInformation getStaffInformation,
  })  : _login = login,
        _signUp = signUp,
        _verifyOtp = verifyEvent,
        _forgetPassword = forgetPassword,
        _resetPassword = resetPassword,
        _resendOtp = resendOtp,
        _getUserInformation = getUserInformation,
        _logout = logout,
        _getStaffInformation = getStaffInformation,
        super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);

    on<VerifyEvent>(_onVerifyEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ResendOtpEvent>(_onResendOtpEvent);
    on<GetUserInformationEvent>(_onGetUserInformation);
    on<LogoutEvent>(_onLogout);
    on<GetStaffInformationEvent>(_onGetUserStaffInformation);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _login(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "Login successfully")),
    );
  }

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signUp(event.params);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthSuccess(token, "SignUp Successful")),
    );
  }

  Future<void> _onVerifyEvent(VerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _verifyOtp(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthSuccess("", "Verify Successful")),
    );
  }

  Future<void> _onForgetPasswordEvent(ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _forgetPassword(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthSuccess("", "Forget password success")),
    );
  }

  Future<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _resetPassword(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthSuccess("", "Reset password success")),
    );
  }

  Future<void> _onResendOtpEvent(ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _resendOtp(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthSuccess("", "Resend Otp success")),
    );
  }

  Future<void> _onGetUserInformation(GetUserInformationEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _getUserInformation(NoParams());
    result.fold((failure) => emit(AuthFailure(failure.message)), (user) => emit(AuthLoaded(user)));
  }

  Future<void> _onGetUserStaffInformation(GetStaffInformationEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _getStaffInformation(NoParams());
    result.fold((failure) => emit(AuthFailure(failure.message)), (user) {});
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _logout(NoParams());
    result.fold((failure) => emit(AuthFailure(failure.message)), (message) => emit(AuthClear(message)));
  }
}
