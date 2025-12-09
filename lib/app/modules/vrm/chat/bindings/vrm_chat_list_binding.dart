import 'package:construction_technect/app/modules/vrm/chat/controllers/vrm_chat_list_controller.dart';
import 'package:get/get.dart';

class VRMChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VRMChatListController>(() => VRMChatListController());
  }
}
