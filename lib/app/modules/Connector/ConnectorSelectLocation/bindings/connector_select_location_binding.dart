import 'package:construction_technect/app/modules/Connector/ConnectorSelectLocation/controllers/connector_select_location_controller.dart';
import 'package:get/get.dart';

class ConnectorSelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorSelectLocationController>(() => ConnectorSelectLocationController());
  }
}
