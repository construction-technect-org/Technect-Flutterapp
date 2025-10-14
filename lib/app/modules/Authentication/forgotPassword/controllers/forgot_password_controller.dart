import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/services/ForgotPasswordService.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/reset_password_view.dart';
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


  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
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
        Get.to(()=> ResetPasswordView());
        SnackBars.successSnackBar(content: 'OTP verified successfully');
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

    if (otp.value.length < 4) {
      SnackBars.errorSnackBar(content: 'Please enter 4 valid OTP');
      return false;
    }

    return true;
  }

  // Reset password
  Future<void> resetPassword() async {
      await _performPasswordReset();
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
             Get.offAllNamed(Routes.LOGIN);
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
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
