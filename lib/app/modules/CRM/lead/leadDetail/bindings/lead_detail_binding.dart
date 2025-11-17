import 'package:construction_technect/app/modules/CRM/lead/leadDetail/controller/lead_detail_controller.dart';
import 'package:get/get.dart';

class LeadDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadDetailController>(() => LeadDetailController());
  }
}
