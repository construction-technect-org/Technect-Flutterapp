import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/ProductManagement/service/product_management_service.dart';
import 'package:get/get.dart';

class ProductManagementController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProductListModel> productModel = ProductListModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxString searchQuery = ''.obs;
  Rx<Statistics> statistics = Statistics().obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  final ProductManagementService _service = ProductManagementService();

  void searchProduct(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(productModel.value.data?.products ?? []);
    } else {
      filteredProducts.clear();
      filteredProducts.value = (productModel.value.data?.products ?? []).where((
        product,
      ) {
        return (product.productName ?? '').toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            (product.brand ?? '').toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      productModel.value = await _service.getProductList();
      filteredProducts.clear();
      filteredProducts.addAll(productModel.value.data?.products ?? []);
      statistics.value = productModel.value.data?.statistics ?? Statistics();
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
