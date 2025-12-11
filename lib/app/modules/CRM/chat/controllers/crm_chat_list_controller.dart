import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/chat/model/crm_chat_list_model.dart';
import 'package:construction_technect/app/modules/CRM/chat/service/crm_chat_list_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CRMChatListController extends GetxController {
  late final IO.Socket socket;

  Rx<AllCRMGroupChatListModel> chatListModel = AllCRMGroupChatListModel().obs;
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
      final result = await CRMChatListServices().allChatList();
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

      final int groupId = data['group_id'];
      final String? lastMessage = data['last_message'];
      final String? lastMessageTime = data['last_message_time'];
      final int? unreadCount = data['unread_count'];


      final conversations = chatListModel.value.data?.groups ?? [];
      final index = conversations.indexWhere((conv) => conv.groupId == groupId);

      if (index != -1) {
        final conversation = conversations[index];
        conversation.lastMessage= lastMessage;
        conversation.lastMessageTime= lastMessageTime;
        conversation.lastMessage= lastMessage;
        conversation.unreadCount= unreadCount;
        conversations.removeAt(index);
        conversations.insert(0, conversation);
        chatListModel.refresh();
        if (kDebugMode) {
          log('✅ VRM Updated conversation $groupId - Unread: $unreadCount');
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
