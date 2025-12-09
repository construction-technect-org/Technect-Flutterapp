import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/controller/lead_dash_controller.dart';
import 'package:get/get.dart';

class VRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VRMBottomController>(() => VRMBottomController());
    Get.lazyPut<VrmLeadDashController>(() => VrmLeadDashController());
    Get.lazyPut<CommonController>(() => CommonController());
  }
}
