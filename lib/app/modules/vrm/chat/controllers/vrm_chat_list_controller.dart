import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';
import 'package:construction_technect/app/modules/vrm/chat/service/vrm_chat_list_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VRMChatListController extends GetxController {
  late final IO.Socket socket;

  Rx<ConnectorAllChatListModel> chatListModel = ConnectorAllChatListModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchChatList(isLoad: true);
    });
  }

  Future<void> fetchChatList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      final result = await VRMChatListServices().allChatList();
      if (result.success == true) {
        chatListModel.value = result;
      }
    } catch (e) {
      if (kDebugMode) log('Error fetching VRM chat list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _initSocket() {
    socket = IO.io(
      'https://constructiontechnect.com',
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
      log('✅ VRM Socket Connected - ID: ${socket.id}');
    });

    socket.onConnectError((data) {
      log('❌ VRM Socket Connect Error: $data');
    });

    socket.onDisconnect((reason) {
      log('🔌 VRM Socket Disconnected: $reason');
    });

    socket.on('conversation_update', (data) {
      if (kDebugMode) {
        log('🔔 VRM Conversation Update: $data');
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
      final index = conversations.indexWhere((conv) => conv.connectionId == connectionId);

      if (index != -1) {
        final conversation = conversations[index];

        conversation.chatInfo = ChatInfo(
          lastMessage: lastMessage ?? conversation.chatInfo?.lastMessage,
          lastMessageTime: lastMessageTime ?? conversation.chatInfo?.lastMessageTime,
          unreadCount: unreadCount ?? conversation.chatInfo?.unreadCount ?? 0,
        );

        conversations.removeAt(index);
        conversations.insert(0, conversation);

        chatListModel.value = ConnectorAllChatListModel(
          success: chatListModel.value.success,
          chats: Chats(
            conversations: conversations,
            totalConversations: chatListModel.value.chats?.totalConversations,
            enabledChats: chatListModel.value.chats?.enabledChats,
          ),
          message: chatListModel.value.message,
        );

        if (kDebugMode) {
          log('✅ VRM Updated conversation $connectionId - Unread: $unreadCount');
        }
      }
    } catch (e, st) {
      log('❌ Error updating VRM conversation: $e');
      log(st.toString());
    }
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}
