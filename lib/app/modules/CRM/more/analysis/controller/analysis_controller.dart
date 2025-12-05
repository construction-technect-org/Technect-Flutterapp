import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/model/analysis_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/services/AnalysisService.dart';

class AnalysisController extends GetxController {
  // final statusCards = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isReport.value = Get.arguments["isReport"];
    }
    fetchAnalysisByDD();
  }

  RxBool isLoading = false.obs;
  RxBool isReport = false.obs;

  final Rx<Analysis> analysisModel = Analysis().obs;

  Rx<DateTime?> startMonth = Rx<DateTime?>(null);
  Rx<DateTime?> endMonth = Rx<DateTime?>(null);
  final RxString selectedPeriod = "Last 3 Months".obs;
  final List<String> periodOptions = [
    "Last 3 Months",
    "Last 6 Months",
    "Last 9 Months",
    "Last 12 Months",
  ];

  int inclusiveMonthSpan(DateTime start, DateTime end) {
    final int months = (end.year - start.year) * 12 + (end.month - start.month) + 1;
    return months;
  }

  DateTime lastAllowedEndMonth(DateTime start) {
    return DateTime(start.year, start.month + 11);
  }

  void onApplyReport() {
    selectedPeriod.value = "";
    if (!isReport.value) {
      fetchAnalysis();
    }
  }

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
      final result = await AnalysisService().fetchAllCRMAnalysis(
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

  void onPeriodSelected(String period) {
    selectedPeriod.value = period;
    startMonth.value = null;
    endMonth.value = null;
    if (!isReport.value) {
      fetchAnalysisByDD();
    }
  }

  Future<void> fetchAnalysisByDD() async {
    try {
      isLoading.value = true;
      final result = await AnalysisService().fetchAllCRMAnalysisByPeriod(
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

  Future<void> downloadReportPdf({required bool isPeriod}) async {
    //   try {
    //     isLoading.value = true;

    //     final pdfBytes = await AnalysisService().fetchReportPdfByPeriod(
    //       isPeriod: isPeriod,
    //       period: isPeriod ? selectedPeriod.value.toLowerCase() : "",
    //       startMonth: !isPeriod ? startMonth.value!.month.toString() : "",
    //       startYear: !isPeriod ? startMonth.value!.year.toString() : "",
    //       endMonth: !isPeriod ? endMonth.value!.month.toString() : "",
    //       endYear: !isPeriod ? endMonth.value!.year.toString() : "",
    //       token: myPref.getToken(),
    //     );

    //     if (pdfBytes != null) {
    //       Directory dir;

    //       if (Platform.isAndroid) {
    //         dir = Directory('/storage/emulated/0/Download');
    //         if (!await dir.exists()) {
    //           dir = await getApplicationDocumentsDirectory();
    //         }
    //       } else {
    //         dir = await getApplicationDocumentsDirectory();
    //       }

    //       final String filename =
    //           '${dir.path}/report_${selectedPeriod.value.toLowerCase()}${DateTime.now().microsecondsSinceEpoch}.pdf'
    //               .replaceAll(" ", "");
    //       final file = File(filename);
    //       await file.writeAsBytes(pdfBytes);

    //       Get.defaultDialog(
    //         titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //         backgroundColor: Colors.white,
    //         title: "Success",
    //         titleStyle: MyTexts.medium16.copyWith(color: MyColors.gray2E),
    //         middleTextStyle: MyTexts.medium14.copyWith(color: MyColors.gray54),
    //         middleText: "PDF downloaded successfully",
    //         actions: [
    //           Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Flexible(
    //                 child: RoundedButton(
    //                   onTap: () => Get.back(),
    //                   buttonName: 'Cancel',
    //                   borderRadius: 12,
    //                   verticalPadding: 0,
    //                   height: 45,
    //                   color: MyColors.grayCD,
    //                 ),
    //               ),
    //               const SizedBox(width: 8),
    //               Flexible(
    //                 child: RoundedButton(
    //                   onTap: () {
    //                     OpenFilex.open(file.path);
    //                     Get.back();
    //                   },
    //                   buttonName: "Open",
    //                   borderRadius: 12,
    //                   verticalPadding: 0,
    //                   height: 45,
    //                   color: MyColors.primary,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       );
    //     } else {
    //       Get.defaultDialog(
    //         title: "Error",
    //         middleText: "Failed to download PDF",
    //         textConfirm: "OK",
    //         onConfirm: () => Get.back(),
    //       );
    //     }
    //   } catch (e) {
    //     if (kDebugMode) print("Error downloading PDF: $e");
    //     Get.defaultDialog(
    //       title: "Error",
    //       middleText: "Something went wrong",
    //       textConfirm: "OK",
    //       onConfirm: () => Get.back(),
    //     );
    //   } finally {
    //     isLoading.value = false;
    //   }
  }
}
