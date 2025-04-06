import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/domain/usecases/connect_hub.dart';
import 'package:staff_app/features/chat/domain/usecases/disconnect_hub.dart';
import 'package:staff_app/features/chat/domain/usecases/get_message.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final ConnectHub connect;
  final DisconnectHub disconnect;

  StreamSubscription? _messagesSubscription;
  final List<MessageChannelModel> _messages = [];

  ChatBloc({
    required this.getMessages,
    required this.sendMessage,
    required this.connect,
    required this.disconnect,
  }) : super(ChatInitial()) {
    on<ChatConnectEvent>(_onConnect);
    on<ChatDisconnectEvent>(_onDisconnect);
    on<ChatSendMessageEvent>(_onSendMessage);
    on<ChatMessageReceivedEvent>(_onMessageReceived);
  }

  Future<void> _onConnect(ChatConnectEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    try {
      await connect(NoParams());
      await _setupMessageStream(emit);
      emit(ChatLoaded(List.from(_messages)));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _setupMessageStream(Emitter<ChatState> emit) async {
    // _messagesSubscription?.cancel();

    final result = await getMessages(NoParams());

    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (messagesStream) {
        _messagesSubscription = messagesStream.listen(
          (message) => add(ChatMessageReceivedEvent(message)),
          onError: (error) => emit(ChatError(error.toString())),
        );
      },
    );
  }

  Future<void> _onDisconnect(ChatDisconnectEvent event, Emitter<ChatState> emit) async {
    // await _messagesSubscription?.cancel();
    final result = await disconnect(NoParams());

    result.fold(
      (failure) {
        emit(ChatError(failure.message));
      },
      (_) {
        // Optionally handle successful disconnect
      },
    );
  }

  Future<void> _onSendMessage(ChatSendMessageEvent event, Emitter<ChatState> emit) async {
    if (event.params.content?.trim().isEmpty ?? true) return;

    final result = await sendMessage(event.params);

    result.fold(
      (failure) {
        emit(ChatError(failure.message));
      },
      (_) {},
    );
  }

  void _onMessageReceived(ChatMessageReceivedEvent event, Emitter<ChatState> emit) {
    _messages.add(event.message);
    emit(ChatLoaded(List.from(_messages)));
  }

  @override
  Future<void> close() {
    // _messagesSubscription?.cancel();
    return super.close();
  }
}
