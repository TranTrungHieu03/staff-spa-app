part of 'list_channel_bloc.dart';

@immutable
sealed class ListChannelState {}

final class ListChannelInitial extends ListChannelState {}

final class ListChannelLoading extends ListChannelState {}

final class ListChannelLoaded extends ListChannelState {
  final List<ChannelModel> channels;

  ListChannelLoaded(this.channels);
}

final class ListChannelError extends ListChannelState {
  final String message;

  ListChannelError(this.message);
}
