import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartListController>(() => CartListController());
  }
}
