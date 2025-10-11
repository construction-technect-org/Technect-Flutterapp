import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/controllers/wish_list_controller.dart';
import 'package:get/get.dart';

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishListController>(() => WishListController());
  }
}
