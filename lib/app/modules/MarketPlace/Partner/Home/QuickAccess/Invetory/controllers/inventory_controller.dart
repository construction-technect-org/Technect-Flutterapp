import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/service/product_management_service.dart';


class InventoryController extends GetxController {
  final ProductManagementService _productService = ProductManagementService();

  RxBool isLoading = false.obs;
  Rx<ProductListModel> productListModel = ProductListModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProductsFromStorage();
    fetchProducts();
  }

  Future<void> _loadProductsFromStorage() async {
    final cachedProductListModel = myPref.getProductListModel();
    if (cachedProductListModel != null) {
      productListModel.value = cachedProductListModel;
      filteredProducts.assignAll(cachedProductListModel.data?.products ?? []);
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final result = await _productService.getProductList();
      if (result.success == true) {
        productListModel.value = result;
        filteredProducts.assignAll(result.data?.products ?? []);
        // Cache the complete model
        myPref.setProductListModel(result);
      } else {
        // Fallback to cached data if API fails
        await _loadProductsFromStorage();
      }
    } catch (e) {
      // Fallback to cached data if API fails
      await _loadProductsFromStorage();
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String? value) {
    searchQuery.value = value ?? '';
    if (value == null || value.isEmpty) {
      filteredProducts.assignAll(productListModel.value.data?.products ?? []);
    } else {
      filteredProducts.assignAll(
        (productListModel.value.data?.products ?? [])
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

  void clearSearch() {
    searchQuery.value = '';
    filteredProducts.assignAll(productListModel.value.data?.products ?? []);
  }
}
