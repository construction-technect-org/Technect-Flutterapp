import 'package:construction_technect/app/core/utils/imports.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;

  void login() {
    // TODO: Add actual login validation
    // if (mobileController.text.isNotEmpty &&
    //     passwordController.text.isNotEmpty) {
    //   SnackBars.successSnackBar(content: 'Login successful!');
    Get.offAllNamed(Routes.MAIN);
    // } else {
    //   SnackBars.errorSnackBar(content: 'Please fill all fields');
    // }
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
