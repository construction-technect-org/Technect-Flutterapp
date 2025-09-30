import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Report/controllers/report_controller.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(title: Obx(() {
          return Text(controller.isReport.value ? 'Reports' : "Analysis");
        }), isCenter: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Row(
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
                      Image.asset(
                        Asset.con,
                        height: 102,
                        width: 88,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  const Gap(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning ${Get
                              .find<HomeController>()
                              .profileData
                              .value
                              .data
                              ?.user
                              ?.firstName ?? ""} ${Get
                              .find<HomeController>()
                              .profileData
                              .value
                              .data
                              ?.user
                              ?.lastName ?? ""}!",
                          style: MyTexts.bold18.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          "Use thi Platform to manage your team, merchants, services and get a analytic report about the connectors, products and partners.",
                          style: MyTexts.regular13.copyWith(
                            color: MyColors.black,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        const Gap(5),

                        Obx(() {
                          return controller.isReport.value ? RoundedButton(
                            buttonName: "Download Reports",
                            onTap: () {},
                            height: 24,
                            width: 130,
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.white,
                              fontFamily: MyTexts.Roboto,
                            ),
                            verticalPadding: 0,
                          ) : const SizedBox();
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const Row(
                children: [
                  ProductStatCard(
                    iconAsset: Asset.noOfPartner,
                    title: "Total Connectors",
                    value: "123",
                    subtitle: "Active Connectors",
                    subValue: "122.4K",
                    subValueColor: MyColors.green,
                  ),
                  Gap(5),
                  ProductStatCard(
                    iconAsset: Asset.noOfConectors,
                    title: "Total Products",
                    value: "543",
                    subtitle: "Active Products",
                    subValue: "122.4K",
                    subValueColor: MyColors.green,
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
              Obx(() {
                return !controller.isReport.value ?  Column(
                  children: [
                    HeaderText(text: "Customer Support Ticket"),
                    const Gap(20),
                    const ReportGraph(),
                  ],
                ):const SizedBox();
              })

            ],
          ),
        ),
      ),
    );
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

class ReportGraph extends StatefulWidget {
  const ReportGraph({Key? key}) : super(key: key);

  @override
  State<ReportGraph> createState() => _ReportGraphState();
}

class _ReportGraphState extends State<ReportGraph> {
  String selectedRange = "Last 6 Months";

  // Example dummy data
  final Map<String, List<double>> data = {
    "Connectors": [10, 30, 40, 20, 50, 40, 70, 80, 60, 50, 30, 40],
    "Products": [20, 40, 30, 50, 60, 20, 40, 60, 70, 50, 40, 60],
    "Users": [15, 35, 25, 45, 30, 60, 50, 70, 80, 60, 45, 55],
  };

  List<String> monthLabels = [];

  @override
  void initState() {
    super.initState();
    _updateMonthLabels();
  }

  void _updateMonthLabels() {
    final DateTime now = DateTime.now();
    int length;

    switch (selectedRange) {
      case "Last 3 Months":
        length = 3;
      case "Last 6 Months":
        length = 6;
      case "1 Year":
        length = 12;
      case "All Data":
        length = 12;
      default:
        length = 6;
    }

    monthLabels = List.generate(length, (i) {
      final DateTime month = DateTime(
        now.year,
        now.month - (length - 1 - i),
      );
      return DateFormat.MMM().format(month);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayD4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Graph Analysis",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                value: selectedRange,
                dropdownColor: Colors.white,
                items: const [
                  DropdownMenuItem(
                    value: "Last 3 Months",
                    child: Text("Last 3 Months"),
                  ),
                  DropdownMenuItem(
                    value: "Last 6 Months",
                    child: Text("Last 6 Months"),
                  ),
                  DropdownMenuItem(value: "1 Year", child: Text("1 Year")),
                  DropdownMenuItem(value: "All Data", child: Text("All Data")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedRange = value;
                      _updateMonthLabels();
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barGroups: List.generate(monthLabels.length, (index) {
                  int realIndex =
                      DateTime
                          .now()
                          .month - monthLabels.length + index;
                  if (realIndex < 0) realIndex += 12;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data["Connectors"]![realIndex],
                        color: MyColors.green,
                      ),
                      BarChartRodData(
                        toY: data["Products"]![realIndex],
                        color: MyColors.primary,
                      ),
                      BarChartRodData(
                        toY: data["Users"]![realIndex],
                        color: MyColors.warning,
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < monthLabels.length) {
                          return Text(monthLabels[value.toInt()]);
                        }
                        return const Text("");
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(interval: 20),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(interval: 20),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(interval: 20),
                  ),
                ),
                gridData: const FlGridData(),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
