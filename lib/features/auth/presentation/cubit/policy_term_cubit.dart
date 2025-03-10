import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'policy_term_state.dart';

class PolicyTermCubit extends Cubit<PolicyTermState> {
  PolicyTermCubit() : super(PolicyTermInitial());

  // Toggle trạng thái của isAccept
  void togglePolicyTerm() {
    final currentState = state;
    bool isAccept = true;

    if (currentState is PolicyTermInitial) {
      isAccept = currentState.isAccept;
    } else if (currentState is PolicyTermToggled) {
      isAccept = currentState.isAccept;
    }
    emit(PolicyTermToggled(!isAccept));
  }

  // Kiểm tra hợp lệ
  void validatePolicyTerm() {
    final currentState = state;
    if (currentState is PolicyTermToggled || currentState is PolicyTermInitial) {
      final isAccept = (currentState as dynamic).isAccept;

      if (!isAccept) {
        emit(PolicyTermError("You must accept the terms and conditions."));
      } else {
        emit(PolicyTermValid());
      }
    }
  }
}
