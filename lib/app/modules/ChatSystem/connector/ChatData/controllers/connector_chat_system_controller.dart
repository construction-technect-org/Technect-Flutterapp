import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/model/connector_chat_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/service/connector_chat_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConnectorChatSystemController extends GetxController {
  Rx<ChatListModel> chatListModel = ChatListModel().obs;
  RxBool isLoading = false.obs;

  late CustomUser currentUser;
  late CustomUser supportUser;

  final RxList<CustomMessage> messages = <CustomMessage>[].obs;
  final ScrollController scrollController = ScrollController();

  final ImagePicker picker = ImagePicker();
  late final IO.Socket socket;
  int connectionId = 0;
  String name = "User";
  String image = "";
  VoidCallback? onRefresh;

  @override
  void onInit() {
    super.onInit();

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

    fetchChatList();

    _initSocket();
  }

  /// Fetch chat history
  Future<void> fetchChatList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? true;

      final result = await ConnectorChatServices().allChatList(
        cId: connectionId,
      );

      if (result.success == true) {
        chatListModel.value = result;

        final firstMessage = result.chatData?.isNotEmpty == true
            ? result.chatData!.first
            : null;

        if (firstMessage != null) {
          final isSenderMe =
              firstMessage.senderUserId == myPref.userModel.val["id"];
          final otherId = isSenderMe
              ? firstMessage.receiverUserId
              : firstMessage.senderUserId;

          supportUser = CustomUser(
            id: otherId?.toString() ?? '',
            name: name,
            profilePhoto: image,
          );
        }

        final fetchedMessages =
            result.chatData?.map((msg) {
              final isSentByMe = msg.senderUserId == myPref.userModel.val["id"];
              return CustomMessage(
                id: msg.id.toString(),
                message: msg.messageText ?? '',
                createdAt: DateTime.parse(
                  msg.createdAt ?? DateTime.now().toIso8601String(),
                ),
                sentBy: isSentByMe ? currentUser.id : supportUser.id,
                status: msg.isRead == true
                    ? MessageStatus.read
                    : MessageStatus.delivered,
                type: msg.messageType,
                mediaUrl: msg.messageMediaUrl,
              );
            }).toList() ??
            [];

        messages.assignAll(fetchedMessages);
      }
    } catch (e) {
      log('❌ Error fetching chat list: $e');
    } finally {
      isLoading.value = false;
      if (messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _jumpToBottom();
        });
      }
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
      if (kDebugMode) log('🟢 messages marked as read: $data');
    });
    socket.on('messages_read', (data) {
      if (kDebugMode) log('🟢 Your messages were read: $data');

      _markAllMessagesAsRead();
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
          createdAt: DateTime.parse(
            chatData.createdAt ?? DateTime.now().toIso8601String(),
          ),
          sentBy: isSentByMe ? currentUser.id : supportUser.id,
          status: chatData.isRead == true
              ? MessageStatus.read
              : MessageStatus.delivered,
          type: chatData.messageType,
          mediaUrl: chatData.messageMediaUrl,
        );

        messages.add(newMessage);
        _scrollToBottom();
        socket.emit('mark_messages_read', {"connection_id": connectionId});
      } catch (e, st) {
        log('❌ Error parsing new message: $e');
        log(st.toString());
      }
    });

    socket.connect();
  }

  void _jumpToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _markAllMessagesAsRead() {
    final updatedMessages = messages.map((msg) {
      if (msg.sentBy == currentUser.id && msg.status != MessageStatus.read) {
        return msg.copyWith(status: MessageStatus.read);
      }
      return msg;
    }).toList();

    messages.assignAll(updatedMessages);
    if (kDebugMode) {
      log(
        '✅ Marked ${updatedMessages.where((m) => m.status == MessageStatus.read && m.sentBy == currentUser.id).length} messages as read',
      );
    }
  }

  void onSendTap(String message) {
    if (message.trim().isEmpty) return;

    socket.emit('send_message', {
      'connection_id': connectionId,
      'message': message,
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  Future<void> sendImageFromGallery() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      log("🖼️ Image selected from gallery: $filePath");
      _scrollToBottom();

      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      socket.emit('send_message', {
        'connection_id': connectionId,
        "message_type": "image",
        'message': "Photo",
        "media_base64": base64Image,
        'media_url': filePath,
      });
      log("📤 Sent image message via socket");
    } catch (e) {
      log("❌ Error selecting/sending image: $e");
    }
  }

  Future<void> sendImageFromCamera() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (pickedFile == null) return;

      final filePath = pickedFile.path;
      log("📸 Image captured from camera: $filePath");
      _scrollToBottom();

      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      socket.emit('send_message', {
        'connection_id': connectionId,
        "message_type": "image",
        'message': "Photo",
        "media_base64": base64Image,
        'media_url': filePath,
      });
      log("📤 Sent image message via socket");
    } catch (e) {
      log("❌ Error capturing/sending image: $e");
    }
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

  const CustomUser({
    required this.id,
    required this.name,
    required this.profilePhoto,
  });
}

enum MessageStatus { sending, sent, delivered, read }

class CustomMessage {
  final String id;
  final String message;
  final String sentBy;
  final DateTime createdAt;
  final MessageStatus status;
  final String? type;
  final String? mediaUrl;

  CustomMessage({
    required this.id,
    required this.message,
    required this.sentBy,
    required this.createdAt,
    this.status = MessageStatus.sent,
    this.type = 'text',
    this.mediaUrl,
  });

  CustomMessage copyWith({
    String? id,
    String? message,
    String? sentBy,
    DateTime? createdAt,
    MessageStatus? status,
    String? type,
    String? mediaUrl,
  }) {
    return CustomMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      sentBy: sentBy ?? this.sentBy,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }
}
