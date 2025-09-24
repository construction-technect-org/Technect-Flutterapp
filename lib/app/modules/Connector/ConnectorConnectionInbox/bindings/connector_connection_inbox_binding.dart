import 'package:construction_technect/app/modules/Connector/ConnectorConnectionInbox/controllers/connector_connection_inbox_controller.dart';
import 'package:get/get.dart';

class ConnectorConnectionInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorConnectionInboxController>(() => ConnectorConnectionInboxController());
  }
}
