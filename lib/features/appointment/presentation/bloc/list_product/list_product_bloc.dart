import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(ListProductInitial()) {
    on<ListProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
