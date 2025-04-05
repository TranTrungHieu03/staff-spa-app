part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatConnectEvent extends ChatEvent {}

class ChatDisconnectEvent extends ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  final SendMessageParams params;

  const ChatSendMessageEvent(this.params);

  @override
  List<Object> get props => [params];
}

class ChatMessageReceivedEvent extends ChatEvent {
  final MessageChannelModel message;

  const ChatMessageReceivedEvent(this.message);
}
