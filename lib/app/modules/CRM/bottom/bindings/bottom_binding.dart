import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/CRM/chat/controllers/crm_chat_list_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/controller/crm_dashboard_controller.dart';
import 'package:get/get.dart';

class CRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CRMBottomController>(() => CRMBottomController());
    Get.lazyPut<CRMDashboardController>(() => CRMDashboardController());
    Get.lazyPut<CRMChatListController>(() => CRMChatListController());

  }
}
