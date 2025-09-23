import 'package:construction_technect/app/modules/Connector/ConnectorAddLocationManually/controllers/connector_add_location_manually_controller.dart';
import 'package:get/get.dart';

class ConnectorAddLocationManuallyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorAddLocationManuallyController>(() => ConnectorAddLocationManuallyController());
  }
}
