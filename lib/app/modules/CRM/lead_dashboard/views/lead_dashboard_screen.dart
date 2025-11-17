import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/analysis_section_widget.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/views/widget/dashboard_header_widget.dart';
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
                  image: DecorationImage(
                    image: AssetImage(Asset.categoryBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const DashboardHeaderWidget(),
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
                                  () => PillButtonWithOuter(
                                    title: "Marketing",
                                    isSelected: controller.totalMarketing.value,
                                    onTap: () =>
                                        controller.toggleMarketingSalesAccounts(
                                          "Marketing",
                                        ),
                                  ),
                                ),
                                Obx(
                                  () => PillButtonWithOuter(
                                    title: "Sales",
                                    isSelected: controller.totalSales.value,
                                    onTap: () => controller
                                        .toggleMarketingSalesAccounts("Sales"),
                                  ),
                                ),

                                Obx(
                                  () => PillButtonWithOuter(
                                    title: "Accounts",
                                    isSelected: controller.totalAccounts.value,
                                    onTap: () =>
                                        controller.toggleMarketingSalesAccounts(
                                          "Accounts",
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(24),
                            const LeadsSectionWidget(),
                            const Gap(24),
                            const ProductChartWidget(),
                            const Gap(24),
                            const AnalysisSectionWidget(),
                            const Gap(24),
                            const LeadConversationSectionWidget(),
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
