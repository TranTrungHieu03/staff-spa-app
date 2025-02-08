import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class ChatAiScreen extends StatefulWidget {
  const ChatAiScreen({super.key});

  @override
  State<ChatAiScreen> createState() => _ChatAiScreenState();
}

class _ChatAiScreenState extends State<ChatAiScreen> {
  final _messageController = TextEditingController();
  final List<Map<String, String>> messages = [
    {"text": "Hello! How can I assist you today?", "isUser": "false"},
    {"text": "Hi! I need help with my booking.", "isUser": "true"},
    {"text": "Sure! What is the booking number?", "isUser": "false"},
    {"text": "It's 12345.", "isUser": "true"},
    {
      "text": "Alright, I found it. How can I assist you with it?",
      "isUser": "false"
    },
    {"text": "I need to reschedule it.", "isUser": "true"},
    {
      "text": "No problem. I will update the schedule for you.",
      "isUser": "false"
    },
    {"text": "Thank you!", "isUser": "true"},
    {"text": "You're welcome!", "isUser": "false"},
    {"text": "Have a great day!", "isUser": "true"},
  ];
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          "Chat AI",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: TColors.black),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(TSizes.sm),
          child: Column(
            children: messages.map((message) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: TSizes.xs),
                child: Row(
                  mainAxisAlignment: message['isUser'] == 'true'
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: message['isUser'] == 'true'
                            ? TColors.primary
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth:
                            THelperFunctions.screenWidth(context) * 0.85),
                        child: Text(
                          message['text']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        padding: EdgeInsets.only(
          left: TSizes.sm,
          right: TSizes.sm,
          top: TSizes.sm,
          bottom: MediaQuery.of(context).viewInsets.bottom + TSizes.sm,
        ),
        child: TRoundedContainer(
          padding: EdgeInsets.all(TSizes.sm),
          shadow: true,
          child: Row(
            children: [
              TRoundedIcon(
                onPressed: () {
                  setState(() {
                    messages.add({
                      "text": _messageController.text,
                      "isUser": "true",
                    });
                    _messageController.clear();
                    FocusScope.of(context).unfocus();
                    _scrollToBottom();
                  });
                },
                icon: Iconsax.image,
                backgroundColor: TColors.primary.withOpacity(0.7),
              ),
              const SizedBox(
                width: TSizes.sm,
              ),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter your message ...",
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: TSizes.sm),
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      messages.add({
                        "text": _messageController.text,
                        "isUser": "true",
                      });
                      _messageController.clear();
                      _scrollToBottom();
                    });
                  },
                ),
              ),
              const SizedBox(
                width: TSizes.sm,
              ),
              TRoundedIcon(
                onPressed: () {
                  setState(() {
                    messages.add({
                      "text": _messageController.text,
                      "isUser": "true",
                    });
                    _messageController.clear();
                    FocusScope.of(context).unfocus();
                    _scrollToBottom();
                  });
                },
                icon: Iconsax.send_2,
                backgroundColor: TColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }
}
