import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/SuppoerRequestFilter/controller/connector_support_request_controller.dart';
import 'package:get/get.dart';

class ConnectorSupportRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorSupportRequestController>(
      () => ConnectorSupportRequestController(),
    );
  }
}
