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
              _checkInternetAndNavigate();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      if (myPref.role.val.isNotEmpty) {
        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  void _startSplashTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.toNamed(Routes.ON_BOARDING);
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
