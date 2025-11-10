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
  final IO.Socket socket = IO.io(
    'http://43.205.117.97', // Base URL only
    IO.OptionBuilder()
        .setTransports(['websocket']) // Flutter needs websocket transport
        .setQuery({'token': myPref.token}) // Send token properly
        .enableAutoConnect() // optional: auto-connect
        .build(),
  );

  @override
  void onInit() {
    super.onInit();
    socket.connect(); // 👈 Important!

    socket.onConnect((_) {
      print('✅ Connected to socket server');
      socket.emit('msg', 'test');
    });

    socket.onConnectError((data) {
      print('❌ Connect Error: $data');
    });

    socket.onError((data) {
      print('⚠️ Socket Error: $data');
    });

    socket.onDisconnect((_) {
      print('🔌 Disconnected from socket');
    });

    socket.on('event', (data) => print('📩 Event: $data'));
    socket.on('fromServer', (data) => print('📨 fromServer: $data'));
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: currentUser,
      otherUsers: [supportUser],
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
