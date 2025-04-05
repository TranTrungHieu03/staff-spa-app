part of 'list_message_bloc.dart';

@immutable
sealed class ListMessageState {}

final class ListMessageInitial extends ListMessageState {}

final class ListMessageLoading extends ListMessageState {}

final class ListMessageLoaded extends ListMessageState {
  final List<MessageChannelModel> messages;

  ListMessageLoaded(this.messages);
}

final class ListMessageError extends ListMessageState {
  final String message;

  ListMessageError(this.message);
}
