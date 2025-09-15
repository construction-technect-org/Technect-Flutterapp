import 'package:construction_technect/app/modules/Connector/MainTab/controllers/main_tab_controller.dart';
import 'package:get/get.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(() => MainTabController());
  }
}
