import 'package:construction_technect/app/modules/Invetory/controllers/inventory_controller.dart';
import 'package:get/get.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryController>(() => InventoryController());
  }
}
