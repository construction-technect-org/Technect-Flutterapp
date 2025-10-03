import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/controllers/add_role_controller.dart';
import 'package:get/get.dart';

class AddRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRoleController>(() => AddRoleController());
  }
}
