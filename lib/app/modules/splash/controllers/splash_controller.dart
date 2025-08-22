import 'package:construction_technect/app/core/utils/imports.dart';

class SplashController extends GetxController {
  String? token;
  @override
  void onInit() {
    super.onInit();
    _startSplashTimer();
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
