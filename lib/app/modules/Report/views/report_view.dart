import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Report/controllers/report_controller.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: Obx(
            () => Text(controller.isReport.value ? 'Reports' : "Analysis"),
          ),
          isCenter: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                _buildGreeting(),
                const Gap(20),

                const Row(
                  children: [
                    ProductStatCard(
                      iconAsset: Asset.noOfPartner,
                      title: "Total Connectors",
                      value: "123",
                      subtitle: "Active Connectors",
                      subValue: "122.4K",
                    ),
                    Gap(5),
                    ProductStatCard(
                      iconAsset: Asset.noOfConectors,
                      title: "Total Products",
                      value: "543",
                      subtitle: "Active Products",
                      subValue: "122.4K",
                    ),
                    Gap(5),
                    ProductStatCard(
                      iconAsset: Asset.noOfUsers,
                      title: "Total Users",
                      value: "340",
                      subtitle: "Active Users",
                      subValue: "122.4K",
                    ),
                  ],
                ),
                const Gap(20),

                HeaderText(text: "Select month and download report"),
                const Gap(20),

                _buildMonthFilter(context),

                const Gap(20),
                _buildPeriodDropdown(),
                const Gap(20),
                Obx(
                  () => controller.isReport.value == true
                      ? RoundedButton(
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.white,
                            fontFamily: MyTexts.Roboto,
                          ),
                          verticalPadding: 0,

                          buttonName: "Download PDF",
                          onTap: () {
                            if (controller.selectedPeriod.value.isEmpty) {
                              controller.downloadReportPdf(isPeriod: false);
                            } else {
                              controller.downloadReportPdf(isPeriod: true);

                              // controller.fetchReportByDD();
                            }
                            // PDF generation logic
                            // generatePdfReport(controller.analysisModel.value);
                          },
                          width: 150,
                          height: 48,
                        )
                      : const SizedBox(),
                ),

                const Gap(20),

                // Charts
                _buildCharts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    final profile = Get.find<HomeController>().profileData.value.data?.user;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: 102,
              width: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFC6D7E2),
              ),
            ),
            Image.asset(Asset.con, height: 102, width: 88, fit: BoxFit.fill),
          ],
        ),
        const Gap(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning ${profile?.firstName ?? ""} ${profile?.lastName ?? ""}!",
                style: MyTexts.bold18.copyWith(
                  color: MyColors.primary,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              const Gap(5),
              Text(
                "Use this platform to manage your team, merchants, services and get analytic reports.",
                style: MyTexts.regular13.copyWith(
                  color: MyColors.black,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthFilter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final picked = await showMonthPicker(
                context: context,
                initialDate: controller.startMonth.value ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
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
              if (picked != null) controller.startMonth.value = picked;
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayD4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  controller.startMonth.value != null
                      ? DateFormat(
                          "MMM yyyy",
                        ).format(controller.startMonth.value!)
                      : "Start Month",
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
              final picked = await showMonthPicker(
                context: context,
                initialDate:
                    controller.endMonth.value ??
                    controller.startMonth.value!.add(const Duration(days: 30)),
                firstDate: controller.startMonth.value!.add(
                  const Duration(days: 30),
                ),
                lastDate: controller.startMonth.value!.add(
                  const Duration(days: 90),
                ),
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
              if (picked != null) controller.endMonth.value = picked;
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayD4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  controller.endMonth.value != null
                      ? DateFormat(
                          "MMM yyyy",
                        ).format(controller.endMonth.value!)
                      : "End Month",
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),
        RoundedButton(
          style: MyTexts.medium14.copyWith(
            color: MyColors.white,
            fontFamily: MyTexts.Roboto,
          ),
          verticalPadding: 0,

          buttonName: "Apply",
          onTap: controller.onApplyReport,
          width: 100,
          height: 48,
        ),
      ],
    );
  }

  Widget _buildPeriodDropdown() {
    return Obx(
      () => Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: controller.isReport.value ? null : 200,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grayD4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            isExpanded: true,
            underline: const SizedBox(),
            value: controller.selectedPeriod.value.isEmpty
                ? null
                : controller.selectedPeriod.value,
            hint: const Text("Select Period"),
            items: controller.periodOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              if (val != null) controller.onPeriodSelected(val);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCharts() {
    return Obx(() {
      if (!controller.isReport.value &&
          controller.analysisModel.value.productAnalytics != null) {
        final analysis = controller.analysisModel.value;
        return Column(
          children: [
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
              colors: const [MyColors.primary, MyColors.green, Colors.red],
              legends: const [
                "Products Added",
                "Active Products",
                "Rejected Products",
              ],
            ),
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
          border: Border.all(color: MyColors.grayD4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(iconAsset),
            const Gap(10),
            Text(
              title,
              style: MyTexts.regular14.copyWith(color: MyColors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              value,
              style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
            ),
            const Gap(10),
            Text(
              subtitle,
              style: MyTexts.regular14.copyWith(color: MyColors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              subValue,
              style: MyTexts.bold16.copyWith(color: subValueColor),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTexts.bold16),
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
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const Gap(6),
                    Text(
                      legends![i],
                      style: MyTexts.regular13.copyWith(color: MyColors.black),
                    ),
                  ],
                );
              }),
            ),
          ],
          const Gap(20),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
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
                          space: 20,
                          child: Transform.rotate(
                            angle: -1.5708,
                            child: Text(
                              label,
                              style: const TextStyle(fontSize: 10),
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
                      interval: 1,
                      getTitlesWidget: (value, meta) =>
                          Text(value.toInt().toString()),
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
}
