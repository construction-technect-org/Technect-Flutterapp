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
            if (myPref.role.val == "connector")
              Obx(() {
                return ProductStatCard(
                  iconAsset: Asset.totalProduct,
                  title: "Total Merchants",
                  value:
                      controller.analysisModel.value.overallStatistics?.totalMerchant.toString() ??
                      "98",
                  subtitle: "Active Merchants",
                  subValue:
                      controller.analysisModel.value.overallStatistics?.activeMerchant.toString() ??
                      "98",
                );
              }),
            if (myPref.role.val == "partner")
              Obx(() {
                return ProductStatCard(
                  iconAsset: Asset.totalProduct,
                  title: "Total Connectors",
                  value:
                      controller.analysisModel.value.overallStatistics?.totalConnectors
                          .toString() ??
                      "98",
                  subtitle: "Active Connectors",
                  subValue:
                      controller.analysisModel.value.overallStatistics?.activeConnectors
                          .toString() ??
                      "",
                );
              }),

            const Gap(5),
            Obx(() {
              return ProductStatCard(
                iconAsset: Asset.totalProduct,
                title: "Total Products",
                value:
                    controller.analysisModel.value.overallStatistics?.totalProducts.toString() ??
                    "98",
                subtitle: "Active Products",
                subValue:
                    controller.analysisModel.value.overallStatistics?.activeProducts.toString() ??
                    "98",
              );
            }),
            const Gap(5),
            Obx(() {
              return ProductStatCard(
                iconAsset: Asset.totalProduct,

                title: "Total Users",
                value:
                    controller.analysisModel.value.overallStatistics?.totalUsers.toString() ?? "98",
                subtitle: "Active Users",
                subValue:
                    controller.analysisModel.value.overallStatistics?.activeUsers.toString() ??
                    "98",
              );
            }),
          ],
        ),
      ],
    );
  }
}
