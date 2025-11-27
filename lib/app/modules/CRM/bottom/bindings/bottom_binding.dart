import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/controller/lead_dash_controller.dart';
import 'package:get/get.dart';

class CRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CRMBottomController>(() => CRMBottomController());
    Get.lazyPut<LeadDashController>(() => LeadDashController());
  }
}
