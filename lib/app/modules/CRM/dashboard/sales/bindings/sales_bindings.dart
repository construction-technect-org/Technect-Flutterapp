import 'package:construction_technect/app/modules/CRM/dashboard/sales/controller/sales_controller.dart';
import 'package:get/get.dart';

class SalesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(() => SalesController());
  }
}
