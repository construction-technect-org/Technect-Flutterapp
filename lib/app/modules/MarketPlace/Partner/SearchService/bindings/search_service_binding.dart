import 'package:construction_technect/app/modules/MarketPlace/Partner/SearchService/controller/search_service_controller.dart';
import 'package:get/get.dart';

class SearchServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchServiceController>(() => SearchServiceController());
  }
}
