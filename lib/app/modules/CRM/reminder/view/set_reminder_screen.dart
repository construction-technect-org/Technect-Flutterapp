import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/reminder/controller/reminder_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class SetReminderScreen extends GetView<ReminderController> {
  const SetReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReminderController c = controller;
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.categoryBg),
                  fit: BoxFit.cover,
                ),
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
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                    child: Column(
                      children: [
                        // Calendar card
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withValues(alpha: 0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Obx(
                                () => TableCalendar(
                                  firstDay: DateTime(2020),
                                  lastDay: DateTime(2030),
                                  focusedDay: c.focusedDay.value,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(c.selectedDay.value, day),
                                  onDaySelected: (selected, focused) {
                                    c.selectedDay.value = selected;
                                    c.focusedDay.value = focused;
                                  },
                                  headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    titleTextStyle: MyTexts.medium18.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.indigo.shade900,
                                    ),
                                    leftChevronIcon: const Icon(
                                      Icons.chevron_left,
                                      size: 28,
                                    ),
                                    rightChevronIcon: const Icon(
                                      Icons.chevron_right,
                                      size: 28,
                                    ),
                                  ),
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                    weekendStyle: TextStyle(
                                      color: Colors.indigo.shade700,
                                    ),
                                    weekdayStyle: TextStyle(
                                      color: Colors.indigo.shade700,
                                    ),
                                  ),
                                  calendarStyle: CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                      color: Colors.indigo.shade800,
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
                              // Time row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Time", style: MyTexts.medium18),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () => c.pickTime(),
                                    child: Obx(() {
                                      final t = c.selectedTime.value;
                                      final hh = t.hour.toString().padLeft(
                                        2,
                                        '0',
                                      );
                                      final mm = t.minute.toString().padLeft(
                                        2,
                                        '0',
                                      );
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 22,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.indigo.shade200,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          "$hh : $mm",
                                          style: MyTexts.medium18,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Date & Time display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => _infoBox(
                                label: "Date",
                                value: c.formattedSelectedDate(),
                              ),
                            ),
                            Obx(
                              () => _infoBox(
                                label: "Time",
                                value: c.formattedSelectedTime(),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // Note input
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.indigo.shade200),
                          ),
                          child: TextField(
                            controller: c.noteController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: "Note...",
                              border: InputBorder.none,
                            ),
                            style: MyTexts.medium16,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _actionButton(
                              title: "Cancel",
                              color: Colors.white,
                              textColor: Colors.indigo.shade900,
                              borderColor: Colors.indigo.shade300,
                              onTap: () => Get.back(),
                            ),
                            _actionButton(
                              title: "Save",
                              color: Colors.indigo.shade900,
                              textColor: Colors.white,
                              onTap: () => c.saveReminder(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade300),
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
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.4)
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: MyTexts.medium18.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
