import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/model/wishlist_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class WishListController extends GetxController {
  RxBool isLoading = false.obs;
  final WishListServices _service = WishListServices();
  Rx<AllWishListModel> productListModel = AllWishListModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxString searchQuery = ''.obs;
  Future<void> fetchWishList() async {
    try {
      isLoading.value = true;
      final result = await _service.allWishList();
      if (result.success == true) {
        productListModel.value = result;
        filteredProducts.assignAll(result.data ?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
  void searchProducts(String? value) {
    searchQuery.value = value ?? '';
    if (value == null || value.isEmpty) {
      filteredProducts.assignAll(productListModel.value.data ?? []);
    } else {
      filteredProducts.assignAll(
        (productListModel.value.data ?? [])
            .where(
              (product) =>
          (product.productName?.toLowerCase().contains(
            value.toLowerCase(),
          ) ??
              false) ||
              (product.mainCategoryName?.toLowerCase().contains(
                value.toLowerCase(),
              ) ??
                  false) ||
              (product.subCategoryName?.toLowerCase().contains(
                value.toLowerCase(),
              ) ??
                  false)
              ||
              (product.categoryProductName?.toLowerCase().contains(value.toLowerCase()) ??
                  false)
              ||
              (product.address?.toLowerCase().contains(value.toLowerCase()) ??
                  false)
              ||
              (product.brand?.toLowerCase().contains(value.toLowerCase()) ??
                  false),

        )
            .toList(),
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWishList();
  }
}
