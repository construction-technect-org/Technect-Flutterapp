import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/otp_verification_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/controllers/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/services/SettingService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/views/setting_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:timer_count_down/timer_controller.dart';

class SettingController extends GetxController {
  RxBool isNotification = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool isLightMode = true.obs;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

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

  final countdownController = CountdownController(autoStart: true);
  RxBool isResendVisible = false.obs;

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

  Future<void> requestOtp({
    required bool isDeactivate,
    required String actionType,
  }) async {
    if (!_validateInputs()) return;
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
        Get.to(
          () => OtpVerificationView(
            isLoading: isLoading,
            isBackToLogin: false,
            onTap: () {
              // await sendOtp().then((val) {
              startTimer();
              // });
            },
            countdownController: countdownController,
            isResendVisible: isResendVisible,
            otpController: otpController,
            onCompleted: (value) {
              confirmAction(actionType: actionType, isDeactivate: isDeactivate);
            },
            onFinished: () {
              onCountdownFinish();
            },
          ),
        );
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
    if (otpController.text.length < 4) {
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

      if (otpResponse.success == true) {
        myPref.clear();
        Get.offAllNamed(Routes.LOGIN);
        Get.offAll(() => SuccessAction(actionType: actionType ?? ""));
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
        isNotificationSend: isNotification,
      );

      if (otpResponse.success == true) {
        Get.find<HomeController>()
                .profileData
                .value
                .data
                ?.user
                ?.isNotificationSend =
            isNotification;
        Get.find<HomeController>().profileData.refresh();

        SnackBars.successSnackBar(content: otpResponse.message ?? "");
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
    isNotification.value =
        Get.find<HomeController>()
            .profileData
            .value
            .data
            ?.user
            ?.isNotificationSend ??
        false;
  }
}
