import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/working_time/data/model/shift_model.dart';
import 'package:staff_app/features/working_time/domain/usecases/get_shifts.dart';

part 'list_shift_event.dart';
part 'list_shift_state.dart';

class ListShiftBloc extends Bloc<ListShiftEvent, ListShiftState> {
  final GetShifts _getShifts;

  ListShiftBloc({
    required GetShifts getShifts,
  })  : _getShifts = getShifts,
        super(ListShiftInitial()) {
    on<GetListShiftEvent>((event, emit) async {
      emit(ListShiftLoading());
      final result = await _getShifts(NoParams());
      result.fold(
        (failure) {
          emit(ListShiftError(failure.message));
        },
        (shifts) {
          emit(ListShiftLoaded(shifts));
        },
      );
    });
  }
}
