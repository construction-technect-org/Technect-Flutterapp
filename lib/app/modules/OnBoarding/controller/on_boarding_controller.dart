import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/Authentication/login/views/login_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class OnBoardingController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _showPermissionAfterDelay();
  }

  void showBottomSheet() {
    Get.bottomSheet(
      SignUpDetailsView(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      isDismissible: true,
      enableDrag: true,
    );
  }

  void showLoginBottomSheet() {
    Get.bottomSheet(
      LoginView(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      isDismissible: true,
      enableDrag: true,
    );
  }

  Future<void> _showPermissionAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    final status = await Permission.locationWhenInUse.status;

    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }

    // if (!status.isGranted) {
    //   //_showLocationPermissionPopup();
    // }
  }
   Future<bool> checkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Disabled",
        "Please enable location services",
      );

      await Geolocator.openLocationSettings();
      return false;
    }

    // 2️⃣ Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required",
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Permanently Denied",
        "Enable permission from app settings",
      );

      await Geolocator.openAppSettings();
      return false;
    }

    // ✅ Location enabled and permission granted
    return true;
  }
  void _showLocationPermissionPopup() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Enable Location'),
        content: const Text(
          'We use your location to show nearby jobs and employers.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Not Now'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();

              final result = await Permission.locationWhenInUse.request();

              if (result.isPermanentlyDenied) {
                openAppSettings();
              }
            },
            child: const Text('Allow'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}


/*
import 'package:construction_technect/app/core/utils/imports.dart';

class OnBoardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  void nextPage() {
    if (currentIndex.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      getStarted();
    }
  }

  void skip() {
    pageController.jumpToPage(3);
  }

  void getStarted() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
*/
