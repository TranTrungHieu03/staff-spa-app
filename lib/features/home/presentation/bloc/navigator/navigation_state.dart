part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitialState extends NavigationState {
  final int selectedIndex;
  final List<Widget> screens;

  NavigationInitialState(this.selectedIndex, this.screens);
}

final class NavigationIndexChangedState extends NavigationState {
  final int selectedIndex;
  final List<Widget> screens;

  NavigationIndexChangedState(this.selectedIndex, this.screens);
}
