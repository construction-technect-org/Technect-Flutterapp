import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/controllers/news_controller.dart';
import 'package:get/get.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
