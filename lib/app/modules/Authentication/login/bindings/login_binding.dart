import 'package:construction_technect/app/modules/Authentication/login/controllers/login_controller.dart';
import 'package:construction_technect/app/modules/Authentication/login/services/LoginService.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginService());
    Get.put(LoginController());
  }
}
