import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/controllers/connector_site_location_controller.dart';

class ConnectorSiteLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectorSiteLocationController>(
      () => ConnectorSiteLocationController(),
    );
  }
}
