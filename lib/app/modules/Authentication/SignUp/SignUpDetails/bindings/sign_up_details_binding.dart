import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/sign_up_service.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/aadhar_verification_controller.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:get/get.dart';

class SignUpDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainSignUpService());
    Get.put(SignUpDetailsController());
    Get.put(AadharVerifcationController());
  }
}
