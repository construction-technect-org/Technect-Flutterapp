import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/RequestDemo/controllers/connector_request_demo_controller.dart';
import 'package:get/get.dart';

class ConnectorRequestDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorRequestDemoController>(() => ConnectorRequestDemoController());
  }
}
