import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/vrm/reminder/controller/reminder_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class SetReminderScreen extends GetView<SetReminderController> {
  const SetReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text("Set Reminder"),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.10),
                                  blurRadius: 23,
                                  offset: const Offset(0, 10),
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.09),
                                  blurRadius: 42,
                                  offset: const Offset(0, 42),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Obx(
                                  () => TableCalendar(
                                    firstDay: DateTime(2020),
                                    lastDay: DateTime(2030),
                                    focusedDay: controller.focusedDay.value,
                                    selectedDayPredicate: (day) =>
                                        isSameDay(controller.selectedDay.value, day),
                                    onDaySelected: (selected, focused) {
                                      controller.selectedDay.value = selected;
                                      controller.focusedDay.value = focused;
                                    },
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      titleTextStyle: MyTexts.medium18.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.primary,
                                      ),
                                      leftChevronIcon: const Icon(Icons.chevron_left, size: 28),
                                      rightChevronIcon: const Icon(Icons.chevron_right, size: 28),
                                    ),
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekendStyle: MyTexts.bold15.copyWith(
                                        color: MyColors.primary,
                                      ),
                                      weekdayStyle: MyTexts.bold15.copyWith(
                                        color: MyColors.primary,
                                      ),
                                    ),
                                    calendarStyle: CalendarStyle(
                                      selectedDecoration: const BoxDecoration(
                                        color: MyColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      todayDecoration: BoxDecoration(
                                        color: Colors.indigo.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      defaultTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text("Time", style: MyTexts.medium18),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => controller.pickTime(),
                                      child: Obx(() {
                                        final t = controller.selectedTime.value;
                                        final hh = t.hour.toString().padLeft(2, '0');
                                        final mm = t.minute.toString().padLeft(2, '0');
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 22,
                                          ),
                                          decoration: BoxDecoration(
                                            color: MyColors.primary.withValues(alpha: 0.12),
                                            border: Border.all(color: Colors.indigo.shade200),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text("$hh : $mm", style: MyTexts.medium16),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.greyE5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Selected Date : ',
                                        style: MyTexts.regular15.copyWith(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: controller.formattedSelectedDate(),
                                        style: MyTexts.medium16.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(10),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Selected Time : ',
                                        style: MyTexts.regular15.copyWith(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: controller.formattedSelectedTime(),
                                        style: MyTexts.medium16.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          CommonTextField(
                            controller: controller.noteController,
                            hintText: "Note...",
                            maxLine: 5,
                            bgColor: const Color(0xFFF3F6FF),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    color: Colors.transparent,
                    fontColor: MyColors.primary,
                    buttonName: "Cancel",
                    borderColor: MyColors.primary,
                    onTap: () => Get.back(),
                  ),
                ),
                const Gap(24),
                Expanded(
                  child: RoundedButton(
                    buttonName: "Save",
                    onTap: () {
                      if (controller.noteController.text.isNotEmpty) {
                        controller.saveReminder();
                      } else {
                        SnackBars.errorSnackBar(content: "Please add note");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBox({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyColors.primary),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$label :", style: MyTexts.medium16),
          const Gap(10),
          Text(value, style: MyTexts.medium16),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String title,
    required Color color,
    required Color textColor,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: borderColor != null ? Border.all(color: borderColor, width: 1.4) : null,
        ),
        child: Center(
          child: Text(
            title,
            style: MyTexts.medium18.copyWith(fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ),
    );
  }
}
