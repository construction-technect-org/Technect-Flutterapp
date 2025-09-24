import 'package:construction_technect/app/modules/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:get/get.dart';

class ConnectorFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorFilterController>(() => ConnectorFilterController());
  }
}
