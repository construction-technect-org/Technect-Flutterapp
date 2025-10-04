import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorBottom/controllers/connector_main_tab_controller.dart';
import 'package:get/get.dart';

class ConnectorMainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorBottomController>(() => ConnectorBottomController());
  }
}
