import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/services/ForgotPasswordService.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordService());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
