import 'dart:developer';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/model/chat_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/service/chat_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConnectorChatSystemController extends GetxController {
  /// Chat list model
  Rx<ChatListModel> chatListModel = ChatListModel().obs;
  RxBool isLoading = false.obs;

  /// Chat user info
  late CustomUser currentUser;
  late CustomUser supportUser;

  /// Chat messages
  final RxList<CustomMessage> messages = <CustomMessage>[].obs;
  final ScrollController scrollController = ScrollController();

  /// Others
  final ImagePicker picker = ImagePicker();
  late final IO.Socket socket;
  int connectionId = 0;
  String name = "User";
  String image = "";
  VoidCallback? onRefresh;

  @override
  void onInit() {
    super.onInit();

    /// Get arguments from navigation
    if (Get.arguments != null) {
      connectionId = Get.arguments["cId"];
      onRefresh = Get.arguments["onRefresh"];
      name = Get.arguments["name"];
      image = Get.arguments["image"];

      currentUser = CustomUser(
        id: myPref.userModel.val["id"].toString(),
        name: name,
        profilePhoto: image,
      );
    }

    supportUser = const CustomUser(id: '', name: '', profilePhoto: '');

    /// Load chat
    fetchChatList();

    /// Initialize socket
    _initSocket();
  }

  /// Fetch chat history
  Future<void> fetchChatList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? true;

      final result = await ConnectorChatServices().allChatList(cId: connectionId);

      if (result.success == true) {
        chatListModel.value = result;

        final firstMessage = result.chatData?.isNotEmpty == true ? result.chatData!.first : null;

        if (firstMessage != null) {
          final isSenderMe = firstMessage.senderUserId == myPref.userModel.val["id"];
          final otherId = isSenderMe ? firstMessage.receiverUserId : firstMessage.senderUserId;

          supportUser = CustomUser(id: otherId?.toString() ?? '', name: name, profilePhoto: image);
        }

        final fetchedMessages =
            result.chatData?.map((msg) {
              final isSentByMe = msg.senderUserId == myPref.userModel.val["id"];
              return CustomMessage(
                id: msg.id.toString(),
                message: msg.messageText ?? '',
                createdAt: DateTime.parse(msg.createdAt ?? DateTime.now().toIso8601String()),
                sentBy: isSentByMe ? currentUser.id : supportUser.id,
                status: msg.isRead == true ? MessageStatus.read : MessageStatus.delivered,
              );
            }).toList() ??
            [];

        // fetchedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        messages.assignAll(fetchedMessages);
        _scrollToBottom();
      }
    } catch (e) {
      log('❌ Error fetching chat list: $e');
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
      socket.emit('join_connection', {"connection_id": connectionId});
    });

    socket.onConnectError((data) {
      log('❌ Socket Connect Error: $data');
    });

    socket.onDisconnect((reason) {
      log('🔌 Socket Disconnected: $reason');
    });

    socket.on('joined_connection', (data) {
      if (kDebugMode) log('🟢 Joined Connection: $data');
      socket.emit('mark_messages_read', {"connection_id": connectionId});
    });
    socket.on('messages_marked_read', (data) {
      if (kDebugMode) log('🟢 messages read: $data');

      // {
      //   success: true,
      //   connection_id: 10,
      //   count: 5,
      //   read_at: "2025-11-11T10:45:00.000Z"
      // }
    });
    socket.on('messages_read', (data) {
      if (kDebugMode) log('🟢 Your messages were read: $data');

      // Update UI to show read status (e.g., show double checkmark)
      // You can update message read status here
    });

    socket.on('new_message', (data) {
      log("📩 New Message Received: $data");
      try {
        if (data == null || data['data'] == null) return;

        final chatData = ChatData.fromJson(data['data']);
        final isSentByMe = chatData.senderUserId == myPref.userModel.val["id"];

        final newMessage = CustomMessage(
          id: chatData.id.toString(),
          message: chatData.messageText ?? '',
          createdAt: DateTime.parse(chatData.createdAt ?? DateTime.now().toIso8601String()),
          sentBy: isSentByMe ? currentUser.id : supportUser.id,
          status: chatData.isRead == true ? MessageStatus.read : MessageStatus.delivered,
        );

        messages.add(newMessage);
        _scrollToBottom();
      } catch (e, st) {
        log('❌ Error parsing new message: $e');
        log(st.toString());
      }
    });

    socket.connect();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  /// Send message
  void onSendTap(String message) {
    if (message.trim().isEmpty) return;
    //
    // final tempMessage = CustomMessage(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   message: message,
    //   createdAt: DateTime.now(),
    //   sentBy: currentUser.id,
    //   status: MessageStatus.sending,
    // );

    // messages.add(tempMessage);
    _scrollToBottom();

    socket.emit('send_message', {'connection_id': connectionId, 'message': message});

    onRefresh?.call();
  }

  @override
  void onClose() {
    socket.emit('leave_connection', {"connection_id": connectionId});
    socket.dispose();
    super.onClose();
  }
}

class CustomUser {
  final String id;
  final String name;
  final String profilePhoto;

  const CustomUser({required this.id, required this.name, required this.profilePhoto});
}

enum MessageStatus { sending, sent, delivered, read }

class CustomMessage {
  final String id;
  final String message;
  final String sentBy;
  final DateTime createdAt;
  final MessageStatus status;

  CustomMessage({
    required this.id,
    required this.message,
    required this.sentBy,
    required this.createdAt,
    this.status = MessageStatus.sent,
  });
}
