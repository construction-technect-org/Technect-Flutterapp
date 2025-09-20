import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/forgotPassword/services/ForgotPasswordService.dart';
import 'package:timer_count_down/timer_controller.dart';

class ForgotPasswordController extends GetxController {
  // Controllers
  final phoneEmailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  final phoneEmail = ''.obs;
  final otp = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;

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

  // State management
  final otpSend = false.obs;
  final otpVerify = false.obs;
  final isLoading = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Services
  ForgotPasswordService forgotPasswordService = ForgotPasswordService();

  @override
  void onInit() {
    super.onInit();
    _initializeListeners();
  }

  void _initializeListeners() {
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
    _disposeControllers();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void _disposeControllers() {
    phoneEmailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  // Send OTP for mobile number verification
  Future<void> sendOtp() async {
    if (!_validateMobileNumber()) return;

    isLoading.value = true;

    try {
      final otpResponse = await forgotPasswordService.sendOtp(
        countryCode: countryCode.value,
        mobileNumber: phoneEmail.value,
      );

      if (otpResponse.success == true) {
        otpSend.value = true;
        SnackBars.successSnackBar(content: 'OTP sent successfully');
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
      }
    } catch (e) {
      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateMobileNumber() {
    if (phoneEmail.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter mobile number');
      return false;
    }

    if (phoneEmail.value.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');
      return false;
    }

    return true;
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    if (!_validateOtp()) return;

    isLoading.value = true;

    try {
      final otpResponse = await forgotPasswordService.verifyOtp(
        countryCode: countryCode.value,
        mobileNumber: phoneEmail.value,
        otp: otp.value,
      );

      if (otpResponse.success == true && otpResponse.data?.verified == true) {
        otpVerify.value = true;
        // SnackBars.successSnackBar(content: 'Mobile number verified successfully');
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'OTP verification failed',
        );
      }
    } catch (e) {
      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateOtp() {
    if (otp.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter OTP');
      return false;
    }

    if (otp.value.length < 6) {
      SnackBars.errorSnackBar(content: 'Please enter a valid OTP');
      return false;
    }

    return true;
  }

  // Reset password
  Future<void> resetPassword() async {
    if (!_validatePasswords()) return;

    if (!otpVerify.value) {
      if (otpSend.value) {
        await verifyOtp();
      } else {
        SnackBars.errorSnackBar(
          content: 'Please verify your mobile number first',
        );
        return;
      }
    }

    if (otpVerify.value) {
      await _performPasswordReset();
    }
  }

  bool _validatePasswords() {
    if (newPassword.value.isEmpty || confirmPassword.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please fill all password fields');
      return false;
    }

    if (newPassword.value != confirmPassword.value) {
      SnackBars.errorSnackBar(content: 'Passwords do not match');
      return false;
    }

    if (newPassword.value.length < 8) {
      SnackBars.errorSnackBar(
        content: 'Password must be at least 8 characters long',
      );
      return false;
    }

    return true;
  }

  Future<void> _performPasswordReset() async {
    isLoading.value = true;

    try {
      final resetResponse = await forgotPasswordService.resetPassword(
        countryCode: countryCode.value,
        mobileNumber: phoneEmail.value,
        password: newPassword.value,
        confirmPassword: confirmPassword.value,
      );

      if (resetResponse.success == true) {
        Get.offAll(
          () => SuccessScreen(
            title: "Success!",
            image: Asset.forgetSImage,
            header: "Password reset successfully !",
            onTap: () {
              Get.back();
              Get.back();
            },
          ),
        );
      } else {
        SnackBars.errorSnackBar(
          content: resetResponse.message ?? 'Password reset failed',
        );
      }
    } catch (e) {
      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }
}
