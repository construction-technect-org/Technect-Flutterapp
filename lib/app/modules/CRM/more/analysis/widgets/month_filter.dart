import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';

class MonthFilter extends GetView<AnalysisController> {
  const MonthFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.grayEA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: const SizedBox(),
          value: controller.selectedPeriod.value.isEmpty ? null : controller.selectedPeriod.value,
          hint: Text(
            "Select Period",
            style: MyTexts.medium14.copyWith(color: MyColors.primary.withValues(alpha: 0.5)),
          ),
          items: controller.periodOptions
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: MyTexts.medium15.copyWith(color: MyColors.gray2E)),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) controller.onPeriodSelected(val);
          },
        ),
      ),
    );
  }
}
