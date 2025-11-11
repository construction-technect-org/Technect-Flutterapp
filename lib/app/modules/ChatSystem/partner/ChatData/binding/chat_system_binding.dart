import 'package:construction_technect/app/modules/ChatSystem/partner/ChatData/controllers/chat_system_controller.dart';
import 'package:get/get.dart';

class ChatSystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatSystemController>(() => ChatSystemController());
  }
}
