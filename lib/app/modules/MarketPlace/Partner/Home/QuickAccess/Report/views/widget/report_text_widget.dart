import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/controllers/report_controller.dart';
import 'package:gap/gap.dart';

class ReportTextWidget extends StatelessWidget {
  final ReportController controller;
  const ReportTextWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.isReport.value
              ? "Download reports by selecting a date range from start month to end month."
              : "Reports Dashboard",
          style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
        ),
        const Gap(8),
        Text(
          controller.isReport.value
              ? "Select a start and end month to generate and download your report."
              : "Clearly indicates the purpose of the section—it's where users manage or view reports",
          style: MyTexts.medium14.copyWith(color: MyColors.gray54),
        ),
      ],
    );
  }
}
