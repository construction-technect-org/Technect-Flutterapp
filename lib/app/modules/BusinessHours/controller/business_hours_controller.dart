import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessHoursController extends GetxController {
  // Enable / Disable all business hours
  RxBool isEnabled = true.obs;

  // Days toggle
  final Map<String, RxBool> daysEnabled = {
    "Monday": true.obs,
    "Tuesday": true.obs,
    "Wednesday": true.obs,
    "Thursday": true.obs,
    "Friday": true.obs,
    "Saturday": true.obs,
    "Sunday": false.obs,
  };

  // From / To text controllers
  final Map<String, TextEditingController> fromControllers = {};
  final Map<String, TextEditingController> toControllers = {};

  @override
  void onInit() {
    super.onInit();
    for (var day in daysEnabled.keys) {
      fromControllers[day] = TextEditingController();
      toControllers[day] = TextEditingController();
    }
  }

  @override
  void onClose() {
    for (var controller in fromControllers.values) {
      controller.dispose();
    }
    for (var controller in toControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  // Example: handle submit
  void onSubmit() {
    debugPrint("Enabled: ${isEnabled.value}");
    if (!isEnabled.value) {
      debugPrint("All business hours are disabled");
      return;
    }
    for (var day in daysEnabled.keys) {
      debugPrint(
          "$day: ${daysEnabled[day]!.value ? "Open" : "Closed"} - ${fromControllers[day]?.text} to ${toControllers[day]?.text}");
    }
  }
}
