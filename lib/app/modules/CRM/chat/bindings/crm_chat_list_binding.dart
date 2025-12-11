import 'package:construction_technect/app/modules/CRM/chat/controllers/crm_chat_list_controller.dart';
import 'package:get/get.dart';

class CRMChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CRMChatListController>(() => CRMChatListController());
  }
}
