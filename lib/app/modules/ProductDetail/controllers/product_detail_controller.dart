import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {

Rx<Product> product = Product().obs;
var argument = Get.arguments;

@override
  void onInit() {
if(argument!=null){
  product.value=argument['product'];
}    super.onInit();
  }

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
