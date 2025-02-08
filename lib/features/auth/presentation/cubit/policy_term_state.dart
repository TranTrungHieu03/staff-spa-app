part of 'policy_term_cubit.dart';

@immutable
sealed class PolicyTermState {}

final class PolicyTermInitial extends PolicyTermState {
  final bool isAccept;

  PolicyTermInitial({this.isAccept = true});
}

final class PolicyTermToggled extends PolicyTermState {
  final bool isAccept;

  PolicyTermToggled(this.isAccept);
}

final class PolicyTermError extends PolicyTermState {
  final String message;

  PolicyTermError(this.message);
}

final class PolicyTermValid extends PolicyTermState {}
