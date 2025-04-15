import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/working_time/data/model/staff_shift_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_working_time.dart';

part 'working_time_event.dart';
part 'working_time_state.dart';

class WorkingTimeBloc extends Bloc<WorkingTimeEvent, WorkingTimeState> {
  final GetWorkingTime _getWorkingTime;

  WorkingTimeBloc({
    required GetWorkingTime getWorkingTime,
  })  : _getWorkingTime = getWorkingTime,
        super(WorkingTimeInitial()) {
    on<GetWorkingTimeEvent>((event, emit) async {
      emit(WorkingTimeLoading());
      final result = await _getWorkingTime(event.params);
      result.fold(
        (failure) {
          emit(WorkingTimeError(failure.message));
        },
        (workingTimes) {
          emit(WorkingTimeLoaded(workingTimes));
        },
      );
    });
  }
}
