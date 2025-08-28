import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  /// TextEditingControllers
  final businessNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessContactController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final projectsCompletedController = TextEditingController();

  /// Scroll Controller + GlobalKey
  final scrollController = ScrollController();
  final titleKey = GlobalKey();

  /// Reactive variable for business hours
  RxString businessHours = "".obs;

  /// Method to add Business Hours
  void addBusinessHours(String hours) {
    businessHours.value = hours;
  }

  /// Scroll to Title Section
  void scrollToTitle() {
    final context = titleKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Update Profile Action
  void updateProfile() {
    // Your API logic here
    Get.snackbar("Success", "Profile Updated!");
  }

  @override
  void onReady() {
    super.onReady();
    /// Auto-scroll after slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToTitle();
    });
  }
}
