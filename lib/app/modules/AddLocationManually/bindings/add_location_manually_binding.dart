import 'package:construction_technect/app/modules/AddLocationManually/controller/add_location_manually_controller.dart';
import 'package:get/get.dart';

class AddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLocationController>(() => AddLocationController());
  }
}
