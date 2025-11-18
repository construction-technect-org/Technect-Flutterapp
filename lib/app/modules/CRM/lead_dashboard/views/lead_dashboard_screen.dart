import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/analysis_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/lead_conversation_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/leads_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/pill_button.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/product_chart_widget.dart';

class LeadDashboardScreen extends GetView<LeadDashController> {
  const LeadDashboardScreen({super.key});

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
                    // const DashboardHeaderWidget(),
                    const CommonAppBar(
                      isCenter: false,
                      leading: SizedBox(),
                      leadingWidth: 0,
                      title: Text("Lead Dashboard"),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: PillButtonWithOuter(
                                      title: "Marketing",
                                      isSelected: controller.totalMarketing.value,
                                      onTap: () =>
                                          controller.toggleMarketingSalesAccounts("Marketing"),
                                    ),
                                  ),
                                ),
                                const Gap(8),

                                Obx(
                                  () => Expanded(
                                    child: PillButtonWithOuter(
                                      title: "Sales",
                                      isSelected: controller.totalSales.value,
                                      onTap: () => controller.toggleMarketingSalesAccounts("Sales"),
                                    ),
                                  ),
                                ),
                                const Gap(8),

                                Obx(
                                  () => Expanded(
                                    child: PillButtonWithOuter(
                                      title: "Accounts",
                                      isSelected: controller.totalAccounts.value,
                                      onTap: () =>
                                          controller.toggleMarketingSalesAccounts("Accounts"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(24),
                            Container(
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
                                        Text("Total Leads", style: MyTexts.medium18),
                                        const Gap(11),
                                        Text("98", style: MyTexts.medium18),
                                        const Gap(11),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE1FFD4),
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          child: Text(
                                            "+5.2%",
                                            style: MyTexts.bold16.copyWith(
                                              color: const Color(0xFF4FB523),
                                            ),
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
                            const Gap(24),
                            const LeadsSectionWidget(),
                            const Gap(24),
                             FunnelChartWidget(
                              funnelData: controller.funnelData,
                            ),
                            const Gap(24),
                            const ProductChartWidget(),
                            const Gap(24),
                            const ConversionRateChart(percentage: 78),
                            const Gap(24),
                          ],
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
