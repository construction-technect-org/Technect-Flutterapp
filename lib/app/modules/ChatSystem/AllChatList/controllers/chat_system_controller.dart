import 'package:construction_technect/app/core/utils/imports.dart';

class AllChatListController extends GetxController {
  final RxList<Map<String, dynamic>> chatList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  void loadChats() {
    chatList.value = [
      {
        "id": "2",
        "name": "Support",
        "profilePhoto": "https://cdn-icons-png.flaticon.com/512/4712/4712109.png",
        "lastMessage": "Thanks for reaching out!",
        "time": "12:45 PM",
        "unreadCount": 2,
      },
      {
        "id": "3",
        "name": "Project Team",
        "profilePhoto": "https://cdn-icons-png.flaticon.com/512/847/847969.png",
        "lastMessage": "Please check the blueprint update.",
        "time": "Yesterday",
        "unreadCount": 0,
      },
    ];
  }
}
