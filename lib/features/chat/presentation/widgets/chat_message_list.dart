import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';

Widget chatMessageWidget(
    ScrollController chatListScrollController, List<MessageChannelModel> messages, String currentUserId, List<UserChatModel> members) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      controller: chatListScrollController,
      child: Column(
        children: _buildMessageListWithDates(messages, currentUserId, members),
      ),
    ),
  );
}

List<Widget> _buildMessageListWithDates(List<MessageChannelModel> messages, String currentUserId, List<UserChatModel> members) {
  final List<Widget> messageWidgets = [];
  DateTime? lastMessageDate;

  for (var message in messages) {
    try {
      final messageDate = DateTime.parse(message.timestamp).toLocal();
      final onlyDate = DateTime(messageDate.year, messageDate.month, messageDate.day);

      if (lastMessageDate == null || onlyDate != lastMessageDate) {
        messageWidgets.add(dateDivider(onlyDate));
        lastMessageDate = onlyDate;
      }
    } catch (_) {}

    messageWidgets.add(chatItemWidget(message, currentUserId, members));
  }

  messageWidgets.add(const SizedBox(height: 6));

  return messageWidgets;
}

Widget chatItemWidget(MessageChannelModel e, String currentUserId, List<UserChatModel> members) {
  bool isMyChat = e.sender == currentUserId;
  final user = members.firstWhere((x) => x.id == currentUserId);
  return e.sender == "0"
      ? systemMessageWidget(e.content ?? '')
      : Padding(
    padding: const EdgeInsets.only(left: TSizes.xs, right: TSizes.xs),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMyChat) userAvatar(e.sender, e.senderCustomer?.fullName ?? "", members),
        if (e.messageType != 'text') messageImageAndName(isMyChat, e.content ?? "", user.fullName ?? ""),
        if (e.messageType == 'text') messageTextAndName(isMyChat, e.content ?? '', user.fullName ?? ""),
        if (isMyChat) messageTime(isMyChat, e),
      ],
    ),
  );
}

Widget systemMessageWidget(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    margin: EdgeInsets.only(top: 8),
    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(25))),
    child: Text(
      text,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
  );
}

Widget userAvatar(String userId, String userName, List<UserChatModel> members) {
  final hash = userId.hashCode;
  final user = members.firstWhere((x) => x.id == userId);
  final color = Color(hash).withOpacity(0.8);

  return Container(
    width: 40,
    height: 40,
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Center(
      child: user.image.isNotEmpty
          ? ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image(
            image: NetworkImage(user.image),
            fit: BoxFit.cover,
          ))
          : Text(
        user.fullName.isNotEmpty ? user.fullName.substring(0, 1).toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget messageTextAndName(bool isMyChat, String messageText, String userName) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.fromLTRB(isMyChat ? 20 : 8, 6, 8, 6),
      child: Column(
        crossAxisAlignment: isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMyChat)
            Text(
              userName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          Container(
            padding: EdgeInsets.fromLTRB(14, isMyChat ? 4 : 10, 14, 8),
            decoration: BoxDecoration(
              color: isMyChat ? Color(0xffebebeb) : Color(0xffedf4ff),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageText,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget messageImageAndName(bool isMyChat, String url, String userName) {
  // Tách phần base64 ra
  // final String base64Data = url.contains(',') ? url.split(',').last : url;
  Uint8List imageBytes;

  if (url.contains(',')) {
    final base64Data = url.split(',').last;
    imageBytes = base64Decode(base64Data);
  } else {
    imageBytes = base64Decode(url); // nếu không có prefix
  }

  return Expanded(
    child: Container(
      margin: EdgeInsets.fromLTRB(isMyChat ? 20 : 8, 6, 8, 6),
      child: Column(
        crossAxisAlignment: isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMyChat)
            Text(
              userName,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          Container(
            // padding: EdgeInsets.fromLTRB(14, isMyChat ? 4 : 10, 14, 8),
            decoration: BoxDecoration(
              color: isMyChat ? const Color(0xffebebeb) : const Color(0xffedf4ff),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                imageBytes,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget messageTime(bool isMyChat, MessageChannelModel e) {
  try {
    final parsedDate = DateTime.parse(e.timestamp).toLocal();

    final timeText = '${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: EdgeInsets.only(
        left: isMyChat ? 0 : TSizes.sm,
        bottom: 12,
        right: isMyChat ? 0 : TSizes.sm,
      ),
      alignment: Alignment.center,
      child: Text(
        timeText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  } catch (e) {
    return Container(
      margin: EdgeInsets.only(
        left: isMyChat ? 48 : 8,
        bottom: 12,
        right: isMyChat ? 0 : 16,
      ),
      alignment: Alignment.center,
      child: const Text(
        '--:--',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}

Widget dateDivider(DateTime date) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            DateFormat('EEEE, dd/MM/yyyy', "vi").format(date),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );
}
