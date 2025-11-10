import 'package:construction_technect/app/modules/ChatSystem/AllChatList/controllers/chat_system_controller.dart';
import 'package:get/get.dart';

class AllChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllChatListController>(() => AllChatListController());
  }
}
