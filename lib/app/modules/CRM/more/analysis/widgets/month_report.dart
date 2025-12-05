import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthReport extends GetView<AnalysisController> {
  const MonthReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final DateTime nowMonth = DateTime(DateTime.now().year, DateTime.now().month);
              final DateTime startInitial = controller.startMonth.value ?? nowMonth;
              final picked = await showMonthPicker(
                context: context,
                initialDate: startInitial.isAfter(nowMonth) ? nowMonth : startInitial,
                firstDate: DateTime(2000),
                lastDate: nowMonth,
                monthPickerDialogSettings: const MonthPickerDialogSettings(
                  dialogSettings: PickerDialogSettings(
                    dialogRoundedCornersRadius: 20,
                    dialogBackgroundColor: Colors.white,
                  ),
                  headerSettings: PickerHeaderSettings(headerBackgroundColor: MyColors.primary),
                ),
              );
              if (picked != null) {
                controller.startMonth.value = DateTime(picked.year, picked.month);
                // If previously selected end month is out of the 3-month window, reset it
                if (controller.endMonth.value != null) {
                  final end = DateTime(
                    controller.endMonth.value!.year,
                    controller.endMonth.value!.month,
                  );
                  final span = controller.inclusiveMonthSpan(controller.startMonth.value!, end);
                  final bool endInFuture = end.isAfter(nowMonth);
                  if (span > 12 || end.isBefore(controller.startMonth.value!) || endInFuture) {
                    controller.endMonth.value = null;
                  }
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayEA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  controller.startMonth.value != null
                      ? DateFormat("MMM yyyy").format(controller.startMonth.value!)
                      : "Start Month",
                  style: MyTexts.medium14.copyWith(
                    color: controller.startMonth.value != null ? MyColors.gray2E : MyColors.grayA5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (controller.startMonth.value == null) {
                Get.snackbar("Select Start Month", "Please select a start month first");
                return;
              }
              final DateTime start = DateTime(
                controller.startMonth.value!.year,
                controller.startMonth.value!.month,
              );
              final DateTime nowMonth = DateTime(DateTime.now().year, DateTime.now().month);
              final DateTime lastAllowedRaw = controller.lastAllowedEndMonth(start);
              final DateTime lastAllowed = lastAllowedRaw.isAfter(nowMonth)
                  ? nowMonth
                  : lastAllowedRaw;
              final DateTime initial = controller.endMonth.value != null
                  ? DateTime(controller.endMonth.value!.year, controller.endMonth.value!.month)
                  : start;
              final picked = await showMonthPicker(
                context: context,
                initialDate: initial.isBefore(start) || initial.isAfter(lastAllowed)
                    ? start
                    : initial,
                firstDate: start,
                lastDate: lastAllowed,
                monthPickerDialogSettings: const MonthPickerDialogSettings(
                  dialogSettings: PickerDialogSettings(
                    dialogRoundedCornersRadius: 20,
                    dialogBackgroundColor: Colors.white,
                  ),
                  headerSettings: PickerHeaderSettings(headerBackgroundColor: MyColors.primary),
                ),
              );
              if (picked != null) {
                controller.endMonth.value = DateTime(picked.year, picked.month);
                controller.onApplyReport();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayEA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  controller.endMonth.value != null
                      ? DateFormat("MMM yyyy").format(controller.endMonth.value!)
                      : "End Month",
                  style: MyTexts.medium14.copyWith(
                    color: controller.endMonth.value != null ? MyColors.gray2E : MyColors.grayA5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
