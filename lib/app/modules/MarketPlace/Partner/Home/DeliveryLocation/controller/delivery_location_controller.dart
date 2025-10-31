import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class DeliveryLocationController extends GetxController {
  HomeController homeController = Get.find();
  // Observable variables
  RxBool isLoading = false.obs;

  // Add new address
  void addAddress() {
    Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
  }


}
