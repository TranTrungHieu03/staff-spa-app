part of 'list_channel_bloc.dart';

@immutable
sealed class ListChannelEvent {}

final class GetListChannelEvent extends ListChannelEvent {
  final GetListChannelParams params;

  GetListChannelEvent(this.params);
}
