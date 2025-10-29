import 'package:get/get.dart';
import '../controller/search_product_controller.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProductController>(() => SearchProductController());
  }
}
