import 'package:construction_technect/app/modules/FeatureDashBoard/DashboardMarketPlace/controllers/market_place_controller.dart';
import 'package:get/get.dart';

class DashboardMarketPlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardMarketPlaceController>(
      () => DashboardMarketPlaceController(),
    );
  }
}
