import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/appointment/data/model/appointment_model.dart';
import 'package:staff_app/features/appointment/data/model/staff_appointment_model.dart';
import 'package:staff_app/features/appointment/domain/usecases/get_list_appointment.dart';

part 'list_appointment_event.dart';
part 'list_appointment_state.dart';

class ListAppointmentBloc extends Bloc<ListAppointmentEvent, ListAppointmentState> {
  final GetListAppointment _getListAppointment;

  ListAppointmentBloc({required GetListAppointment getListAppointment})
      : _getListAppointment = getListAppointment,
        super(ListAppointmentInitial()) {
    on<GetListAppointmentEvent>((event, emit) async {
      emit(ListAppointmentLoading());
      final result = await _getListAppointment(event.params);
      result.fold((message) => emit(ListAppointmentError(message.toString())), (data) {
        final sortedAppointments = (data as StaffAppointmentModel).appointments
          ..sort((a, b) => a.appointmentsTime.compareTo(b.appointmentsTime));
        emit(ListAppointmentLoaded(appointments: sortedAppointments));
      });
    });
  }
}
