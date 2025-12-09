import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/chat/controllers/vrm_chat_list_controller.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/controller/vrm_dashboard_controller.dart';
import 'package:get/get.dart';

class VRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VRMBottomController>(() => VRMBottomController());
    Get.lazyPut<VRMDashboardController>(() => VRMDashboardController());
    Get.lazyPut<VRMChatListController>(() => VRMChatListController());
    Get.lazyPut<CommonController>(() => CommonController());
  }
}
