import 'package:construction_technect/app/modules/Connector/ConnectorProductDetails/controller/connector_product_details_controller.dart';
import 'package:get/get.dart';

class ConnectorProductDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorProductDetailsController>(() => ConnectorProductDetailsController());
  }
}
