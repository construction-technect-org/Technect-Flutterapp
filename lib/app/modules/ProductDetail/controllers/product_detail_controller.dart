import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {

Rx<Product> product = Product().obs;
// ignore: type_annotate_public_apis
var argument = Get.arguments;

@override
  void onInit() {
if(argument!=null){
  product.value=argument['product'];
}    super.onInit();
  }

 

  /// Function to navigate to edit product
  void onEditProduct() {
    Get.toNamed(
      Routes.ADDP_PRODUCT,
      arguments: {"isEdit": true},
    );
  }
}
