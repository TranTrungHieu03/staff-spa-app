import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_day_off.dart';
import 'package:staff_app/features/working_time/domain/usecases/register_working_time.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final RegisterWorkingTime _registerWorkingTime;
  final RegisterDayOff _registerDayOff;

  ShiftBloc({
    required RegisterWorkingTime registerWorkingTime,
    required RegisterDayOff registerDayOff,
  })  : _registerWorkingTime = registerWorkingTime,
        _registerDayOff = registerDayOff,
        super(ShiftInitial()) {
    on<RegisterShiftEvent>((event, emit) async {
      emit(ShiftLoading());
      final result = await _registerWorkingTime(event.params);
      result.fold(
        (failure) {
          emit(ShiftError(failure.message));
        },
        (message) {
          emit(ShiftSuccess(message));
        },
      );
    });
    on<RegisterShiftOffEvent>((event, emit) async {
      emit(ShiftLoading());
      final result = await _registerDayOff(event.params);
      result.fold(
        (failure) {
          emit(ShiftError(failure.message));
        },
        (message) {
          emit(ShiftSuccess(message));
        },
      );
    });
  }
}
