import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/widgets/month_filter.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/widgets/month_report.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/widgets/report_chart.dart';
import 'package:construction_technect/app/modules/CRM/more/analysis/widgets/report_dash_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/widget/report_text_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class AnalysisScreen extends GetView<AnalysisController> {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text("Analysis"),
                isCenter: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(16),
                        ReportTextWidget(isReport: controller.isReport.value),
                        const Gap(20),
                        const ReportDashWidget(),
                        const Gap(20),
                        HeaderText(text: "Select month and download report"),
                        const Gap(20),
                        const MonthReport(),
                        const Gap(10),
                        const MonthFilter(),
                        const Gap(20),
                        const ReportChart(),
                        const Gap(20),
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
    );
  }
}
