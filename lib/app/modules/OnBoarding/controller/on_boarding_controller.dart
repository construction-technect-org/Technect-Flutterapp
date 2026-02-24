

import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/Authentication/basic_info/views/basic_info_view.dart';
import 'package:construction_technect/app/modules/Authentication/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class OnBoardingController extends GetxController {

  bool hasShownInitialPermission = false;

  @override
  void onReady() {
    super.onReady();
    _handleInitialPermission();
  }

  /// ==============================
  /// INITIAL PERMISSION FLOW
  /// ==============================
  Future<void> _handleInitialPermission() async {
    await Future.delayed(const Duration(seconds: 2));

    PermissionStatus status = await Permission.locationWhenInUse.status;

    if (status.isDenied) {
      PermissionStatus result =
      await Permission.locationWhenInUse.request();

      if (result.isDenied) {
        // ❌ User clicked Don't Allow
        _openLocationPermissionBottomSheet(); // FIRST IMAGE
      }
    }

    if (status.isPermanentlyDenied) {
      _openLocationPermissionBottomSheet();
    }
  }

  /// ==============================
  /// WHEN USER TRIES FEATURE AGAIN
  /// ==============================
  Future<void> checkLocationAndProceed() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.snackbar(
        "Location Disabled",
        "Please enable location services",
      );
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // ❌ User denied again while using app
        _openLocationPermissionBottomSheet(); // FIRST IMAGE
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _openLocationPermissionBottomSheet(); // FIRST IMAGE
      return;
    }

    // ✅ Permission granted
    _openMapScreen(); // SECOND SCREEN
  }

  /// ==============================
  /// FIRST IMAGE - LOCATION PERMISSION BOTTOMSHEET
  /// ==============================
  void _openLocationPermissionBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Location Permission is Off",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enable location to find nearby services faster.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Get.back();

                PermissionStatus result =
                await Permission.locationWhenInUse.request();

                if (result.isGranted) {
                  _openMapScreen(); // Open second screen
                } else if (result.isPermanentlyDenied) {
                  openAppSettings();
                }
              },
              child: const Text("Enable"),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// ==============================
  /// SECOND SCREEN - MAP LOCATION SCREEN
  /// ==============================
  void _openMapScreen() {
    Get.to(() => const SelectDeliveryLocationScreen());
  }
  void showBottomSheet() {
    Get.bottomSheet(
      const SignUpDetailsView(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
  void showBasicInfoBottomSheet() {
    Get.bottomSheet(
      BasicInfoBottomSheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }


  void showLoginBottomSheet() {
    Get.bottomSheet(
      LoginView(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
class SelectDeliveryLocationScreen extends StatelessWidget {
  const SelectDeliveryLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Delivery Location"),
      ),
      body: const Center(
        child: Text("Map Screen Here"),
      ),
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
