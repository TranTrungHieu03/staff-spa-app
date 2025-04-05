import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_service_event.dart';
part 'list_service_state.dart';

class ListServiceBloc extends Bloc<ListServiceEvent, ListServiceState> {
  ListServiceBloc() : super(ListServiceInitial()) {
    on<ListServiceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
