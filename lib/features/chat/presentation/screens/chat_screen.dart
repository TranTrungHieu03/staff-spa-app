import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/common/screens/error_screen.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:staff_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:staff_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:staff_app/features/chat/domain/usecases/connect_hub.dart';
import 'package:staff_app/features/chat/domain/usecases/disconnect_hub.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_message.dart';
import 'package:staff_app/features/chat/domain/usecases/get_message.dart';
import 'package:staff_app/features/chat/domain/usecases/send_message.dart';
import 'package:staff_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:staff_app/features/chat/presentation/bloc/list_message/list_message_bloc.dart';
import 'package:staff_app/features/chat/presentation/widgets/chat_message_list.dart';
import 'package:staff_app/features/chat/presentation/widgets/chat_type_message.dart';
import 'package:staff_app/init_dependencies.dart';

class WrapperChatRoom extends StatelessWidget {
  const WrapperChatRoom({super.key, required this.channelId, required this.userId});

  final String channelId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListMessageBloc(getListMessage: serviceLocator()),
      child: ChatScreen(
        channelId: channelId,
        userId: userId,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.channelId, required this.userId});

  final String channelId;
  final String userId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatBloc chatBloc;
  ScrollController chatListScrollController = ScrollController();
  TextEditingController messageTextController = TextEditingController();

  void _scrollToBottom() {
    // if (!chatListScrollController.hasClients) return;
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

    // Initialize chatBloc first

    // Load local data
    _loadLocalData();
    _initAiChat(widget.userId);
    chatBloc = ChatBloc(
      getMessages: serviceLocator(),
      sendMessage: serviceLocator(),
      connect: serviceLocator(),
      disconnect: serviceLocator(),
    );
    context.read<ListMessageBloc>().add(GetListMessageEvent(GetListMessageParams(widget.channelId)));

    chatBloc.add(ChatConnectEvent());
    // context.read<ChatBloc>().add(StartListeningEvent());
    _scrollToBottom();
  }

  void _loadLocalData() async {}

  Future<void> _initAiChat(String userId) async {
    if (serviceLocator.isRegistered<ChatRemoteDataSource>()) {
      serviceLocator.unregister<ChatRemoteDataSource>();
    }
    if (serviceLocator.isRegistered<ChatRepository>()) {
      serviceLocator.unregister<ChatRepository>();
    }
    if (serviceLocator.isRegistered<SendMessage>()) {
      serviceLocator.unregister<SendMessage>();
    }
    if (serviceLocator.isRegistered<GetMessages>()) {
      serviceLocator.unregister<GetMessages>();
    }
    if (serviceLocator.isRegistered<ConnectHub>()) {
      serviceLocator.unregister<ConnectHub>();
    }
    if (serviceLocator.isRegistered<DisconnectHub>()) {
      serviceLocator.unregister<DisconnectHub>();
    }
    if (serviceLocator.isRegistered<ChatBloc>()) {
      serviceLocator.unregister<ChatBloc>();
    }
    serviceLocator
      ..registerLazySingleton<ChatRemoteDataSource>(
        () => SignalRChatRemoteDataSource(
          hubUrl: "https://solaceapi.ddnsking.com/chat",
          userId: userId,
        ),
      )
      ..registerFactory<ChatRepository>(
        () => ChatRepositoryImpl(serviceLocator<ChatRemoteDataSource>()),
      )
      ..registerLazySingleton<SendMessage>(
        () => SendMessage(serviceLocator<ChatRepository>()),
      )
      ..registerLazySingleton<ConnectHub>(
        () => ConnectHub(serviceLocator<ChatRepository>()),
      )
      ..registerLazySingleton<DisconnectHub>(
        () => DisconnectHub(serviceLocator<ChatRepository>()),
      )
      ..registerLazySingleton<GetMessages>(
        () => GetMessages(serviceLocator<ChatRepository>()),
      )
      ..registerLazySingleton<ChatBloc>(
        () => ChatBloc(
          getMessages: serviceLocator<GetMessages>(),
          sendMessage: serviceLocator<SendMessage>(),
          connect: serviceLocator<ConnectHub>(),
          disconnect: serviceLocator<DisconnectHub>(),
        ),
      );
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
          }

          if (state is ChatLoaded && state.messages.isNotEmpty) {
            final latestMessage = state.messages.last;
            context.read<ListMessageBloc>().add(ListMessageNewMessageEvent(latestMessage));
            _scrollToBottom();
          }
        },
        child: Scaffold(
          appBar: const TAppbar(showBackArrow: true),
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
                    return chatMessageWidget(chatListScrollController, sortedMessages, widget.userId);
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
                  senderId: widget.userId,
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
