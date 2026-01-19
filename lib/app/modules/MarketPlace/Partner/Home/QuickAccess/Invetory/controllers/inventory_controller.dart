import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/services/InventoryService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/service/product_management_service.dart';

class InventoryController extends GetxController {
  final ProductManagementService _productService = ProductManagementService();

  RxBool isLoading = false.obs;
  Rx<ProductListModel> productListModel = ProductListModel().obs;
  RxList<Product> filteredProducts = <Product>[].obs;

  Rx<AllServiceModel> serviceListModel = AllServiceModel().obs;
  RxList<Service> filteredService = <Service>[].obs;
  RxString searchQuery = ''.obs;

  RxString selectedStatus = "product".obs;
  /*  (Get.find<CommonController>().marketPlace.value == 0
              ? "product"
              : "service")
          .obs; */

  TextEditingController searchController = TextEditingController();

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
      if (selectedStatus.value == "product") {
        final result = await _productService.getProductList();
        if (result.success == true) {
          productListModel.value = result;
          filteredProducts.assignAll(result.data?.products ?? []);
          myPref.setProductListModel(result);
        } else {
          await _loadProductsFromStorage();
        }
      } else {
        final result = await InventoryService().getServiceList();
        if (result.success == true) {
          serviceListModel.value = result;
          filteredService.assignAll(result.data ?? []);
        }
      }
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String? value) {
    searchQuery.value = value ?? '';
    if (selectedStatus.value == "product") {
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
                        false) ||
                    (product.categoryProductName?.toLowerCase().contains(
                          value.toLowerCase(),
                        ) ??
                        false) ||
                    (product.address?.toLowerCase().contains(
                          value.toLowerCase(),
                        ) ??
                        false) ||
                    (product.brand?.toLowerCase().contains(
                          value.toLowerCase(),
                        ) ??
                        false),
              )
              .toList(),
        );
      }
    } else {
      if (value == null || value.isEmpty) {
        filteredService.assignAll(serviceListModel.value.data ?? []);
      } else {
        filteredService.assignAll(
          (serviceListModel.value.data ?? []).where(
            (s) =>
                (s.mainCategoryName?.toLowerCase().contains(
                      value.toLowerCase(),
                    ) ??
                    false) ||
                (s.subCategoryName?.toLowerCase().contains(
                      value.toLowerCase(),
                    ) ??
                    false) ||
                (s.serviceCategoryName?.toLowerCase().contains(
                      value.toLowerCase(),
                    ) ??
                    false),
          ),
        );
      }
    }
  }
}
