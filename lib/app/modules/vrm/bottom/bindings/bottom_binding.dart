import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/mainDashboard/controller/lead_dash_controller.dart';
import 'package:get/get.dart';

class VrmBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VrmBottomController>(() => VrmBottomController());
    Get.lazyPut<VrmLeadDashController>(() => VrmLeadDashController());
    Get.lazyPut<CommonController>(() => CommonController());
  }
}
