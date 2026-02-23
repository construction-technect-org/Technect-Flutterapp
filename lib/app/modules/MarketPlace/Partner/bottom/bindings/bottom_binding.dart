import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';
import 'package:get/get.dart';

class BottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomController>(() => BottomController());
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}
