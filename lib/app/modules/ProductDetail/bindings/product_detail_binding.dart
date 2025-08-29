import 'package:construction_technect/app/modules/ProductDetail/controllers/product_detail_controller.dart';
import 'package:get/get.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  }
}
