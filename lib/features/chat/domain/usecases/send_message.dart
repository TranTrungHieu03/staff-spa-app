import 'package:dartz/dartz.dart';
import 'package:staff_app/core/usecase/usecase.dart';
import 'package:staff_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessage implements UseCase<Either, SendMessageParams> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either> call(SendMessageParams params) async {
    return await repository.sendMessage(params);
  }
}

class SendMessageParams {
  final String channelId;
  final String senderId;
  final String? content;
  final String messageType;
  final String? fileUrl;

  SendMessageParams({
    required this.channelId,
    required this.senderId,
    this.content,
    this.messageType = 'text',
    this.fileUrl,
  });

  // Convert to Map for easier serialization
  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'fileUrl': fileUrl,
    };
  }

  // Create from Map for easier deserialization
  factory SendMessageParams.fromMap(Map<String, dynamic> map) {
    return SendMessageParams(
      channelId: map['channelId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String?,
      messageType: map['messageType'] as String,
      fileUrl: map['fileUrl'] as String?,
    );
  }

  // Override toString for better debugging
  @override
  String toString() {
    return 'SendMessageParams('
        'channelId: $channelId, '
        'senderId: $senderId, '
        'content: $content, '
        'messageType: $messageType, '
        'fileUrl: $fileUrl)';
  }

  SendMessageParams copyWith({
    String? channelId,
    String? senderId,
    String? content,
    String? messageType,
    String? fileUrl,
  }) {
    return SendMessageParams(
      channelId: channelId ?? this.channelId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
