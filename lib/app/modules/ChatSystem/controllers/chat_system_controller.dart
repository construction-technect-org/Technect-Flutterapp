import 'package:chatview/chatview.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void onInit() {
    super.onInit();
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: currentUser,
      otherUsers: [supportUser],
    );
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
