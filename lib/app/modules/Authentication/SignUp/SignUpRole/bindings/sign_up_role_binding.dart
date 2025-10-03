import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:get/get.dart';

class SignUpRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpRoleController>(() => SignUpRoleController());
  }
}
