import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/SuppoerRequestFilter/controller/support_request_controller.dart';
import 'package:get/get.dart';

class SupportRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportRequestController>(() => SupportRequestController());
  }
}
