part of 'user_chat_bloc.dart';

@immutable
sealed class UserChatEvent {}

final class GetUserChatInfoEvent extends UserChatEvent {
  final GetUserChatInfoParams params;

  GetUserChatInfoEvent(this.params);
}
