import 'package:construction_technect/app/core/utils/imports.dart';

class SignUpPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final password = ''.obs;
  final confirmPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    confirmPasswordController.addListener(() {
      confirmPassword.value = confirmPasswordController.text;
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  bool isFormValid() {
    return password.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        password.value == confirmPassword.value &&
        password.value.length >= 8;
  }

  void completeSignUp() {
    Get.offAllNamed(Routes.LOGIN);
    // if (isFormValid()) {
    //   SnackBars.successSnackBar(content: 'Account created successfully!');
    //   Get.offAllNamed(Routes.MAIN);
    // } else {
    //   if (password.value.isEmpty || confirmPassword.value.isEmpty) {
    //     SnackBars.errorSnackBar(content: 'Please fill all required fields');
    //   } else if (password.value != confirmPassword.value) {
    //     SnackBars.errorSnackBar(content: 'Passwords do not match');
    //   } else if (password.value.length < 8) {
    //     SnackBars.errorSnackBar(
    //       content: 'Password must be at least 8 characters long',
    //     );
    //   }
    // }
  }
}
