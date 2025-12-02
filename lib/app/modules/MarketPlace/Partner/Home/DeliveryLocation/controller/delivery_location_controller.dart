import 'package:construction_technect/app/core/utils/imports.dart';

class DeliveryLocationController extends GetxController {
  // Observable variables
  RxBool isLoading = false.obs;

  // Add new address
  void addAddress() {
    Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
  }
}
