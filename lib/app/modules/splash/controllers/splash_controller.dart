import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/main.dart';

class SplashController extends GetxController {
  String? token;

  @override
  void onInit() {
    super.onInit();
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() {
    // Check if user has a valid token
    final savedToken = myPref.getToken();

    if (savedToken.isNotEmpty) {
      // Token exists, navigate directly to home screen
      _navigateToHome();
    } else {
      // No token, show splash screen then navigate to login
      _startSplashTimer();
    }
  }

  void _navigateToHome() {
    if (Device.screenType == ScreenType.mobile) {
      // Show splash for a brief moment even with token
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.MAIN);
      });
    } else {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  void _startSplashTimer() {
    if (Device.screenType == ScreenType.mobile) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
