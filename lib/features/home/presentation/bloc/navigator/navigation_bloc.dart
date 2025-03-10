import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:staff_app/features/appointment/presentation/screens/work_schedule_screen.dart';
import 'package:staff_app/features/home/presentation/screen/home_screen.dart';
import 'package:staff_app/features/user/presentation/screens/setting_screen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final List<Widget> screens = [
    const HomeScreen(),
    const WorkScheduleScreen(),
    const SizedBox(),
    const SettingScreen(),
    const SettingScreen(),
  ];

  NavigationBloc() : super(NavigationInitialState(0, const [])) {
    on<ChangeSelectedIndexEvent>((event, emit) {
      emit(NavigationIndexChangedState(event.index, screens));
    });
  }
}
