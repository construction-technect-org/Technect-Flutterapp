import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/controllers/construction_service_controller.dart';
import 'package:get/get.dart';

class ConstructionServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConstructionServiceController>(
      () => ConstructionServiceController(),
    );
  }
}
