import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/entities/message_channel.dart';

class MessageChannelModel extends MessageChannel {
  final UserChatModel senderCustomer;

  MessageChannelModel(
      {required super.id,
      required super.sender,
      required super.timestamp,
      required super.messageType,
      super.recipient,
      required this.senderCustomer,
      super.content,
      super.fileUrl});

  factory MessageChannelModel.fromJson(Map<String, dynamic> json) {
    return MessageChannelModel(
      id: json['id'] as String,
      sender: json['sender'] as String,
      recipient: json['recipient'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String,
      messageType: json['messageType'] as String,
      fileUrl: json['fileUrl'] as String?,
      senderCustomer: UserChatModel.fromJson(json['senderCustomer'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'content': content,
      'timestamp': timestamp,
      'messageType': messageType,
      'fileUrl': fileUrl,
    };
  }
}
