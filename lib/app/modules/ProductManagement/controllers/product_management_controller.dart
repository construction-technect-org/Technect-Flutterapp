import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/ProductManagement/service/product_management_service.dart';

class ProductManagementController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProductListModel> productModel = ProductListModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxString searchQuery = ''.obs;
  Rx<Statistics> statistics = Statistics().obs;

  @override
  void onInit() {
    super.onInit();
    _loadProductsFromStorage();
  }

  final ProductManagementService _service = ProductManagementService();

  Future<void> _loadProductsFromStorage() async {
    final cachedProductListModel = myPref.getProductListModel();
    if (cachedProductListModel != null) {
      productModel.value = cachedProductListModel;
      filteredProducts.assignAll(cachedProductListModel.data?.products ?? []);
      statistics.value = cachedProductListModel.data?.statistics ?? Statistics();
    } else {
      fetchProducts();
    }
  }

  void searchProduct(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(productModel.value.data?.products ?? []);
    } else {
      filteredProducts.clear();
      filteredProducts.value = (productModel.value.data?.products ?? []).where((product) {
        return (product.productName ?? '').toLowerCase().contains(value.toLowerCase()) ||
            (product.brand ?? '').toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredProducts.clear();
    filteredProducts.addAll(productModel.value.data?.products ?? []);
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final result = await _service.getProductList();
      if (result.success == true) {
        productModel.value = result;
        filteredProducts.clear();
        filteredProducts.addAll(result.data?.products ?? []);
        statistics.value = result.data?.statistics ?? Statistics();
        myPref.setProductListModel(result);
      } else {
        await _loadProductsFromStorage();
      }
    } catch (e) {
      await _loadProductsFromStorage();
    } finally {
      isLoading(false);
    }
  }
}
