import 'package:construction_technect/app/modules/Connector/ListOfMerchant/controllers/list_0f_merchant_controller.dart';
import 'package:get/get.dart';

class ListOfMerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListOfMerchantController>(() => ListOfMerchantController());
  }
}
