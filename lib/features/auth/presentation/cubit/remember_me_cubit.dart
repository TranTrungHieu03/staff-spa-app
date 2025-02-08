import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit() : super(RememberMeInitial());

  void toggleRememberMe() {
    final currentState = state;
    bool isRemember = true;
    if (currentState is RememberMeInitial) {
      isRemember = currentState.isRemember;
    } else if (currentState is RememberMeToggle) {
      isRemember = currentState.isRemember;
    }
    emit(RememberMeToggle(!isRemember));
  }
}
