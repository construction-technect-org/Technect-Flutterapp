import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/report_view.dart';

class ReportDashWidget extends GetView<AnalysisController> {
  const ReportDashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(() {
              return ProductStatCard(
                iconAsset: Asset.totalProduct,
                title: "Total Leads",
                value: controller.analysisModel.value.leadAnalytics?.totalLeads.toString() ?? "0",
                subtitle: "Conversion Rate",
                subValue:
                    "${controller.analysisModel.value.leadAnalytics?.conversionToSalesRate?.toStringAsFixed(1) ?? "0"}%",
              );
            }),
            const Gap(5),
            Obx(() {
              return ProductStatCard(
                iconAsset: Asset.totalProduct,
                title: "Sales Leads",
                value:
                    controller.analysisModel.value.salesLeadAnalytics?.totalSalesLeads.toString() ??
                    "0",
                subtitle: "Win Rate",
                subValue:
                    "${controller.analysisModel.value.salesLeadAnalytics?.winRate?.toStringAsFixed(1) ?? "0"}%",
              );
            }),
            const Gap(5),
            Obx(() {
              return ProductStatCard(
                iconAsset: Asset.totalProduct,
                title: "Account Leads",
                value:
                    controller.analysisModel.value.accountLeadAnalytics?.totalAccountLeads
                        .toString() ??
                    "0",
                subtitle: "Collection Rate",
                subValue:
                    "${controller.analysisModel.value.accountLeadAnalytics?.collectionRate?.toStringAsFixed(1) ?? "0"}%",
              );
            }),
          ],
        ),
      ],
    );
  }
}
