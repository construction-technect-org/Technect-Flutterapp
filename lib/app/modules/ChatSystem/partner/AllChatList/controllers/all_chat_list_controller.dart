import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/partner/AllChatList/model/all_chat_list_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/partner/AllChatList/service/all_chat_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllChatListController extends GetxController {
  late final IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    _initSocket();
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchChatList(isLoad: true);
    });
  }

  Rx<AllChatListModel> chatListModel = AllChatListModel().obs;

  RxBool isLoading = false.obs;

  Future<void> fetchChatList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      final result = await AllChatListServices().allChatList();
      if (result.success == true) {
        chatListModel.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _initSocket() {
    socket = IO.io(
      'http://43.205.117.97',
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .disableAutoConnect()
          .setPath('/socket.io/')
          .setQuery({'token': myPref.getToken()})
          .enableForceNew()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(1000)
          .build(),
    );

    socket.onConnect((_) {
      log('✅ Connected to socket server - ID: ${socket.id}');
    });

    socket.onConnectError((data) {
      log('❌ Socket Connect Error: $data');
    });

    socket.onDisconnect((reason) {
      log('🔌 Socket Disconnected: $reason');
    });

    socket.on('conversation_update', (data) {
      if (kDebugMode) {
        log('🔔 Conversation Update: $data');
      }
      _updateConversationList(data);
    });

    socket.connect();
  }

  void _updateConversationList(dynamic data) {
    try {
      if (data == null) return;

      final int connectionId = data['connection_id'];
      final String? lastMessage = data['last_message'];
      final String? lastMessageTime = data['last_message_time'];
      final int? unreadCount = data['unread_count'];

      final conversations = chatListModel.value.chats?.conversations ?? [];
      final index = conversations.indexWhere(
        (conv) => conv.connectionId == connectionId,
      );

      if (index != -1) {
        final conversation = conversations[index];

        conversation.chatInfo = ChatInfo(
          lastMessage: lastMessage ?? conversation.chatInfo?.lastMessage,
          lastMessageTime:
              lastMessageTime ?? conversation.chatInfo?.lastMessageTime,
          unreadCount: unreadCount ?? conversation.chatInfo?.unreadCount ?? 0,
        );

        conversations.removeAt(index);
        conversations.insert(0, conversation);

        chatListModel.value = AllChatListModel(
          success: chatListModel.value.success,
          chats: Chats(
            conversations: conversations,
            totalConversations: chatListModel.value.chats?.totalConversations,
            enabledChats: chatListModel.value.chats?.enabledChats,
          ),
          message: chatListModel.value.message,
        );

        if (kDebugMode) {
          log('✅ Updated conversation $connectionId - Unread: $unreadCount');
        }
      }
    } catch (e, st) {
      log('❌ Error updating conversation: $e');
      log(st.toString());
    }
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}
