import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:staff_app/core/errors/failure.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/features/chat/data/datasources/hub_remote_data_source.dart';
import 'package:staff_app/features/chat/data/models/channel_model.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/repositories/hub_repository.dart';
import 'package:staff_app/features/chat/domain/usecases/get_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';
import 'package:staff_app/features/chat/domain/usecases/get_user_chat_info.dart';

class HubRepositoryImpl implements HubRepository {
  final HubRemoteDataSource _dataSource;

  HubRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserChatModel>> getUserChatInfo(GetUserChatInfoParams params) async {
    try {
      final UserChatModel response = await _dataSource.getUserChatInfo(params);
      await LocalStorage.saveData(LocalStorageKey.userChat, jsonEncode(response));
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChannelModel>>> getChannelList(GetListChannelParams params) async {
    try {
      final List<ChannelModel> response = await _dataSource.getListChannel(params);
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChannelModel>> getChannel(GetChannelParams params) async {
    try {
      final ChannelModel response = await _dataSource.getChannel(params);
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageChannelModel>>> getListMessages(GetListMessageParams params) async {
    try {
      final List<MessageChannelModel> response = await _dataSource.getListMessage(params);
      return right(response);
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
