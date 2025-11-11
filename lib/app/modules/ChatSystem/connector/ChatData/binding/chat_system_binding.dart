import 'package:construction_technect/app/modules/ChatSystem/connector/ChatData/controllers/chat_system_controller.dart';
import 'package:get/get.dart';

class ConnectorChatSystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorChatSystemController>(() => ConnectorChatSystemController());
  }
}
