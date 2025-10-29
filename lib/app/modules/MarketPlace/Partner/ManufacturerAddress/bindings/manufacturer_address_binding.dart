import 'package:get/get.dart';
import '../controller/manufacturer_address_controller.dart';

class ManufacturerAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManufacturerAddressController>(
      () => ManufacturerAddressController(),
    );
  }
}
