import 'package:construction_technect/app/core/utils/imports.dart';

class SignUpDetailsController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  final firstName = ''.obs;
  final lastName = ''.obs;
  final mobileNumber = ''.obs;
  final email = ''.obs;
  final otp = ''.obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(() {
      firstName.value = firstNameController.text;
    });
    lastNameController.addListener(() {
      lastName.value = lastNameController.text;
    });
    mobileNumberController.addListener(() {
      mobileNumber.value = mobileNumberController.text;
    });
    emailController.addListener(() {
      email.value = emailController.text;
    });
    otpController.addListener(() {
      otp.value = otpController.text;
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }

  bool isFormValid() {
    return firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        mobileNumber.value.isNotEmpty &&
        email.value.isNotEmpty &&
        _isValidEmail(email.value);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void verifyMobileNumber() {
    if (mobileNumber.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter mobile number first');
      return;
    }

    if (mobileNumber.value.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');

      return;
    }

    SnackBars.successSnackBar(content: 'Verification code sent to ${mobileNumber.value}');
  }

  void proceedToPassword() {
    // if (isFormValid()) {
    Get.toNamed(Routes.SIGN_UP_PASSWORD);
    // } else {
    // SnackBars.errorSnackBar(content: 'Please fill all required fields correctly');
    // }
  }
}
