import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:get/get.dart';

class CRMBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CRMBottomController>(() => CRMBottomController());
  }
}
