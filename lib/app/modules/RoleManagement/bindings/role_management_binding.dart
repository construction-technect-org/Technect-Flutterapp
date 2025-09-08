import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:get/get.dart';

class RoleManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleManagementController>(() => RoleManagementController());
  }
}
