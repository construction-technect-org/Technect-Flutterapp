import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/BusinessHours/controller/business_hours_controller.dart';
import 'package:get/get.dart';

class BusinessHoursBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessHoursController>(() => BusinessHoursController());
  }
}
