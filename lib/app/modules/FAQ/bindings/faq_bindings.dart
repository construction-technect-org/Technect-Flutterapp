import 'package:construction_technect/app/modules/FAQ/controller/faq_controller.dart';
import 'package:get/get.dart';

class FAQBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }
}
