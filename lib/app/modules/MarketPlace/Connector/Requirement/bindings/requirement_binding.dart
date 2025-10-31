import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/controllers/requirement_controller.dart';
import 'package:get/get.dart';

class RequirementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequirementController>(() => RequirementController());
  }
}
