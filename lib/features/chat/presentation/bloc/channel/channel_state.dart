part of 'channel_bloc.dart';

@immutable
sealed class ChannelState {}

final class ChannelInitial extends ChannelState {}

final class ChannelLoading extends ChannelState {}

final class ChannelLoaded extends ChannelState {
  final ChannelModel channel;

  ChannelLoaded(this.channel);
}

final class ChannelError extends ChannelState {
  final String message;

  ChannelError(this.message);
}
