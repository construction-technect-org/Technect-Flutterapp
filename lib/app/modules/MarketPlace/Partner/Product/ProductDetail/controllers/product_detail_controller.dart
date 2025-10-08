import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/models/rating_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/services/ProductDetailService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class ProductDetailsController extends GetxController {
  Product product = Product();
  ProfileModel profileData = ProfileModel.fromJson(
    myPref.getProfileData() ?? {},
  );
  final RxBool showProductDetails = false.obs;
  final RxBool isFromAdd = false.obs;
  final RxBool isFromConnector = false.obs;
  final RxBool isLoading = false.obs;
  final ProductDetailService _service = ProductDetailService();

  @override
  void onInit() {
    final argument = Get.arguments as Map;
    product = argument['product'] ?? Product();
    isFromAdd.value = argument["isFromAdd"];
    isFromConnector.value = argument["isFromConnector"];
    if(!isFromConnector.value){
      fetchReview(product.id??0);
    }
    super.onInit();
  }

  void onEditProduct() {
    Get.toNamed(
      Routes.ADD_PRODUCT,
      arguments: {"isEdit": true, 'product': product},
    );
  }

  final RxList<Ratings> reviewList = <Ratings>[].obs;

  Future<void> fetchReview(int id) async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAllReview(id: id.toString());
      if (result != null && result.success == true) {
        reviewList.assignAll(result.data?.ratings?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

}
