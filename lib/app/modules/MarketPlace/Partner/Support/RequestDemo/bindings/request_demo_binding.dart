import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/controllers/request_demo_controller.dart';
import 'package:get/get.dart';

class RequestDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestDemoController>(() => RequestDemoController());
  }
}
