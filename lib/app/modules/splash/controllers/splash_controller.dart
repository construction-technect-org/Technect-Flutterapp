import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class SplashController extends GetxController {
  String? token;

  @override
  void onInit() {
    super.onInit();
    _checkInternetAndNavigate();
  }

  Future<void> _checkInternetAndNavigate() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
      return;
    }
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() {
    final savedToken = myPref.getToken();

    if (savedToken.isNotEmpty) {
      _navigateToHome();
    } else {
      _startSplashTimer();
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text(
          'Please check your internet connection and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _checkInternetAndNavigate(); // Retry
            },
            child: const Text('Retry'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _navigateToHome() {
    // if (Device.screenType == ScreenType.mobile) {
    //   // Show splash for a brief moment even with token
      Future.delayed(const Duration(seconds: 3), () {
        print(myPref.role.val);
        if (myPref.role.val == "merchant_partner") {
          Get.offAllNamed(Routes.MAIN);
        } else if (myPref.role.val == "merchant_connector") {
          Get.offAllNamed(Routes.CONNECTOR_MAIN_TAB);
        }
        else{
          Get.offAllNamed(Routes.LOGIN);

        }
      });
    // } else {
    //   Get.offAllNamed(Routes.MAIN);
    // }
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
