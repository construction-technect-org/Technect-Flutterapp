import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {


  RxList<String> specifications = <String>[
    "Particle size ranging from 0 to 4.75mm.",
    "High compressive strength.",
    "Free from impurities.",
    "Durable and long-lasting.",
  ].obs;

 

  /// Function to navigate to edit product
  void onEditProduct() {
    Get.toNamed(
      Routes.ADDP_PRODUCT,
      arguments: {"isEdit": true},
    );
  }
}
