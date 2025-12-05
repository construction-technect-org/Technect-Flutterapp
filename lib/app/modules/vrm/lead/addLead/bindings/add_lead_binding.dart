import 'package:construction_technect/app/modules/CRM/lead/addLead/controller/add_lead_controller.dart';
import 'package:get/get.dart';

class AddLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLeadController>(
      () => AddLeadController(),
    );
  }
}
