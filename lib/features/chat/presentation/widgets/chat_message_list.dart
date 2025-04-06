import 'package:flutter/material.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/chat/data/models/message_channel_model.dart';

Widget chatMessageWidget(ScrollController chatListScrollController, List<MessageChannelModel> messages, String currentUserId) {
  return Expanded(
      child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: chatListScrollController,
            child: Column(
              children: [
                ...messages.map((e) => chatItemWidget(e, currentUserId)),
                const SizedBox(
                  height: 6,
                )
              ],
            ),
          )));
}

Widget chatItemWidget(MessageChannelModel e, String currentUserId) {
  bool isMyChat = e.sender == currentUserId;

  return e.sender == "0"
      ? systemMessageWidget(e.content ?? '')
      : Padding(
          padding: const EdgeInsets.only(left: TSizes.xs, right: TSizes.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMyChat) userAvatar(e.sender, e.senderCustomer?.fullName ?? "User"),
              messageTextAndName(isMyChat, e.content ?? '', e.senderCustomer?.fullName ?? "User"),
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

Widget userAvatar(String userId, String userName) {
  final hash = userId.hashCode;
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
      child: Text(
        userName.isNotEmpty ? userName.substring(0, 1).toUpperCase() : '?',
        style: TextStyle(
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
          // if (!isMyChat)
          //   Text(
          //     userName,
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 13,
          //     ),
          //   ),
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
