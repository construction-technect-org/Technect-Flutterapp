import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/controllers/add_service_requirement_controller.dart';
import 'package:get/get.dart';

class AddServiceRequirementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceRequirementController>(
      () => AddServiceRequirementController(),
    );
  }
}
