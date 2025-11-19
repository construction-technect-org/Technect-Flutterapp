import 'dart:math';

import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/controllers/report_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/widget/report_text_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.moreIBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    controller.isReport.value ? 'Reports' : "Analysis",
                  ),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(16),
                          ReportTextWidget(controller: controller),
                          const Gap(20),
                          Row(
                            children: [
                              if (myPref.role.val == "connector")
                                Obx(() {
                                  return ProductStatCard(
                                    iconAsset: Asset.totalProduct,
                                    title: "Total Merchants",
                                    value:
                                        controller
                                            .analysisModel
                                            .value
                                            .overallStatistics
                                            ?.totalMerchant
                                            .toString() ??
                                        "",
                                    subtitle: "Active Merchants",
                                    subValue:
                                        controller
                                            .analysisModel
                                            .value
                                            .overallStatistics
                                            ?.activeMerchant
                                            .toString() ??
                                        "",
                                  );
                                }),
                              if (myPref.role.val == "partner")
                                Obx(() {
                                  return ProductStatCard(
                                    iconAsset: Asset.totalProduct,
                                    title: "Total Connectors",
                                    value:
                                        controller
                                            .analysisModel
                                            .value
                                            .overallStatistics
                                            ?.totalConnectors
                                            .toString() ??
                                        "",
                                    subtitle: "Active Connectors",
                                    subValue:
                                        controller
                                            .analysisModel
                                            .value
                                            .overallStatistics
                                            ?.activeConnectors
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
                                      controller
                                          .analysisModel
                                          .value
                                          .overallStatistics
                                          ?.totalProducts
                                          .toString() ??
                                      "",
                                  subtitle: "Active Products",
                                  subValue:
                                      controller
                                          .analysisModel
                                          .value
                                          .overallStatistics
                                          ?.activeProducts
                                          .toString() ??
                                      "",
                                );
                              }),
                              const Gap(5),
                              Obx(() {
                                return ProductStatCard(
                                  iconAsset: Asset.totalProduct,

                                  title: "Total Users",
                                  value:
                                      controller
                                          .analysisModel
                                          .value
                                          .overallStatistics
                                          ?.totalUsers
                                          .toString() ??
                                      "",
                                  subtitle: "Active Users",
                                  subValue:
                                      controller
                                          .analysisModel
                                          .value
                                          .overallStatistics
                                          ?.activeUsers
                                          .toString() ??
                                      "",
                                );
                              }),
                            ],
                          ),

                          const Gap(20),

                          HeaderText(text: "Select month and download report"),
                          const Gap(20),

                          _buildMonthFilter(context),

                          const Gap(20),
                          _buildPeriodDropdown(),
                          const Gap(20),
                          // Charts
                          _buildCharts(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => controller.isReport.value == true
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RoundedButton(
                    buttonName: "Download PDF",
                    onTap: () {
                      if (controller.selectedPeriod.value.isEmpty) {
                        controller.downloadReportPdf(isPeriod: false);
                      } else {
                        controller.downloadReportPdf(isPeriod: true);
                      }
                    },
                    width: 150,
                    height: 48,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildMonthFilter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final DateTime nowMonth = DateTime(
                DateTime.now().year,
                DateTime.now().month,
              );
              final DateTime startInitial =
                  controller.startMonth.value ?? nowMonth;
              final picked = await showMonthPicker(
                context: context,
                initialDate: startInitial.isAfter(nowMonth)
                    ? nowMonth
                    : startInitial,
                firstDate: DateTime(2000),
                lastDate: nowMonth,
                monthPickerDialogSettings: const MonthPickerDialogSettings(
                  dialogSettings: PickerDialogSettings(
                    dialogRoundedCornersRadius: 20,
                    dialogBackgroundColor: Colors.white,
                  ),
                  headerSettings: PickerHeaderSettings(
                    headerBackgroundColor: MyColors.primary,
                  ),
                ),
              );
              if (picked != null) {
                controller.startMonth.value = DateTime(
                  picked.year,
                  picked.month,
                );
                // If previously selected end month is out of the 3-month window, reset it
                if (controller.endMonth.value != null) {
                  final end = DateTime(
                    controller.endMonth.value!.year,
                    controller.endMonth.value!.month,
                  );
                  final span = controller.inclusiveMonthSpan(
                    controller.startMonth.value!,
                    end,
                  );
                  final bool endInFuture = end.isAfter(nowMonth);
                  if (span > 12 ||
                      end.isBefore(controller.startMonth.value!) ||
                      endInFuture) {
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
                      ? DateFormat(
                          "MMM yyyy",
                        ).format(controller.startMonth.value!)
                      : "Start Month",
                  style: MyTexts.medium14.copyWith(
                    color: controller.startMonth.value != null
                        ? MyColors.gray2E
                        : MyColors.grayA5,
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
                Get.snackbar(
                  "Select Start Month",
                  "Please select a start month first",
                );
                return;
              }
              final DateTime start = DateTime(
                controller.startMonth.value!.year,
                controller.startMonth.value!.month,
              );
              final DateTime nowMonth = DateTime(
                DateTime.now().year,
                DateTime.now().month,
              );
              final DateTime lastAllowedRaw = controller.lastAllowedEndMonth(
                start,
              );
              final DateTime lastAllowed = lastAllowedRaw.isAfter(nowMonth)
                  ? nowMonth
                  : lastAllowedRaw;
              final DateTime initial = controller.endMonth.value != null
                  ? DateTime(
                      controller.endMonth.value!.year,
                      controller.endMonth.value!.month,
                    )
                  : start;
              final picked = await showMonthPicker(
                context: context,
                initialDate:
                    initial.isBefore(start) || initial.isAfter(lastAllowed)
                    ? start
                    : initial,
                firstDate: start,
                lastDate: lastAllowed,
                monthPickerDialogSettings: const MonthPickerDialogSettings(
                  dialogSettings: PickerDialogSettings(
                    dialogRoundedCornersRadius: 20,
                    dialogBackgroundColor: Colors.white,
                  ),
                  headerSettings: PickerHeaderSettings(
                    headerBackgroundColor: MyColors.primary,
                  ),
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
                      ? DateFormat(
                          "MMM yyyy",
                        ).format(controller.endMonth.value!)
                      : "End Month",
                  style: MyTexts.medium14.copyWith(
                    color: controller.endMonth.value != null
                        ? MyColors.gray2E
                        : MyColors.grayA5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodDropdown() {
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
          value: controller.selectedPeriod.value.isEmpty
              ? null
              : controller.selectedPeriod.value,
          hint: Text(
            "Select Period",
            style: MyTexts.medium14.copyWith(
              color: MyColors.primary.withValues(alpha: 0.5),
            ),
          ),
          items: controller.periodOptions
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                  ),
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

  Widget _buildCharts() {
    if (kDebugMode) {
      print(myPref.role.val);
    }
    return Obx(() {
      if (!controller.isReport.value) {
        final analysis = controller.analysisModel.value;
        return myPref.role.val == "partner"
            ? Column(
                children: [
                  if (analysis.productAnalytics != null)
                    ReportGraph(
                      title: "Products Analysis",
                      labels: analysis.productAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.productsAdded ?? 0)
                            .toList(),
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeProducts ?? 0)
                            .toList(),
                        analysis.productAnalytics!.monthlyBreakdown!
                            .map((e) => e.rejectedProducts ?? 0)
                            .toList(),
                      ],
                      colors: const [
                        MyColors.primary,
                        MyColors.green,
                        Colors.red,
                      ],
                      legends: const [
                        "Products Added",
                        "Active Products",
                        "Rejected Products",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.serviceAnalytics != null)
                    ReportGraph(
                      title: "Services Analysis",
                      labels: analysis.serviceAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.servicesAdded ?? 0)
                            .toList(),
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeServices ?? 0)
                            .toList(),
                        analysis.serviceAnalytics!.monthlyBreakdown!
                            .map((e) => e.rejectedServices ?? 0)
                            .toList(),
                      ],
                      colors: const [
                        MyColors.primary,
                        MyColors.green,
                        Colors.red,
                      ],
                      legends: const [
                        "Services Added",
                        "Active Services",
                        "Rejected Services",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.teamAnalytics != null)
                    ReportGraph(
                      title: "Team Analysis",
                      labels: analysis.teamAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.teamAnalytics!.monthlyBreakdown!
                            .map((e) => e.teamMembersAdded ?? 0)
                            .toList(),
                        analysis.teamAnalytics!.monthlyBreakdown!
                            .map((e) => e.availableTeamMembers ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green],
                      legends: const ["Added Member", "Active Member"],
                    ),
                  const Gap(10),

                  if (analysis.roleAnalytics != null)
                    ReportGraph(
                      title: "Role Analysis",
                      labels: analysis.roleAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.roleAnalytics!.monthlyBreakdown!
                            .map((e) => e.rolesCreated ?? 0)
                            .toList(),
                        analysis.roleAnalytics!.monthlyBreakdown!
                            .map((e) => e.activeRoles ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary, MyColors.green],
                      legends: const ["Role Created", "Active Role"],
                    ),
                  const Gap(10),
                  if (analysis.supportTicketAnalytics != null)
                    ReportGraph(
                      title: "Support Ticket Analysis",
                      labels: analysis.supportTicketAnalytics!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.openTickets ?? 0)
                            .toList(),
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.closedTickets ?? 0)
                            .toList(),
                        analysis.supportTicketAnalytics!.monthlyBreakdown!
                            .map((e) => e.resolvedTickets ?? 0)
                            .toList(),
                      ],
                      colors: const [Colors.orange, Colors.red, MyColors.green],
                      legends: const [
                        "Open Tickets",
                        "Closed Tickets",
                        "Resoled Tickets",
                      ],
                    ),
                  const Gap(20),
                ],
              )
            : Column(
                children: [
                  if (analysis.wishlist != null)
                    ReportGraph(
                      title: "WishList Analysis",
                      labels: analysis.wishlist!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.wishlist!.monthlyBreakdown!
                            .map((e) => e.itemsAdded ?? 0)
                            .toList(),
                      ],
                      colors: const [
                        MyColors.primary,
                        MyColors.green,
                        Colors.red,
                      ],
                      legends: const ["Item Added"],
                    ),
                  const Gap(10),
                  if (analysis.productConnections != null)
                    ReportGraph(
                      title: "Product Connections Analysis",
                      labels: analysis.productConnections!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productConnections!.monthlyBreakdown!
                            .map((e) => e.connectionsCreated ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.primary],
                      legends: const ["Product Connections Created"],
                    ),
                  const Gap(10),
                  if (analysis.serviceConnections != null)
                    ReportGraph(
                      title: "Service Connections Analysis",
                      labels: analysis.serviceConnections!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceConnections!.monthlyBreakdown!
                            .map((e) => e.serviceConnectionsCreated ?? 0)
                            .toList(),
                      ],
                      colors: const [MyColors.green],
                      legends: const ["Service Connections Created"],
                    ),
                  const Gap(10),
                  if (analysis.serviceRequirements != null)
                    ReportGraph(
                      title: "Service Requirements Analysis",
                      labels: analysis.serviceRequirements!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.requirementsCreated ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.pendingRequirements ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.fulfilledRequirements ?? 0)
                            .toList(),
                        analysis.serviceRequirements!.monthlyBreakdown!
                            .map((e) => e.cancelledRequirements ?? 0)
                            .toList(),
                      ],
                      colors: const [
                        MyColors.primary,
                        Colors.orange,
                        MyColors.green,
                        Colors.red,
                      ],
                      legends: const [
                        "Requirements Created",
                        "Pending Requirements",
                        "Fulfilled Requirements",
                        "Cancelled Requirements",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.productRequirements != null)
                    ReportGraph(
                      title: "Product Requirements Analysis",
                      labels: analysis.productRequirements!.monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.requirementsCreated ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.pendingRequirements ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.fulfilledRequirements ?? 0)
                            .toList(),
                        analysis.productRequirements!.monthlyBreakdown!
                            .map((e) => e.cancelledRequirements ?? 0)
                            .toList(),
                      ],
                      colors: const [
                        MyColors.primary,
                        Colors.orange,
                        MyColors.green,
                        Colors.red,
                      ],
                      legends: const [
                        "Requirements Created",
                        "Pending Requirements",
                        "Fulfilled Requirements",
                        "Cancelled Requirements",
                      ],
                    ),
                  const Gap(10),
                  if (analysis.connectorSupportTickets != null)
                    ReportGraph(
                      title: "Support Ticket Analysis",
                      labels: analysis
                          .connectorSupportTickets!
                          .monthlyBreakdown!
                          .map((e) => e.monthName!)
                          .toList(),
                      values: [
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.openTickets ?? 0)
                            .toList(),
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.closedTickets ?? 0)
                            .toList(),
                        analysis.connectorSupportTickets!.monthlyBreakdown!
                            .map((e) => e.resolvedTickets ?? 0)
                            .toList(),
                      ],
                      colors: const [Colors.orange, Colors.red, MyColors.green],
                      legends: const [
                        "Open Tickets",
                        "Closed Tickets",
                        "Resolved Tickets",
                      ],
                    ),

                  const Gap(20),
                ],
              );
      }
      return const SizedBox();
    });
  }
}

class ProductStatCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String value;
  final String subtitle;
  final String subValue;
  final Color subValueColor;

  const ProductStatCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subValue,
    this.subValueColor = MyColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.gra54EA),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(iconAsset, height: 50, width: 50, fit: BoxFit.cover),
            const Gap(10),
            Text(value, style: MyTexts.bold18.copyWith(color: MyColors.gray2E)),
            const Gap(2),
            Text(
              title,
              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),

            const Gap(10),
            Text(
              subValue,
              style: MyTexts.bold18.copyWith(color: MyColors.gray2E),
            ),
            const Gap(2),
            Text(
              subtitle,
              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class ReportGraph extends StatelessWidget {
  final String title;
  final List<String> labels;
  final List<List<int>> values;
  final List<Color> colors;
  final List<String>? legends;

  const ReportGraph({
    super.key,
    required this.title,
    required this.labels,
    required this.values,
    required this.colors,
    this.legends,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = values
        .expand((list) => list)
        .fold<int>(0, (prev, val) => val > prev ? val : prev);

    final double niceMax = _getNiceMax(maxY.toDouble());

    final double interval = niceMax / 5;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: MyColors.grayD4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTexts.medium17.copyWith(color: MyColors.gray2E)),
          const Gap(12),
          if (legends != null && legends!.isNotEmpty) ...[
            const Gap(4),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: List.generate(legends!.length, (i) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[i],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      legends![i],
                      style: MyTexts.medium13.copyWith(color: MyColors.gray54),
                    ),
                  ],
                );
              }),
            ),
          ],
          const Gap(24),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: niceMax,
                barGroups: List.generate(labels.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: List.generate(values.length, (j) {
                      return BarChartRodData(
                        toY: values[j][i].toDouble(),
                        color: colors[j],
                      );
                    }),
                  );
                }),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final label = labels[value.toInt()];
                        return SideTitleWidget(
                          meta: meta,
                          space: 0,
                          child: Transform.rotate(
                            angle: 0,
                            child: Text(
                              label.length > 3 ? label.substring(0, 3) : label,
                              textAlign: TextAlign.end,
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.grayA5,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: MyTexts.bold13.copyWith(
                            color: MyColors.grayA5,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: MyColors.grayD4),
                ),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getNiceMax(double maxY) {
    if (maxY <= 5) return 5;
    final double magnitude = pow(10, (log(maxY) / ln10).floor()).toDouble();
    final double normalized = maxY / magnitude;
    double niceNormalized;
    if (normalized < 1.5) {
      niceNormalized = 2;
    } else if (normalized < 3) {
      niceNormalized = 5;
    } else if (normalized < 7) {
      niceNormalized = 10;
    } else {
      niceNormalized = 20;
    }
    return (niceNormalized * magnitude).ceilToDouble();
  }
}
