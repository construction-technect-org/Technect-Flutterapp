import 'package:get/get.dart';
import 'package:construction_technect/app/modules/ServiceDetail/controllers/service_detail_controller.dart';

class ServiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceDetailsController>(() => ServiceDetailsController());
  }
}
