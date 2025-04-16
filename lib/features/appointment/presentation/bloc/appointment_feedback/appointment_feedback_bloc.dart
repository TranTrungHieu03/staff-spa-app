import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/appointment/data/model/appointment_feedback_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_feeback.dart';
import 'package:staff_app/features/appointment/domain/usecases/submit_feedback.dart';
import 'package:staff_app/features/appointment/domain/usecases/update_feedback.dart';

part 'appointment_feedback_event.dart';
part 'appointment_feedback_state.dart';

class AppointmentFeedbackBloc extends Bloc<AppointmentFeedbackEvent, AppointmentFeedbackState> {
  final GetFeedback _getFeedback;
  final SubmitFeedback _submitFeedback;
  final UpdateFeedback _updateFeedback;

  AppointmentFeedbackBloc({
    required GetFeedback getFeedback,
    required SubmitFeedback submitFeedback,
    required UpdateFeedback updateFeedback,
  })  : _getFeedback = getFeedback,
        _submitFeedback = submitFeedback,
        _updateFeedback = updateFeedback,
        super(AppointmentFeedbackInitial()) {
    on<GetAppointmentFeedbackEvent>((event, emit) async {
      emit(AppointmentFeedbackLoading());
      final result = await _getFeedback(event.params);
      result.fold(
        (failure) => emit(AppointmentFeedbackError(failure.message)),
        (feedback) => emit(AppointmentFeedbackLoaded(feedback)),
      );
    });
    on<SubmitAppointmentFeedbackEvent>((event, emit) async {
      emit(AppointmentFeedbackLoading());
      final result = await _submitFeedback(event.params);
      result.fold(
        (failure) => emit(AppointmentFeedbackError(failure.message)),
        (id) => emit(AppointmentFeedbackSubmitted(id)),
      );
    });
    on<UpdateAppointmentFeedbackImageEvent>((event, emit) async {
      emit(AppointmentFeedbackLoading());
      final result = await _updateFeedback(event.params);
      result.fold(
        (failure) => emit(AppointmentFeedbackError(failure.message)),
        (id) => emit(AppointmentFeedbackSubmitted(id)),
      );
    });
  }
}
