import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/vrm/lead_dashboard/mainDashboard/controller/lead_dash_controller.dart';
import 'package:get/get.dart';

class CRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VRMBottomController>(() => VRMBottomController());
    Get.lazyPut<VrmLeadDashController>(() => VrmLeadDashController());
  }
}
