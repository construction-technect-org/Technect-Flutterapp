import 'package:construction_technect/app/modules/CRM/more/analysis/controller/analysis_controller.dart';
import 'package:get/get.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisController>(() => AnalysisController());
  }
}
