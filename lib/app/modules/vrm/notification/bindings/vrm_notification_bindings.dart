import 'package:construction_technect/app/modules/vrm/notification/controllers/vrm_notification_controller.dart';
import 'package:get/get.dart';

class VrmNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VrmNotificationController>(() => VrmNotificationController());
  }
}
