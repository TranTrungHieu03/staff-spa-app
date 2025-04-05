import 'dart:async';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';

abstract class ChatRemoteDataSource {
  Stream<MessageChannelModel> getMessages();

  Future<void> sendMessage(SendMessageParams message);

  Future<void> connect();

  Future<void> disconnect();
}

class SignalRChatRemoteDataSource implements ChatRemoteDataSource {
  late HubConnection _hubConnection;
  final StreamController<MessageChannelModel> _messageStreamController = StreamController<MessageChannelModel>.broadcast();

  SignalRChatRemoteDataSource({required String hubUrl}) {
    _hubConnection = HubConnectionBuilder().withUrl(hubUrl).withAutomaticReconnect(retryDelays: [2000, 5000]).build();

    _hubConnection.on("receiveChannelMessage", (arguments) {
      AppLogger.info(arguments);
      if (arguments != null && arguments.isNotEmpty) {
        final message = MessageChannelModel.fromJson(arguments as Map<String, dynamic>);
        _messageStreamController.add(message);
      }
    });
  }

  @override
  Stream<MessageChannelModel> getMessages() => _messageStreamController.stream;

  @override
  Future<void> sendMessage(SendMessageParams params) async {
    if (_hubConnection.state != HubConnectionState.Connected) {
      await connect();
    }

    if (params.content?.trim().isEmpty ?? true) {
      throw Exception("Message content is empty.");
    }

    try {
      await _hubConnection.invoke(
        "SendMessageToChannel",
        args: [params.channelId, params.senderId, params.content ?? "", params.messageType, params.fileUrl ?? ""],
      );
      AppLogger.info("Message sent successfully to channel ${params.channelId}");
    } catch (e) {
      AppLogger.error("Failed to send message to channel ${params.channelId}", error: e);
      throw Exception("Failed to send message: ${e.toString()}");
    }
  }

  @override
  Future<void> connect() async {
    if (_hubConnection.state == HubConnectionState.Disconnected) {
      AppLogger.info("Attempting to connect to hub: ${_hubConnection.baseUrl}");
      await _hubConnection.start();
      AppLogger.info("Connected successfully: ${_hubConnection.connectionId}");
    }
  }

  @override
  Future<void> disconnect() async {
    await _hubConnection.stop();
    _messageStreamController.close();
  }
}
