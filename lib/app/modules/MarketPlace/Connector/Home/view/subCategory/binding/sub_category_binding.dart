import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/view/subCategory/controller/sub_category_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubCategoryController(), permanent: true);
  }
}