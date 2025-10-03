import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/controllers/report_controller.dart';
import 'package:get/get.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }
}
