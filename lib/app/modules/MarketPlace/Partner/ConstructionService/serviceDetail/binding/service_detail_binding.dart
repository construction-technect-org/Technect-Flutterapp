import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/controller/service_detail_controller.dart';
import 'package:get/get.dart';

class ServiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceDetailController>(() => ServiceDetailController());
  }
}
