import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/model/cart_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/services/CartService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';

class CartListController extends GetxController {
  RxBool isLoading = false.obs;

  final CartListServices _service = CartListServices();
  Rx<AllCartModel> cartModel = AllCartModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Service> filteredServices = <Service>[].obs;
  RxString searchQuery = ''.obs;
  RxInt selectedTabIndex = 0.obs; // 0 = Product, 1 = Service
  Future<void> fetchCartList({bool? isLoad}) async {
    try {
      isLoading.value = isLoad ?? false;
      String? statusParam;
      if (selectedStatus.value != 'All') {
        statusParam = selectedStatus.value.toLowerCase();
      }
      final result = await _service.allCartList(status: statusParam);
      if (result.success == true) {
        cartModel.value = result;
        // Filter by selected tab
        _filterByTab();
      }
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _filterByTab() {
    if (selectedTabIndex.value == 0) {
      // Product tab
      filteredProducts.assignAll(cartModel.value.data?.products ?? []);
      // Apply search if there's a search query
      if (searchQuery.value.isNotEmpty) {
        searchProducts(searchQuery.value);
      }
    } else {
      // Service tab
      filteredServices.assignAll(cartModel.value.data?.services ?? []);
      // Apply search if there's a search query
      if (searchQuery.value.isNotEmpty) {
        searchServices(searchQuery.value);
      }
    }
  }

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
    searchController.clear();
    searchQuery.value = '';
    // Filter by selected tab
    _filterByTab();
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
                      false) ||
                  (product.categoryProductName?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false) ||
                  (product.address?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false) ||
                  (product.brand?.toLowerCase().contains(value.toLowerCase()) ??
                      false),
            )
            .toList(),
      );
    }
  }

  void searchServices(String? value) {
    searchQuery.value = value ?? '';
    if (value == null || value.isEmpty) {
      filteredServices.assignAll(cartModel.value.data?.services ?? []);
    } else {
      filteredServices.assignAll(
        (cartModel.value.data?.services ?? [])
            .where(
              (service) =>
                  (service.serviceCategoryName?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false) ||
                  (service.mainCategoryName?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false) ||
                  (service.subCategoryName?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false) ||
                  (service.description?.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ??
                      false),
            )
            .toList(),
      );
    }
  }

  void searchItems(String? value) {
    if (selectedTabIndex.value == 0) {
      searchProducts(value);
    } else {
      searchServices(value);
    }
  }

  RxString selectedStatus = 'All'.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCartList(isLoad: true);
  }
}
