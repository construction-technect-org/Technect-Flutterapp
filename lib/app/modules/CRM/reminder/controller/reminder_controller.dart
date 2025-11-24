import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 10, minute: 30).obs;

  final TextEditingController noteController = TextEditingController();

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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

  RxBool isLoading = false.obs;

  Future<void> saveReminder() async {
    isLoading.value = true;
    await Get.find<MarketingController>().updateStatusLeadToFollowUp(
      leadID: Get.arguments["leadID"].toString(),
      assignTo: Get.arguments["assignTo"].toString(),
      note: noteController.text,
      priority: Get.arguments["priority"].toString(),
      assignToMySelf: Get.arguments["assignToSelf"] ?? false,
      remindAt: getReminderUTCString(),
      onSuccess: () {
        isLoading.value = false;
        Get.back();
        Get.find<MarketingController>().fetchAllLead();
      },
    );
    isLoading.value = false;
  }

  String getReminderUTCString() {
    final date = selectedDay.value ?? DateTime.now();
    final time = selectedTime.value;
    final combined = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final iso = combined.toUtc().toIso8601String();
    return iso.replaceAll('.000', '');
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
