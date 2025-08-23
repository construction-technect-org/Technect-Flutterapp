import 'package:construction_technect/app/modules/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:get/get.dart';

class SignUpDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpDetailsController>(() => SignUpDetailsController());
  }
}
