import 'package:construction_technect/app/modules/YourRole/controllers/your_role_controller.dart';
import 'package:get/get.dart';

class YourRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourRoleController>(() => YourRoleController());
  }
}
