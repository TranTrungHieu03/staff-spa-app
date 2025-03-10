part of 'on_boarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnPageChangedEvent extends OnboardingEvent {
  final int pageIndex;

  const OnPageChangedEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class NextPageEvent extends OnboardingEvent {}

class SkipPageEvent extends OnboardingEvent {}
