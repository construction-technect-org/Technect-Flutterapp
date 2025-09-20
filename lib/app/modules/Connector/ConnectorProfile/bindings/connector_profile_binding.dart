import 'package:construction_technect/app/modules/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:get/get.dart';

class ConnectorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorProfileController>(() => ConnectorProfileController());
  }
}
