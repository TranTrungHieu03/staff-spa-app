part of 'on_boarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int pageIndex;

  const OnboardingPageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class OnboardingComplete extends OnboardingState {}
