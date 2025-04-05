import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/chat/data/models/channel_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_channel.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final GetChannel _getChannel;

  ChannelBloc({required GetChannel getChannel})
      : _getChannel = getChannel,
        super(ChannelInitial()) {
    on<GetChannelEvent>((event, emit) async {
      emit(ChannelLoading());
      final result = await _getChannel(event.params);
      result.fold((x) => emit(ChannelError(x)), (data) => emit(ChannelLoaded(data)));
    });
  }
}
