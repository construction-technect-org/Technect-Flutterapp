import 'package:construction_technect/app/modules/MarketPlace/Connector/SearchProduct/controller/search_product_controller.dart';
import 'package:get/get.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProductController>(() => SearchProductController());
  }
}
