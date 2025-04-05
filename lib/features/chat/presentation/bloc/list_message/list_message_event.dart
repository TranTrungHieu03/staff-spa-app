part of 'list_message_bloc.dart';

@immutable
sealed class ListMessageEvent {}

final class GetListMessageEvent extends ListMessageEvent {
  final GetListMessageParams params;

  GetListMessageEvent(this.params);
}

class ListMessageNewMessageEvent extends ListMessageEvent {
  final MessageChannelModel newMessage;

  ListMessageNewMessageEvent(this.newMessage);
}
