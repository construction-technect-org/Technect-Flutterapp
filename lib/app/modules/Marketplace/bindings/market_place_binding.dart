import 'package:construction_technect/app/modules/Marketplace/controllers/market_place_controller.dart';
import 'package:get/get.dart';

class MarketPlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketPlaceController>(() => MarketPlaceController());
  }
}
