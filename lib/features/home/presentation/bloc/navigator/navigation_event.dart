part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class ChangeSelectedIndexEvent extends NavigationEvent {
  final int index;

  ChangeSelectedIndexEvent(this.index);
}

class GoToHomeEvent extends NavigationEvent {}
