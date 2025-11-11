import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/controllers/controller_all_chat_list_controller.dart';
import 'package:get/get.dart';

class ConnectorAllChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorAllChatListController>(
      () => ConnectorAllChatListController(),
    );
  }
}
