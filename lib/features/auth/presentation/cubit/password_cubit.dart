import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());

  void togglePasswordVisibility() {
    final currentState = state;
    bool isHidden = true;

    if (currentState is PasswordInitial) {
      isHidden = currentState.isPasswordHidden;
    } else if (currentState is PasswordVisibilityToggled) {
      isHidden = currentState.isPasswordHidden;
    }

    emit(PasswordVisibilityToggled(!isHidden));
  }
}
