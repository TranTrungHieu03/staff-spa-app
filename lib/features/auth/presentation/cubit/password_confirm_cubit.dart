import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_confirm_state.dart';

class PasswordConfirmCubit extends Cubit<PasswordConfirmState> {
  PasswordConfirmCubit() : super(PasswordConfirmInitial());

  void togglePasswordConfirm() {
    final currentState = state;
    bool isHide = true;

    if (currentState is PasswordConfirmInitial) {
      isHide = currentState.isHide;
    } else if (currentState is PasswordConfirmToggled) {
      isHide = currentState.isHide;
    }

    emit(PasswordConfirmToggled(!isHide));
  }
}
