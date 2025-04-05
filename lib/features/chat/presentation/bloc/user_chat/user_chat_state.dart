part of 'user_chat_bloc.dart';

@immutable
sealed class UserChatState {}

final class UserChatInitial extends UserChatState {}

final class UserChatLoading extends UserChatState {}

final class UserChatLoaded extends UserChatState {
  final UserChatModel user;

  UserChatLoaded(this.user);
}

final class UserChatError extends UserChatState {
  final String message;

  UserChatError(this.message);
}
