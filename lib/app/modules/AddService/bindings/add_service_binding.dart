import 'package:get/get.dart';
import 'package:construction_technect/app/modules/AddService/controllers/add_service_controller.dart';

class AddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceController>(() => AddServiceController());
  }
}
