import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Report/model/analysis_model.dart';
import 'package:construction_technect/app/modules/Report/services/AnalysisService.dart';

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
        selectedPeriod.value = "";
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
        startMonth.value = null;
        endMonth.value = null;
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      isReport.value = Get.arguments["isReport"];
      if (isReport.value == false) {
        fetchAnalysisByDD();
      }
    }
  }
}
