import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorAddLocation/controllers/connector_add_location_controller.dart';
import 'package:get/get.dart';

class ConnectorAddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorAddLocationController>(() => ConnectorAddLocationController());
  }
}
