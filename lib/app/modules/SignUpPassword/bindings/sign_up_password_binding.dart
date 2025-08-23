import 'package:construction_technect/app/modules/SignUpPassword/controllers/sign_up_password_controller.dart';
import 'package:get/get.dart';

class SignUpPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpPasswordController>(() => SignUpPasswordController());
  }
}
