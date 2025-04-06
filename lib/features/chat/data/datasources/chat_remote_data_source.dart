import 'dart:async';
import 'dart:convert';

import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
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

  SignalRChatRemoteDataSource({required String hubUrl, required String userId}) {
    var defaultHeaders = MessageHeaders();
    defaultHeaders.setHeaderValue("withCredentials", "true");

    _hubConnection = HubConnectionBuilder()
        .withUrl(
      '$hubUrl?userId=$userId',
      options: HttpConnectionOptions(
        headers: defaultHeaders,
      ),
    )
        .withAutomaticReconnect(retryDelays: [2000, 5000]).build();

    _hubConnection.on("receiveChannelMessage", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final message = MessageChannelModel.fromJson(json.decode(json.encode(arguments[0])));

          handleMessageReceived(message);
        } catch (e) {}
      }
    });
  }

  void handleMessageReceived(MessageChannelModel message) {
    _messageStreamController.add(message);
  }

  @override
  Stream<MessageChannelModel> getMessages() {
    return _messageStreamController.stream;
  }

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
    } catch (e) {
      throw Exception("Failed to send message: ${e.toString()}");
    }
  }

  @override
  Future<void> connect() async {
    if (_hubConnection.state == HubConnectionState.Disconnected) {
      await _hubConnection.start()?.then((_) {}).catchError((error) {});
    }
  }

  @override
  Future<void> disconnect() async {
    await _hubConnection.stop();
    _messageStreamController.close();
  }
}
