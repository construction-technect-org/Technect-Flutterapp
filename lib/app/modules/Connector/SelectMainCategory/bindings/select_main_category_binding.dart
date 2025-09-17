import 'package:construction_technect/app/modules/Connector/SelectMainCategory/controllers/select_main_category_controller.dart';
import 'package:get/get.dart';

class SelectMainCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMainCategoryController>(() => SelectMainCategoryController());
  }
}
