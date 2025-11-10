import 'package:construction_technect/app/modules/ChatSystem/AllChatList/controllers/all_chat_list_controller.dart';
import 'package:get/get.dart';

class AllChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllChatListController>(() => AllChatListController());
  }
}
