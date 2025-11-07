import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:get/get.dart';

class ConnectionInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionInboxController>(() => ConnectionInboxController());
  }
}
