import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_user_chat_info.dart';

part 'user_chat_event.dart';
part 'user_chat_state.dart';

class UserChatBloc extends Bloc<UserChatEvent, UserChatState> {
  final GetUserChatInfo _getUserChatInfo;

  UserChatBloc({required GetUserChatInfo getUserChatInfo})
      : _getUserChatInfo = getUserChatInfo,
        super(UserChatInitial()) {
    on<GetUserChatInfoEvent>((event, emit) async {
      emit(UserChatLoading());
      final result = await _getUserChatInfo(event.params);
      result.fold((failure) => emit(UserChatError(failure.message)), (data) => emit(UserChatLoaded(data)));
    });
  }
}
