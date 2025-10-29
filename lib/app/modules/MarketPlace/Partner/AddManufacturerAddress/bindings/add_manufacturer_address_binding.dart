import 'package:construction_technect/app/modules/MarketPlace/Partner/AddManufacturerAddress/controller/add_manufacturer_address_controller.dart';
import 'package:get/get.dart';

class AddManufacturerAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddManufacturerAddressController>(
      () => AddManufacturerAddressController(),
    );
  }
}
