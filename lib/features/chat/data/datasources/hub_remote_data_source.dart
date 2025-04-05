import 'package:staff_app/core/errors/exceptions.dart';
import 'package:staff_app/core/network/network.dart';
import 'package:staff_app/core/response/api_response.dart';
import 'package:staff_app/features/chat/data/models/channel_model.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';
import 'package:staff_app/features/chat/domain/usecases/get_user_chat_info.dart';

abstract class HubRemoteDataSource {
  Future<UserChatModel> getUserChatInfo(GetUserChatInfoParams params);

  Future<List<ChannelModel>> getListChannel(GetListChannelParams params);

  Future<ChannelModel> getChannel(GetChannelParams params);

  Future<List<MessageChannelModel>> getListMessage(GetListMessageParams params);
}

class HubRemoteDataSourceImpl implements HubRemoteDataSource {
  final NetworkApiService _apiService;

  HubRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserChatModel> getUserChatInfo(GetUserChatInfoParams params) async {
    try {
      final response = await _apiService.getApi('/Hub/get-customer-info/${params.userId}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return UserChatModel.fromJson(apiResponse.result!.data!);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<ChannelModel>> getListChannel(GetListChannelParams params) async {
    try {
      final response = await _apiService.getApi('/Hub/user-channels/${params.customerId}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return (apiResponse.result!.data as List).map((x) => ChannelModel.fromJson(x)).toList();
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<ChannelModel> getChannel(GetChannelParams params) async {
    try {
      final response = await _apiService.getApi('/Hub/channel/${params.id}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return ChannelModel.fromJson(apiResponse.result!.data!);
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<MessageChannelModel>> getListMessage(GetListMessageParams params) async {
    try {
      final response = await _apiService.getApi('/Hub/channel-messages/${params.id}');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        return (apiResponse.result!.data as List).map((x) => MessageChannelModel.fromJson(x)).toList();
      } else {
        throw AppException(apiResponse.result!.message!);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
