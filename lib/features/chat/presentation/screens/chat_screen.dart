import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/common/screens/error_screen.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';
import 'package:staff_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:staff_app/features/chat/presentation/bloc/list_message/list_message_bloc.dart';
import 'package:staff_app/features/chat/presentation/widgets/chat_message_list.dart';
import 'package:staff_app/features/chat/presentation/widgets/chat_type_message.dart';
import 'package:staff_app/init_dependencies.dart';

class WrapperChatRoom extends StatelessWidget {
  const WrapperChatRoom({super.key, required this.channelId});

  final String channelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListMessageBloc(getListMessage: serviceLocator()),
      child: ChatScreen(channelId: channelId),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.channelId});

  final String channelId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserChatModel? userChatModel;
  late ChatBloc chatBloc;
  ScrollController chatListScrollController = ScrollController();
  TextEditingController messageTextController = TextEditingController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatListScrollController.hasClients) {
        chatListScrollController.animateTo(
          chatListScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutSine,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    chatBloc = ChatBloc(
      getMessages: serviceLocator(),
      sendMessage: serviceLocator(),
      connect: serviceLocator(),
      disconnect: serviceLocator(),
    );
    chatBloc.add(ChatConnectEvent());
    context.read<ListMessageBloc>().add(GetListMessageEvent(GetListMessageParams(widget.channelId)));
    _scrollToBottom();
  }

  void _loadLocalData() async {
    final jsonUserChat = await LocalStorage.getData(LocalStorageKey.userChat);
    if (jsonUserChat != null && jsonUserChat.isNotEmpty) {
      try {
        userChatModel = UserChatModel.fromJson(jsonDecode(jsonUserChat));
      } catch (e) {
        debugPrint('Lỗi parsing userChatModel: $e');
        goLoginNotBack();
      }
      return;
    }
  }

  @override
  void dispose() {
    chatBloc.add(ChatDisconnectEvent());
    chatListScrollController.dispose();
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            TSnackBar.errorSnackBar(context, message: state.error);
            AppLogger.info(state.error);
          }

          if (state is ChatLoaded && state.messages.isNotEmpty) {
            final latestMessage = state.messages.last;
            AppLogger.info(state.messages);
            context.read<ListMessageBloc>().add(ListMessageNewMessageEvent(latestMessage));
            _scrollToBottom();
          }
        },
        child: Scaffold(
          appBar: TAppbar(showBackArrow: true),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              BlocBuilder<ListMessageBloc, ListMessageState>(
                builder: (context, state) {
                  if (state is ListMessageLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ListMessageError) {
                    return Center(child: Text(state.message));
                  } else if (state is ListMessageLoaded) {
                    _scrollToBottom();
                    final sortedMessages = state.messages..sort((a, b) => a.timestamp.compareTo(b.timestamp));
                    return chatMessageWidget(chatListScrollController, sortedMessages, userChatModel?.id ?? "");
                  }
                  return TErrorBody();
                },
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: TSizes.sm,
              right: TSizes.sm,
              top: TSizes.sm,
              bottom: MediaQuery.of(context).viewInsets.bottom + TSizes.sm,
            ),
            child: chatTypeMessageWidget(messageTextController, () {
              chatBloc.add(ChatSendMessageEvent(
                SendMessageParams(
                  channelId: widget.channelId,
                  senderId: userChatModel?.id ?? "",
                  content: messageTextController.text.trim(),
                ),
              ));

              messageTextController.clear();
            }, () => _scrollToBottom()),
          ),
        ),
      ),
    );
  }
}
