import 'package:construction_technect/app/modules/FeedBack/controller/feedback_controller.dart';
import 'package:get/get.dart';

class FeedbackBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedBackController>(() => FeedBackController());
  }
}
