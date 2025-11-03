import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/controller/add_service_controller.dart';
import 'package:get/get.dart';

class AddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceController>(() => AddServiceController());
  }
}
