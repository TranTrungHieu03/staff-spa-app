import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';

part 'list_message_event.dart';
part 'list_message_state.dart';

class ListMessageBloc extends Bloc<ListMessageEvent, ListMessageState> {
  final GetListMessage _getListMessage;

  ListMessageBloc({
    required GetListMessage getListMessage,
  })  : _getListMessage = getListMessage,
        super(ListMessageInitial()) {
    on<ListMessageEvent>((event, emit) async {
      if (event is GetListMessageEvent) {
        emit(ListMessageLoading());
        final result = await _getListMessage(event.params);
        result.fold(
          (failure) => emit(ListMessageError(failure.message)),
          (messages) => emit(ListMessageLoaded(messages)),
        );
      }
    });
    on<ListMessageNewMessageEvent>((event, emit) {
      if (state is ListMessageLoaded) {
        final currentMessages = List<MessageChannelModel>.from((state as ListMessageLoaded).messages);
        currentMessages.add(event.newMessage); // Thêm tin nhắn mới vào danh sách
        currentMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp)); // Sắp xếp lại tin nhắn theo thời gian

        emit(ListMessageLoaded(currentMessages));
      }
    });
  }
}
