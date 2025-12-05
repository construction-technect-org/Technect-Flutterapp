import 'package:construction_technect/app/core/utils/imports.dart';

class ReportTextWidget extends StatelessWidget {
  final bool isReport;
  const ReportTextWidget({super.key, required this.isReport});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isReport
              ? "Download reports by selecting a date range from start month to end month."
              : "Reports Dashboard",
          style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
        ),
        const Gap(8),
        Text(
          isReport
              ? "Select a start and end month to generate and download your report."
              : "Clearly indicates the purpose of the section—it's where users manage or view reports",
          style: MyTexts.medium14.copyWith(color: MyColors.gray54),
        ),
      ],
    );
  }
}
