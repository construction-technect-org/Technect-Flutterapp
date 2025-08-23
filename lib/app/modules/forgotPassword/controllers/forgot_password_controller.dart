import 'package:construction_technect/app/core/utils/imports.dart';

class ForgotPasswordController extends GetxController {
  final phoneEmailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final phoneEmail = ''.obs;
  final otp = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phoneEmailController.addListener(() {
      phoneEmail.value = phoneEmailController.text;
    });
    otpController.addListener(() {
      otp.value = otpController.text;
    });
    newPasswordController.addListener(() {
      newPassword.value = newPasswordController.text;
    });
    confirmPasswordController.addListener(() {
      confirmPassword.value = confirmPasswordController.text;
    });
  }

  @override
  void onClose() {
    phoneEmailController.dispose();
    // otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  bool isFormValid() {
    return phoneEmail.value.isNotEmpty &&
        otp.value.isNotEmpty &&
        newPassword.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        newPassword.value == confirmPassword.value &&
        newPassword.value.length >= 8;
  }

  void getOTP() {
    if (phoneEmail.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter phone number or email first');
      return;
    }

    SnackBars.successSnackBar(content: 'OTP sent to ${phoneEmail.value}');
  }

  void resetPassword() {
    Get.back();
    // if (isFormValid()) {
    //   SnackBars.successSnackBar(content: 'Password reset successfully!');
    //   Get.back();
    // } else {
    //   if (phoneEmail.value.isEmpty ||
    //       otp.value.isEmpty ||
    //       newPassword.value.isEmpty ||
    //       confirmPassword.value.isEmpty) {
    //     SnackBars.errorSnackBar(content: 'Please fill all required fields');
    //   } else if (newPassword.value != confirmPassword.value) {
    //     SnackBars.errorSnackBar(content: 'Passwords do not match');
    //   } else if (newPassword.value.length < 8) {
    //     SnackBars.errorSnackBar(
    //       content: 'Password must be at least 8 characters long',
    //     );
    //   }
    // }
  }
}
