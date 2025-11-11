import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/service/all_chat_service.dart';
class ConnectorAllChatListController extends GetxController {
  final RxList<Map<String, dynamic>> chatList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchWishList(isLoad: true);

    });
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
  Rx<ConnectorAllChatListModel> chatListModel = ConnectorAllChatListModel().obs;

  RxBool isLoading = false.obs;

  Future<void> fetchWishList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      final result = await ConnectorAllChatListServices().allChatList();
      if (result.success == true) {
        chatListModel.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

}
