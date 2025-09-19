import 'package:construction_technect/app/core/utils/imports.dart';

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

  final Map<String, RxString> fromPeriods = {};
  final Map<String, RxString> toPeriods = {};
  @override
  void onInit() {
    super.onInit();
    for (final day in daysEnabled.keys) {
      fromControllers[day] = TextEditingController();
      toControllers[day] = TextEditingController();
      fromPeriods[day] = "AM".obs;
      toPeriods[day] = "PM".obs;
    }
  }

  @override
  void onClose() {
    for (final controller in fromControllers.values) {
      controller.dispose();
    }
    for (final controller in toControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  /// Validate time input (1-24 hours)
  void validateTimeInput(String value, String day, String type) {
    if (value.isNotEmpty) {
      final int? hour = int.tryParse(value);
      if (hour == null || hour < 0 || hour > 12) {
        if (type == 'from') {
          fromControllers[day]?.clear();
        } else {
          toControllers[day]?.clear();
        }
        SnackBars.errorSnackBar(
          content: "Please enter valid time (0-12 hours)",
          time: 2,
        );
      }
    }
  }


  // Store previous business hours data when editing
  void loadPreviousBusinessHours(List<Map<String, dynamic>> previousData) {
    Get.printInfo(info: '📅 Loading previous business hours data');

    for (final dayData in previousData) {
      final dayName = dayData['day_name'] as String;
      final isOpen = dayData['is_open'] as bool;

      if (daysEnabled.containsKey(dayName)) {
        daysEnabled[dayName]!.value = isOpen;

        if (isOpen && dayData['open_time'] != 'Closed') {
          // Extract hour from "09:00" format
          final openTime = dayData['open_time'] as String;
          final closeTime = dayData['close_time'] as String;

          // Remove ":00" and get just the hour
          final openHour = openTime.replaceAll(':00', '');
          final closeHour = closeTime.replaceAll(':00', '');

          fromControllers[dayName]?.text = openHour;
          toControllers[dayName]?.text = closeHour;

          Get.printInfo(info: '📅 Restored $dayName: $openHour - $closeHour');
        } else {
          // Clear times for closed days
          fromControllers[dayName]?.text = '';
          toControllers[dayName]?.text = '';
          Get.printInfo(info: '📅 $dayName is closed');
        }
      }
    }
  }

  // Handle submit and return data to edit profile
  void onSubmit() {
    if (!isEnabled.value) {
      SnackBars.errorSnackBar(content: "Please enable business hours");
      return;
    }

    // Validate that at least one day has time set
    bool hasValidHours = false;
    for (final day in daysEnabled.keys) {
      if (daysEnabled[day]!.value &&
          fromControllers[day]?.text.isNotEmpty == true &&
          toControllers[day]?.text.isNotEmpty == true) {
        // Validate time format (1-24)
        final fromHour = int.tryParse(fromControllers[day]!.text);
        final toHour = int.tryParse(toControllers[day]!.text);

        if (fromHour != null &&
            toHour != null &&
            fromHour >= 1 &&
            fromHour <= 24 &&
            toHour >= 1 &&
            toHour <= 24 ) {
          hasValidHours = true;
        } else {
          SnackBars.errorSnackBar(
            content:
                "Invalid time format for $day. Please enter valid hours (1-24) and ensure 'From' time is before 'To' time",
            time: 4,
          );
          return;
        }
      }
    }

    if (!hasValidHours) {
      SnackBars.errorSnackBar(
        content: "Please set valid business hours for at least one day",
      );
      return;
    }

    // Create business hours data
    final List<Map<String, dynamic>> businessHoursData = [];
    // Map day names to correct day_of_week values (0=Sunday, 1=Monday, etc.)
    final Map<String, int> dayToWeekMap = {
      "Monday": 1,
      "Tuesday": 2,
      "Wednesday": 3,
      "Thursday": 4,
      "Friday": 5,
      "Saturday": 6,
      "Sunday": 0,
    };

    for (final day in daysEnabled.keys) {
      final dayOfWeek = dayToWeekMap[day]!;

      if (daysEnabled[day]!.value &&
          fromControllers[day]?.text.isNotEmpty == true &&
          toControllers[day]?.text.isNotEmpty == true) {
        // Day is open with valid times
        businessHoursData.add({
          "day_of_week": dayOfWeek,
          "day_name": day,
          "is_open": true,
          "open_time": "${fromControllers[day]?.text.padLeft(2, '0')}:00 ${fromPeriods[day]!.value}",
          "close_time": "${toControllers[day]?.text.padLeft(2, '0')}:00 ${toPeriods[day]!.value}",
        });
      } else {
        // Day is closed or has no valid times
        businessHoursData.add({
          "day_of_week": dayOfWeek,
          "day_name": day,
          "is_open": false,
          "open_time": "",
          "close_time": "",
        });
      }
    }

    Get.back(result: businessHoursData);
  }
}
