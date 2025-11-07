import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/controller/delivery_location_controller.dart';
import 'package:get/get.dart';

class DeliveryLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryLocationController>(() => DeliveryLocationController());
  }
}
