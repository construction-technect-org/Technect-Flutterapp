import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/controller/manufacturer_address_controller.dart';
import 'package:get/get.dart';

class ManufacturerAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManufacturerAddressController>(() => ManufacturerAddressController());
  }
}
