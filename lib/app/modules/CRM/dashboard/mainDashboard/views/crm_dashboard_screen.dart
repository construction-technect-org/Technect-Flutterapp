import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/no_permission_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/controller/crm_dashboard_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/model/dashboard_model.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/analysis_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/crm_header.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/lead_conversation_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/leads_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/product_chart_widget.dart';

class CRMDashboardScreen extends GetView<CRMDashboardController> {
  const CRMDashboardScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                      child:  CrmHeader(),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.refreshDashboard();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(8),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: AlignmentGeometry.topCenter,
                                    end: AlignmentGeometry.bottomCenter,
                                    colors: [MyColors.custom("FFF9BD"), Colors.white],
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),

                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tabBar(
                                        onTap: () =>
                                            controller.toggleMarketingSalesAccounts("Marketing"),
                                        icon: Asset.MM,
                                        name: 'Marketing',
                                        isMarketPlace: controller.totalMarketing.value,
                                      ),
                                      tabBar(
                                        onTap: () =>
                                            controller.toggleMarketingSalesAccounts("Sales"),
                                        icon: Asset.bar_chart,
                                        name: 'Sales',
                                        isMarketPlace: controller.totalSales.value,
                                      ),
                                      tabBar(
                                        onTap: () =>
                                            controller.toggleMarketingSalesAccounts("Accounts"),
                                        icon: Asset.users,
                                        name: 'Accounts',
                                        isMarketPlace: controller.totalAccounts.value,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(24),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Obx(
                                  () {
                                    if (!controller.canShowCurrentTab(controller)) {
                                      return  Padding(
                                        padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/4),
                                        child: const NoPermissionWidget(
                                          message: 'No permission for this section',
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        TotalCount(
                                          title: controller.totalCount(1),
                                          count: controller.totalCount(2),
                                          percentage: controller.totalCount(3),
                                          onTap: controller.navigtionInLead,
                                        ),
                                        if (controller.totalAccounts.value)
                                          Obx(() {
                                            final totalDue = controller.totalDue;
                                            return Column(
                                              children: [
                                                const Gap(24),
                                                TotalCount(
                                                  title: totalDue?.title ?? "Total Due",
                                                  count: totalDue != null
                                                      ? "₹ ${controller.formatCurrency(totalDue.count)}"
                                                      : "₹ 1,25,000",
                                                  percentage: totalDue != null
                                                      ? "${totalDue.percentageChange >= 0 ? "+" : ""}${totalDue.percentageChange.toStringAsFixed(1)}%"
                                                      : controller.totalCount(3),
                                                  onTap: controller.navigtionInLead,
                                                ),
                                              ],
                                            );
                                          })
                                        else
                                          const SizedBox.shrink(),
                                        const Gap(24),
                                        const LeadsSectionWidget(),
                                        const Gap(24),
                                        FunnelChartWidget(funnelData: controller.funnelData),
                                        const Gap(24),
                                        const ProductChartWidget(),
                                        const Gap(24),
                                        if (controller.totalMarketing.value)
                                          Obx(
                                                () => ConversionRateChart(
                                              percentage: controller.conversionRate,
                                            ),
                                          )
                                        else if (controller.totalSales.value)
                                          Obx(
                                                () => RevenueSummaryWidget(
                                              revenueSummary: controller.revenueSummary,
                                            ),
                                          )
                                        else
                                          const SizedBox.shrink(),
                                        const Gap(24),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalCount extends StatelessWidget {
  final String title;
  final String count;
  final String percentage;
  final void Function()? onTap;

  const TotalCount({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.grayD4),
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: MyTexts.medium18),
                  const Gap(11),
                  Text(count, style: MyTexts.medium18),
                  const Gap(11),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1FFD4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      percentage,
                      style: MyTexts.bold16.copyWith(color: const Color(0xFF4FB523)),
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(Asset.chartGreen),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

Widget tabBar({
  required String icon,
  required String name,
  required bool isMarketPlace,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(icon, height: 24, width: 24),
        Text(name, style: MyTexts.medium14, textAlign: TextAlign.center),
        const Gap(10),
        if (isMarketPlace)
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 3,
            width: 73,
            decoration: const BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          )
        else
          const SizedBox(height: 3, width: 73),
      ],
    ),
  );
}

class RevenueSummaryWidget extends StatelessWidget {
  final RevenueSummary? revenueSummary;

  const RevenueSummaryWidget({super.key, this.revenueSummary});

  String _formatCurrency(int amount) {
    if (amount >= 100000) {
      return "${(amount / 100000).toStringAsFixed(2)}L";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(0)}K";
    }
    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final summary = revenueSummary;
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Revenue Summary", style: MyTexts.bold20),
          const Gap(15),
          Text(
            "Total Revenue : ₹ ${summary != null ? _formatCurrency(summary.totalRevenue) : "12,50,000"}",
            style: MyTexts.medium14,
            textAlign: TextAlign.start,
          ),
          const Gap(15),
          Text(
            "This Month      : ₹ ${summary != null ? _formatCurrency(summary.thisMonth) : "50,000"}",
            style: MyTexts.medium14,
          ),
          const Gap(15),
          Text(
            "Pending Payments : ₹ ${summary != null ? _formatCurrency(summary.pendingPayments) : "45,000"}",
            style: MyTexts.medium14,
          ),
          const Gap(15),
          Text(
            "Closed Deals  : ${summary != null ? summary.closedDeals.toString() : "45"}",
            style: MyTexts.medium14,
          ),
        ],
      ),
    );
  }
}
