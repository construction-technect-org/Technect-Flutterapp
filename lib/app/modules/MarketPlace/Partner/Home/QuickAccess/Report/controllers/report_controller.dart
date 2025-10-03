import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/model/analysis_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/services/AnalysisService.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ReportController extends GetxController {
  final statusCards = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxBool isReport = true.obs;

  final Rx<Analysis> analysisModel = Analysis().obs;

  Rx<DateTime?> startMonth = Rx<DateTime?>(null);
  Rx<DateTime?> endMonth = Rx<DateTime?>(null);

  final RxString selectedPeriod = "Last 6 Months".obs;
  final List<String> periodOptions = [
    "Last 3 Months",
    "Last 6 Months",
    "Last 9 Months",
    "Last 12 Months",
  ];

  Future<void> fetchAnalysis() async {
    if (startMonth.value == null || endMonth.value == null) {
      Get.snackbar("Error", "Please select both Start and End month");
      return;
    }
    if (startMonth.value!.isAfter(endMonth.value!)) {
      Get.snackbar("Error", "Start month must be before End month");
      return;
    }

    try {
      isLoading.value = true;
      final result = await AnalysisService().fetchAllAnalysis(
        startMonth: startMonth.value!.month.toString(),
        startYear: startMonth.value!.year.toString(),
        endMonth: endMonth.value!.month.toString(),
        endYear: endMonth.value!.year.toString(),
      );
      if (result != null && result.success == true) {
        analysisModel.value = result.data ?? Analysis();
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAnalysisByDD() async {
    try {
      isLoading.value = true;
      final result = await AnalysisService().fetchAllAnalysisByPeriod(
        period: selectedPeriod.value.toLowerCase(),
      );
      if (result != null && result.success == true) {
        analysisModel.value = result.data ?? Analysis();
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onPeriodSelected(String period) {
    selectedPeriod.value = period;
    startMonth.value = null;
    endMonth.value = null;
    if (!isReport.value) {
      fetchAnalysisByDD();
    }
  }

  void onApplyReport() {
    selectedPeriod.value = "";
    if (!isReport.value) {
      fetchAnalysis();
    }
  }

  Future<void> downloadReportPdf({required bool isPeriod}) async {
    try {
      isLoading.value = true;

      final pdfBytes = await AnalysisService().fetchReportPdfByPeriod(
        isPeriod: isPeriod,
        period: isPeriod ? selectedPeriod.value.toLowerCase() : "",
        startMonth: !isPeriod ? startMonth.value!.month.toString() : "",
        startYear: !isPeriod ? startMonth.value!.year.toString() : "",
        endMonth: !isPeriod ? endMonth.value!.month.toString() : "",
        endYear: !isPeriod ? endMonth.value!.year.toString() : "",
        token: myPref.getToken() ?? "",
      );

      if (pdfBytes != null) {
        Directory dir;

        if (Platform.isAndroid) {
          dir = Directory('/storage/emulated/0/Download');
          if (!await dir.exists()) {
            dir = await getApplicationDocumentsDirectory();
          }
        } else {
          dir = await getApplicationDocumentsDirectory();
        }

        final String filename =
            '${dir.path}/report_${selectedPeriod.value.toLowerCase()}${DateTime.now().microsecondsSinceEpoch}.pdf'
                .replaceAll(" ", "");
        final file = File(filename);
        await file.writeAsBytes(pdfBytes);

        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Success",
          middleText: "PDF downloaded successfully",
          textConfirm: "Open",
          textCancel: "Close",
          onConfirm: () {
            OpenFilex.open(file.path);
            Get.back();
          },
        );
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to download PDF",
          textConfirm: "OK",
          onConfirm: () => Get.back(),
        );
      }
    } catch (e) {
      if (kDebugMode) print("Error downloading PDF: $e");
      Get.defaultDialog(
        title: "Error",
        middleText: "Something went wrong",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isReport.value = Get.arguments["isReport"];
      // if (isReport.value == false) {
      fetchAnalysisByDD();
      // }
    }
  }
}
