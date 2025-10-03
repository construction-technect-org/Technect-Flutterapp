import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:timer_count_down/timer_controller.dart';

class SignUpDetailsController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final gstController = TextEditingController();
  SignUpService signUpService = SignUpService();
  final firstName = ''.obs;
  final lastName = ''.obs;
  final mobileNumber = ''.obs;
  final email = ''.obs;
  final gst = ''.obs;
  final otp = ''.obs;
  final otpSend = false.obs;
  final otpVerify = false.obs;

  RxInt isValid = (-1).obs;
  RxString countryCode = "".obs;

  final countdownController = CountdownController(autoStart: true);
  RxBool isResendVisible = false.obs;

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

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
    gstController.addListener(() {
      gst.value = gstController.text;
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    gstController.dispose();
    super.onClose();
  }

  Future<bool> isFormValid() async {
    final bool isGstValid = await verifyGStNumber();
    return firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        mobileNumber.value.isNotEmpty &&
        email.value.isNotEmpty &&
        true==isGstValid &&
        _isValidEmail(email.value);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> verifyMobileNumber() async {
    if (mobileNumber.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter mobile number first');
      return;
    }

    if (mobileNumber.value.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');
      return;
    }

    if (!otpSend.value) {
      final otpResponse = await signUpService.sendOtp(
        mobileNumber: mobileNumber.value,
      );

      if (otpResponse.success == true) {
        SnackBars.successSnackBar(
          content: 'OTP sent successfully to ${mobileNumber.value}',
        );
        otpSend.value = true;
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
      }
    } else {
      // Resend OTP if already sent
      await resendOtp();
    }
  }
  Future<bool> verifyGStNumber() async {
    if (gstController.text.trim().isEmpty) {
      return true;
    }
    else{
      if (gstController.text.trim().length != 15) {
        SnackBars.errorSnackBar(content: "GST number must be exactly 15 characters");
        return false;

      }
      if (!_isValidGSTNumber(gstController.text.trim())) {
        SnackBars.errorSnackBar(content: "Please enter a valid GST number");
        return false;

      }
    }

    return true;

  }

  bool _isValidGSTNumber(String gst) {
    // GST format: 2 digits + 2 letters + 5 digits + 1 letter + 1 digit + 1 letter + 1 digit
    return RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1}$',
    ).hasMatch(gst);
  }

  // Resend OTP method
  Future<void> resendOtp() async {
    if (mobileNumber.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter mobile number first');
      return;
    }

    if (mobileNumber.value.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');
      return;
    }

    try {
      final otpResponse = await signUpService.resendOtp(
        mobileNumber: mobileNumber.value,
        code: countryCode.value,
      );

      if (otpResponse.success == true) {
        SnackBars.successSnackBar(
          content: 'OTP resent successfully to ${mobileNumber.value}',
        );
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to resend OTP',
        );
        // Reset OTP sent flag if resend fails
        otpSend.value = false;
      }
    } catch (e) {
      // Error snackbar is already shown by ApiManager
      // Reset OTP sent flag if error occurs
      otpSend.value = false;
    }
  }

  Future<void> proceedToPassword() async {
    if (!otpVerify.value) {
      // Verify OTP API first
      if (otp.value.isEmpty || otp.value.length < 4) {
        SnackBars.errorSnackBar(content: 'Please enter a valid 4-digit OTP');
        return;
      }

      await verifyOtp();
    } else {
      if (await isFormValid()) {
        // Pass user data to password screen
        final userData = UserDataModel(
          roleName: Get.find<SignUpRoleController>().selectedRoleName.value,
          // Default role ID
          firstName: firstName.value,
          lastName: lastName.value,
          countryCode: countryCode.value,
          mobileNumber: mobileNumber.value,
          email: email.value,
          gst: gstController.text
        );
        Get.toNamed(Routes.SIGN_UP_PASSWORD, arguments: userData);
      } else {
        SnackBars.errorSnackBar(
          content: 'Please fill all required fields correctly',
        );
      }
    }
  }

  // Verify OTP method
  Future<void> verifyOtp() async {
    if (otp.value.isEmpty || otp.value.length < 4) {
      SnackBars.errorSnackBar(content: 'Please enter a valid 4-digit OTP');
      return;
    }

    try {
      final otpResponse = await signUpService.verifyOtp(
        mobileNumber: mobileNumber.value,
        otp: otp.value,
      );

      if (otpResponse.success == true) {
        if (otpResponse.data?.verified == true) {
          otpVerify.value = true;
          SnackBars.successSnackBar(content: 'OTP verified successfully!');
          if (await isFormValid()) {
            // Pass user data to password screen
            final userData = UserDataModel(
              roleName: Get.find<SignUpRoleController>().selectedRoleName.value,
              // Default role ID
              firstName: firstName.value,
              lastName: lastName.value,
              countryCode: countryCode.value,
              mobileNumber: mobileNumber.value,
              email: email.value,
              gst: gstController.text
            );
            Get.toNamed(Routes.SIGN_UP_PASSWORD, arguments: userData);
          } else {
            SnackBars.errorSnackBar(
              content: 'Please fill all required fields correctly',
            );
          }
        } else {
          SnackBars.errorSnackBar(
            content: 'OTP verification failed. Please try again.',
          );
        }
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to verify OTP',
        );
      }
    } catch (e) {
      // Error snackbar is already shown by ApiManager
      // No need to show another one here
    }
  }
}
