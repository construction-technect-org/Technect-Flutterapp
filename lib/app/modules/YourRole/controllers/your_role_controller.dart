import 'package:get/get.dart';

class YourRoleController extends GetxController {
  RxString selectedRole = "".obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }
}
