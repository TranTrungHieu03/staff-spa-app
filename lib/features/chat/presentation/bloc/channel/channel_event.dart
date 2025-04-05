part of 'channel_bloc.dart';


@immutable
sealed class ChannelEvent {}

final class GetChannelEvent extends ChannelEvent {
  final GetChannelParams params;

  GetChannelEvent(this.params);
}
