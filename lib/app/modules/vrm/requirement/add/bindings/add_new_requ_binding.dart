import 'package:construction_technect/app/modules/vrm/requirement/add/controller/add_new_requ_controller.dart';
import 'package:get/get.dart';

class AddNewRequBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewRequController>(() => AddNewRequController());
  }
}
