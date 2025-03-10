import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/appointment/data/model/order_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/checkin_appointment.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_appointment.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAppointment _getAppointment;
  final CheckIn _checkIn;

  AppointmentBloc({
    required GetAppointment getAppointment,
    required CheckIn checkIn,
  })  : _getAppointment = getAppointment,
        _checkIn = checkIn,
        super(AppointmentInitial()) {
    on<GetAppointmentEvent>(_onGetAppointmentEvent);
    on<CheckInEvent>(_onCheckInEvent);
    on<ClearAppointmentEvent>(_onClearAppointmentEvent);
  }

  Future<void> _onGetAppointmentEvent(GetAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await _getAppointment(GetAppointmentParams(id: event.id));
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (appointment) => emit(AppointmentLoaded(appointment)),
    );
  }

  Future<void> _onCheckInEvent(CheckInEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await _checkIn(CheckInParams(orderId: event.params.orderId));
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (data) => emit(AppointmentIdLoaded(data)),
    );
  }

  Future<void> _onClearAppointmentEvent(ClearAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentInitial());
  }
}
