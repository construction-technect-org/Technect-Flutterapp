import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/settings/services/SettingService.dart';

class SettingController extends GetxController {
  RxBool isNotification = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool isLightMode = true.obs;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  // State
  final isPasswordVisible = false.obs;
  final isOtpStep = false.obs;
  final isLoading = false.obs;

  RxInt isValid = (-1).obs;
  RxString countryCode = "".obs;

  bool _validateInputs() {
    if (mobileController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter mobile number');
      return false;
    }
    if (mobileController.text.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');
      return false;
    }
    if (passwordController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter your password');
      return false;
    }
    return true;
  }

  SettingService settingService = SettingService();

  // Request OTP
  Future<void> requestOtp({required bool isDeactivate}) async {
    if (!_validateInputs()) return;
    isLoading.value = true;
    isLoading.value = true;

    try {
      final otpResponse = await settingService.sendOtp(
        isDeactivate: isDeactivate,
        countryCode: countryCode.value,
        mobileNumber: mobileController.text,
        password: passwordController.text,
      );

      if (otpResponse.success == true) {
        isOtpStep.value = true;
        SnackBars.successSnackBar(content: 'OTP sent successfully');
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmAction({
    String? actionType,
    required bool isDeactivate,
  }) async {
    if (otpController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter OTP');
      return;
    }
    if (otpController.text.length < 6) {
      SnackBars.errorSnackBar(content: 'Please enter a valid OTP');
      return;
    }
    isLoading.value = true;
    try {
      final otpResponse = await settingService.verifyOtp(
        isDeactivate: isDeactivate,
        countryCode: countryCode.value,
        mobileNumber: mobileController.text,
        otp: otpController.text,
      );

      if (otpResponse.success == true && otpResponse.data?.verified == true) {
        SnackBars.successSnackBar(
          content: "${actionType ?? "".capitalizeFirst} account completed",
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'OTP verification failed',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> notificationToggle({required bool isNotification}) async {
    isLoading.value = true;
    try {
      final otpResponse = await settingService.notificationToggle(
        isNotificationSend:isNotification,
      );

      if (otpResponse.success == true) {
        Get.find<HomeController>().profileData.value.data?.user?.isNotificationSend=isNotification;
        Get.find<HomeController>().profileData.refresh();
        SnackBars.successSnackBar(content: otpResponse.message??"");
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isNotification.value= Get.find<HomeController>().profileData.value.data?.user?.isNotificationSend??false;
  }
}
