import 'package:get/get.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/controllers/add_inventory_controller.dart';

class AddInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInventoryController>(() => AddInventoryController());
  }
}
