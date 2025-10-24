import 'package:get/get.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/controller/add_delivery_address_controller.dart';

class AddDeliveryAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeliveryAddressController>(
      () => AddDeliveryAddressController(),
    );
  }
}
