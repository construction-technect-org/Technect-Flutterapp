import 'package:construction_technect/app/modules/OnBoarding/controller/on_boarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(), fenix: true);
  }
}
