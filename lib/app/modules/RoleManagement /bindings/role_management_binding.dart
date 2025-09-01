// TODO Implement this library.
import 'package:construction_technect/app/modules/RoleManagement%20/controllers/role_management%20_controller.dart';
import 'package:get/get.dart';

class RoleManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleManagementController>(() => RoleManagementController());
  }
}
