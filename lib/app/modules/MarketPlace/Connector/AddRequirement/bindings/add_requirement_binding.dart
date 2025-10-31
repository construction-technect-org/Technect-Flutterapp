import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/controllers/add_requirement_controller.dart';
import 'package:get/get.dart';

class AddRequirementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRequirementController>(() => AddRequirementController());
  }
}
