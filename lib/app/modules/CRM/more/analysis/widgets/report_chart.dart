import "dart:developer";


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/report_view.dart';

class ReportChart extends GetView<AnalysisController> {
  const ReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log(myPref.role.val);
    }
    return Obx(() {
      if (!controller.isReport.value) {
        final analysis = controller.analysisModel.value;
        return Column(
          children: [
            if (analysis.leadAnalytics != null && analysis.leadAnalytics!.monthlyBreakdown != null)
              ReportGraph(
                title: "Lead Analysis",
                labels: analysis.leadAnalytics!.monthlyBreakdown!.map((e) => e.monthName!).toList(),
                values: [
                  analysis.leadAnalytics!.monthlyBreakdown!
                      .map((e) => e.leadsCreated ?? 0)
                      .toList(),
                  analysis.leadAnalytics!.monthlyBreakdown!
                      .map((e) => e.convertedToSales ?? 0)
                      .toList(),
                ],
                colors: const [MyColors.primary, MyColors.green],
                legends: const ["Leads Created", "Converted to Sales"],
              ),
            const Gap(10),
            if (analysis.salesLeadAnalytics != null &&
                analysis.salesLeadAnalytics!.monthlyBreakdown != null)
              ReportGraph(
                title: "Sales Lead Analysis",
                labels: analysis.salesLeadAnalytics!.monthlyBreakdown!
                    .map((e) => e.monthName!)
                    .toList(),
                values: [
                  analysis.salesLeadAnalytics!.monthlyBreakdown!
                      .map((e) => e.salesLeadsCreated ?? 0)
                      .toList(),
                  analysis.salesLeadAnalytics!.monthlyBreakdown!.map((e) => e.won ?? 0).toList(),
                  analysis.salesLeadAnalytics!.monthlyBreakdown!.map((e) => e.lost ?? 0).toList(),
                ],
                colors: const [MyColors.primary, MyColors.green, Colors.red],
                legends: const ["Sales Leads Created", "Won", "Lost"],
              ),
            const Gap(10),
            if (analysis.accountLeadAnalytics != null &&
                analysis.accountLeadAnalytics!.monthlyBreakdown != null)
              ReportGraph(
                title: "Account Lead Analysis",
                labels: analysis.accountLeadAnalytics!.monthlyBreakdown!
                    .map((e) => e.monthName!)
                    .toList(),
                values: [
                  analysis.accountLeadAnalytics!.monthlyBreakdown!
                      .map((e) => e.accountLeadsCreated ?? 0)
                      .toList(),
                  analysis.accountLeadAnalytics!.monthlyBreakdown!
                      .map((e) => e.collected ?? 0)
                      .toList(),
                  analysis.accountLeadAnalytics!.monthlyBreakdown!
                      .map((e) => e.pending ?? 0)
                      .toList(),
                ],
                colors: const [MyColors.primary, MyColors.green, Colors.orange],
                legends: const ["Account Leads Created", "Collected", "Pending"],
              ),
            const Gap(20),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
