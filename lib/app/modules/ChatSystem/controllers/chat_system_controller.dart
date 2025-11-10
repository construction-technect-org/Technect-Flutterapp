import 'dart:developer';

import 'package:chatview/chatview.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSystemController extends GetxController {
  final ChatUser currentUser = const ChatUser(
    id: '1',
    name: 'You',
    profilePhoto: 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
  );

  final ChatUser supportUser = const ChatUser(
    id: '2',
    name: 'Support',
    profilePhoto: 'https://cdn-icons-png.flaticon.com/512/4712/4712109.png',
  );

  late final ChatController chatController;
  final ImagePicker picker = ImagePicker();
  late final IO.Socket socket;

  int connectionId = 0;
  VoidCallback? onRefresh;
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null){
      connectionId= Get.arguments["cId"];
      onRefresh= Get.arguments["onRefresh"];
    }
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

    socket.connect();

    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: currentUser,
      otherUsers: [supportUser],
    );
  }

  @override
  void onClose() {
    super.onClose();
    socket.dispose();
  }

  void onSendTap(String message, ReplyMessage replyMessage, MessageType type) {
    if (message.trim().isEmpty) return;


    final msg = Message(
      id: DateTime.now().toString(),
      message: message,
      createdAt: DateTime.now(),
      sentBy: currentUser.id,
      messageType: type,
      replyMessage: replyMessage,
    );

    chatController.addMessage(msg);
    socket.emit('send_message', {
      'connection_id': connectionId,
      'message': message,
    });
    onRefresh?.call();
    Future.delayed(const Duration(seconds: 2), () {
      chatController.addMessage(
        Message(
          id: DateTime.now().toString(),
          message: "Thanks for reaching out! We’ll get back shortly.",
          createdAt: DateTime.now(),
          sentBy: supportUser.id,
        ),
      );
    });
  }
}
