import 'package:construction_technect/app/modules/MarketPlace/Partner/More/ReferAndCoupon/controller/refer_controller.dart';
import 'package:get/get.dart';

class ReferBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferController>(() => ReferController());
  }
}
