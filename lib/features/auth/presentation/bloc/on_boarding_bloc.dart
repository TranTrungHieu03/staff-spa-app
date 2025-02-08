import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_event.dart';

part 'on_boarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int currentIndex = 0;

  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnPageChangedEvent>((event, emit) {
      currentIndex = event.pageIndex;
      emit(OnboardingPageChanged(currentIndex));
    });

    on<NextPageEvent>((event, emit) {
        if (currentIndex < 2) {
          currentIndex++;
          emit(OnboardingPageChanged(currentIndex));
        } else {
          emit(OnboardingComplete());
        }
      }
    );

    on<SkipPageEvent>((event, emit) {
      currentIndex = 2;
      emit(OnboardingPageChanged(currentIndex));
      emit(OnboardingComplete());
    });
  }
}
