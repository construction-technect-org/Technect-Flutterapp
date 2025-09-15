import 'package:construction_technect/app/modules/Connector/ConnectorMarketplace/controllers/connector_market_place_controller.dart';
import 'package:get/get.dart';

class ConnectorMarketPlaceBinfing extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorMarketPlaceController>(() => ConnectorMarketPlaceController());
  }
}
