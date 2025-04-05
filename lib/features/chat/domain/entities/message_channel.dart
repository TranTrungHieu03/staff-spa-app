import 'package:equatable/equatable.dart';

class MessageChannel extends Equatable {
  final String id;
  final String sender;
  final String? recipient;
  final String? content;
  final String timestamp;
  final String messageType;
  final String? fileUrl;

  const MessageChannel({
    required this.id,
    required this.sender,
    this.recipient,
    this.content,
    required this.timestamp,
    required this.messageType,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [id, sender, recipient, content, timestamp, messageType, fileUrl];
}
