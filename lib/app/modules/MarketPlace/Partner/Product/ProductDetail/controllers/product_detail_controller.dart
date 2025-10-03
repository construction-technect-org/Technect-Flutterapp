import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ProductDetailsController extends GetxController {
  Product product = Product();
  ProfileModel profileData = ProfileModel.fromJson(myPref.getProfileData() ?? {});
  final RxBool showProductDetails = false.obs;
  final RxBool isFromAdd = false.obs;

  @override
  void onInit() {
    final argument = Get.arguments as Map;
    product = argument['product'] ?? Product();
    isFromAdd.value = argument["isFromAdd"];
    super.onInit();
  }

  void onEditProduct() {
    Get.toNamed(Routes.ADD_PRODUCT, arguments: {"isEdit": true, 'product': product });
  }
}
