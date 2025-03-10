import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_match_state.dart';

class PasswordMatchCubit extends Cubit<PasswordMatchState> {
  PasswordMatchCubit() : super(PasswordMatchInitial());

  void updatePassword(String password) {
    final currentState = state;
    if (currentState is PasswordMatchUpdated) {
      emit(PasswordMatchUpdated(
        password: password,
        confirmPassword: currentState.confirmPassword,
        isMatch: password == currentState.confirmPassword || currentState.confirmPassword == "",
      ));
    } else if (currentState is PasswordMatchInitial) {
      emit(PasswordMatchUpdated(
        password: password,
        confirmPassword: "",
        isMatch: true,
      ));
    }
  }

  void updateConfirmPassword(String confirmPassword) {
    final currentState = state;
    if (currentState is PasswordMatchUpdated) {
      emit(PasswordMatchUpdated(
        password: currentState.password,
        confirmPassword: confirmPassword,
        isMatch: currentState.password == confirmPassword || currentState.password == "",
      ));
    } else if (currentState is PasswordMatchInitial) {
      emit(PasswordMatchUpdated(
        password: "",
        confirmPassword: confirmPassword,
        isMatch: true,
      ));
    }
  }
}
