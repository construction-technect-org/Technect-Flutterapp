// lib/app/modules/RoleDetails/bindings/role_details_binding.dart
import 'package:construction_technect/app/modules/%20RoleDetails/controllers/%20role_details_controller.dart';
import 'package:get/get.dart';

class RoleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleDetailsController>(() => RoleDetailsController());
  }
}
