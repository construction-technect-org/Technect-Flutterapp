import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 10, minute: 30).obs;

  // Keep a TextEditingController in the controller so view is stateless
  final TextEditingController noteController = TextEditingController();

  /// Choose time using the framework time picker (uses Get.context)
  Future<void> pickTime() async {
    final context = Get.context;
    if (context == null) return;
    final TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (c, child) {
        return Theme(
          data: Theme.of(c).copyWith(
            timePickerTheme: const TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (t != null) selectedTime.value = t;
  }

  String formattedSelectedDate() {
    final d = selectedDay.value ?? DateTime.now();
    return "${d.day.toString().padLeft(2, '0')}/"
        "${d.month.toString().padLeft(2, '0')}/"
        "${d.year}";
  }

  String formattedSelectedTime() {
    final t = selectedTime.value;
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hour:$minute $period";
  }

  void saveReminder() {
    final note = noteController.text;
    final date = selectedDay.value ?? DateTime.now();
    final time = selectedTime.value;
    debugPrint("Save reminder -> date: $date, time: $time, note: $note");
    Get.back();
    SnackBars.successSnackBar(content: "Reminder set successfully");
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
