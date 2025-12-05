import 'package:construction_technect/app/modules/vrm/lead_dashboard/marketing/controller/marketing_controller.dart';
import 'package:get/get.dart';

class MarketingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketingController>(() => MarketingController());
  }
}
