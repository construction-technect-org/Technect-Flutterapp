import 'package:construction_technect/app/modules/MarketPlace/Partner/Category/newLanuch/controller/new_launch_controller.dart';
import 'package:get/get.dart';

class NewLaunchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewLaunchController>(() => NewLaunchController());
  }
}
