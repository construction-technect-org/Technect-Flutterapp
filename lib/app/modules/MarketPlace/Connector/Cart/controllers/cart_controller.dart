import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/model/cart_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/services/CartService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';

class CartListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaderWrapper = false.obs;

  final CartListServices _service = CartListServices();
  Rx<AllCartModel> cartModel = AllCartModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxString searchQuery = ''.obs;
  Future<void> fetchCartList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad??false;
      String? statusParam;
      if (selectedStatus.value != 'All') {
        statusParam = selectedStatus.value.toLowerCase();
      }
      final result = await _service.allCartList(status: statusParam);
      if (result.success == true) {
        cartModel.value = result;
        filteredProducts.assignAll(result.data?.products ?? []);
      }
      isLoading.value=false;
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
      filteredProducts.assignAll(cartModel.value.data?.products ?? []);
    } else {
      filteredProducts.assignAll(
        (cartModel.value.data?.products ?? [])
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

  RxString selectedStatus = 'All'.obs;
  RxString selectedMainStatus = 'product'.obs;
TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCartList(isLoad: true);
  }
}
