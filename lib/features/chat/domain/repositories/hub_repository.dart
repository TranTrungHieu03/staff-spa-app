import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/features/chat/data/models/channel_model.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';
import 'package:staff_app/features/chat/domain/usecases/get_user_chat_info.dart';

abstract class HubRepository {
  Future<Either<Failure, UserChatModel>> getUserChatInfo(GetUserChatInfoParams params);

  Future<Either<Failure, List<ChannelModel>>> getChannelList(GetListChannelParams params);

  Future<Either<Failure, ChannelModel>> getChannel(GetChannelParams params);

  Future<Either<Failure, List<MessageChannelModel>>> getListMessages(GetListMessageParams params);
}
