import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/common/widgets/loader.dart';
import 'package:staff_app/core/common/widgets/show_snackbar.dart';
import 'package:staff_app/core/local_storage/local_storage.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';
import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/usecases/get_list_channel.dart';
import 'package:staff_app/features/chat/domain/usecases/get_user_chat_info.dart';
import 'package:staff_app/features/chat/presentation/bloc/list_channel/list_channel_bloc.dart';
import 'package:staff_app/features/chat/presentation/bloc/user_chat/user_chat_bloc.dart';
import 'package:staff_app/init_dependencies.dart';

class WrapperChatListScreen extends StatefulWidget {
  const WrapperChatListScreen({super.key});

  @override
  State<WrapperChatListScreen> createState() => _WrapperChatListScreenState();
}

class _WrapperChatListScreenState extends State<WrapperChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => ListChannelBloc(getListChannel: serviceLocator()))], child: const ChatListScreen());
  }
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  UserChatModel? userChatModel;
  late int userId;

  @override
  void initState() {
    super.initState();
    _loadLocalData();
    _loadListChat();
  }

  void _loadListChat() {}

  void _loadLocalData() async {
    final jsonUserChat = await LocalStorage.getData(LocalStorageKey.userChat);
    if (jsonUserChat != null && jsonUserChat.isNotEmpty) {
      try {
        userChatModel = UserChatModel.fromJson(jsonDecode(jsonUserChat));
        context.read<ListChannelBloc>().add(GetListChannelEvent(GetListChannelParams(userChatModel!.id)));
        setState(() {});
      } catch (e) {
        debugPrint('Lỗi parsing userChatModel: $e');
        goLoginNotBack();
      }
      return;
    }

    final userJson = await LocalStorage.getData(LocalStorageKey.userKey);
    if (userJson != null && userJson.isNotEmpty) {
      try {
        userId = UserModel.fromJson(jsonDecode(userJson)).userId;
        context.read<UserChatBloc>().add(GetUserChatInfoEvent(GetUserChatInfoParams(userId)));
      } catch (e) {
        goLoginNotBack();
      }
    } else {
      goLoginNotBack();
    }
  }

  // Format timestamp to show relative time
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Vừa xong';
    if (difference.inHours < 1) return '${difference.inMinutes} phút trước';
    if (difference.inDays < 1) return '${difference.inHours} giờ trước';
    if (difference.inDays < 7) return '${difference.inDays} ngày trước';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          "Solace Connect",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocListener<ListChannelBloc, ListChannelState>(
        listener: (context, state) {
          if (state is ListChannelError) {
            AppLogger.error(state.message);
            TSnackBar.errorSnackBar(context, message: state.message);
          }
        },
        child: BlocBuilder<ListChannelBloc, ListChannelState>(
          builder: (context, state) {
            if (state is ListChannelLoaded) {
              return ListView.separated(
                itemCount: state.channels.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final conversation = state.channels[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        conversation.name.substring(0, 1).toUpperCase(), // Lấy ký tự đầu tiên của sender
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      conversation.name, // Dùng sender thay vì `name`
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      "No message", // Hiển thị nội dung tin nhắn gần nhất
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    trailing: Text(
                      "",
                      // conversatio, // Hiển thị thời gian
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    onTap: () {
                      if (userChatModel?.id != null) {
                        goChatRoom(conversation.id, userChatModel!.id);
                      } else {
                        TSnackBar.errorSnackBar(context, message: "Lỗi không xác định");
                      }
                    },
                  );
                },
              );
              ;
            } else if (state is ListChannelLoading) {
              return const TLoader();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
