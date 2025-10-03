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
    // Check internet connectivity first
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No internet connection
      _showNoInternetDialog();
      return;
    }

    // Internet available, proceed with token check
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() {
    // Check if user has a valid token
    final savedToken = myPref.getToken();

    if (savedToken.isNotEmpty) {
      // Token exists, navigate directly to Home screen
      _navigateToHome();
    } else {
      // No token, show splash screen then navigate to login
      _startSplashTimer();
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connection and try again.'),
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
