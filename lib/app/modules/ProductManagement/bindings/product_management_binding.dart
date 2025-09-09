import 'package:construction_technect/app/modules/ProductManagement/controllers/product_management_controller.dart';
import 'package:get/get.dart';

class ProductManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductManagementController>(() => ProductManagementController());
  }
}
