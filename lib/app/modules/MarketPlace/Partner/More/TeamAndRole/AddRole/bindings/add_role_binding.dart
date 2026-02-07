import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/controllers/add_role_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/service/role_service.dart';
import 'package:get/get.dart';

class AddRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddRoleService>(AddRoleService());
    Get.lazyPut<AddRoleController>(() => AddRoleController());
  }
}
