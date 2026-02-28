import 'package:construction_technect/app/core/widgets/error_sheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/controller/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/marketplace_products_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/services/connector_home_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/components/connection_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SubCategoryController extends GetxController {
  final ConnectorHomeService connectorHomeService = ConnectorHomeService();

  /// 🔥 COMMON LOADING
  final RxBool isLoadingSubCategories = false.obs;

  /// 🔥 SUB CATEGORY
  final RxList<SubCategory> subCategoryList = <SubCategory>[].obs;
  final RxInt selectedSubCategoryIndex = 0.obs;
  final RxString selectedCategoryName = ''.obs;

  /// 🔥 PRODUCT CATEGORY (Left Menu)
  final RxList<SubCategoryItem> productList = <SubCategoryItem>[].obs;
  final RxInt selectedProductIndex = 0.obs;
  final RxBool isLoadingProductCategories = false.obs;

  /// 🔥 MARKETPLACE PRODUCTS (Right Grid)
  final RxList<MarketplaceProduct> marketplaceProducts = <MarketplaceProduct>[].obs;
  final RxBool isLoadingProducts = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxString searchQuery = ''.obs;
  final RxBool inStockOnly = false.obs;
  final RxString minPrice = ''.obs;
  final RxString maxPrice = ''.obs;

  final RxBool isGridView = false.obs;

  // Pagination Scroll Controllers
  final ScrollController gridScrollController = ScrollController();
  final ScrollController listScrollController = ScrollController();

  // Connection tracking
  final RxMap<String, String> connectionStatuses = <String, String>{}.obs;
  final RxBool isConnecting = false.obs;
  late GetStorage _storage;

  @override
  void onInit() {
    super.onInit();
    _storage = GetStorage();
    gridScrollController.addListener(_onGridScroll);
    listScrollController.addListener(_onListScroll);
  }

  @override
  void onClose() {
    gridScrollController.dispose();
    listScrollController.dispose();
    super.onClose();
  }

  void _onGridScroll() {
    if (gridScrollController.position.pixels >=
        gridScrollController.position.maxScrollExtent - 200) {
      _loadMoreProducts();
    }
  }

  void _onListScroll() {
    if (listScrollController.position.pixels >=
        listScrollController.position.maxScrollExtent - 200) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    if (!isLoadingProducts.value && hasMoreData.value) {
      final currentProdIndex = selectedProductIndex.value;
      if (productList.isNotEmpty && currentProdIndex < productList.length) {
        loadProducts(
          categoryId: productList[currentProdIndex].id,
          index: currentProdIndex,
          loadMore: true,
        );
      }
    }
  }

  // ===============================
  // ✅ LOAD SUB CATEGORY
  // ===============================
  Future<void> loadSubCategory({
    required String categoryId,
    required int index,
    required String categoryName,
  }) async {
    selectedSubCategoryIndex.value = index;
    selectedCategoryName.value = categoryName;

    isLoadingSubCategories.value = true;
    subCategoryList.clear();
    productList.clear();

    try {
      final response = await connectorHomeService.getSubCategory(categoryId);

      subCategoryList.assignAll(response.data ?? []);

      /// 🔥 AUTO CALL FIRST SUB-CATEGORY'S CATEGORY-PRODUCTS
      if (subCategoryList.isNotEmpty) {
        await loadProductCategory(subCategoryId: subCategoryList.first.id, index: 0);
      }
    } catch (e) {
      subCategoryList.clear();
    } finally {
      isLoadingSubCategories.value = false;
    }
  }

  // ===============================
  // ✅ LOAD PRODUCT CATEGORY (Left Menu)
  // ===============================
  Future<void> loadProductCategory({required String subCategoryId, required int index}) async {
    selectedProductIndex.value = index;

    isLoadingProductCategories.value = true;
    productList.clear();

    try {
      final response = await connectorHomeService.getSubCategoryItem(subCategoryId);

      productList.assignAll(response.data ?? []);

      /// 🔥 AUTO CALL FIRST CATEGORY-PRODUCT'S MARKETPLACE PRODUCTS
      if (productList.isNotEmpty) {
        await loadProducts(categoryId: productList.first.id, index: 0);
      } else {
        // Clear products if no subcategories exist
        marketplaceProducts.clear();
      }
    } catch (e) {
      productList.clear();
      marketplaceProducts.clear();
    } finally {
      isLoadingProductCategories.value = false;
    }
  }

  // ===============================
  // ✅ LOAD PRODUCTS (DYNAMIC API)
  // ===============================
  Future<void> loadProducts({
    required String? categoryId,
    required int index,
    bool loadMore = false,
  }) async {
    if (categoryId == null || categoryId.isEmpty) return;

    if (loadMore) {
      if (!hasMoreData.value) return;
      currentPage.value++;
    } else {
      currentPage.value = 1;
      hasMoreData.value = true;
      marketplaceProducts.clear();
      selectedProductIndex.value = index;
    }

    isLoadingProducts.value = true;

    try {
      // Fetch dynamic inventoryType from ConnectorHomeController
      final hc = Get.find<ConnectorHomeController>();
      String inventoryType = '';
      if (hc.connectorModuleData.value.data?.modules != null &&
          hc.connectorModuleData.value.data!.modules!.isNotEmpty) {
        // get the currently active module (we know the active module index is marketPlace.value)
        final mIndex = hc.marketPlace.value;
        if (mIndex >= 0 && mIndex < hc.connectorModuleData.value.data!.modules!.length) {
          final activeModule = hc.connectorModuleData.value.data!.modules![mIndex];
          inventoryType = activeModule.name?.toLowerCase() ?? '';
        }
      }

      final response = await connectorHomeService.getProducts(
        categoryProductId: categoryId,
        inventoryType: inventoryType,
        page: currentPage.value,
        limit: 20,
        search: searchQuery.value,
        inStockOnly: inStockOnly.value ? true : null,
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
      );

      if (loadMore) {
        marketplaceProducts.addAll(response.data);
      } else {
        marketplaceProducts.assignAll(response.data);
      }

      totalPages.value = response.totalPages;
      if (currentPage.value >= totalPages.value) {
        hasMoreData.value = false;
      }
      _checkLocalConnectionStatuses(); // Hydrate the connection status map
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoadingProducts.value = false;
    }
  }

  void _checkLocalConnectionStatuses() {
    for (var product in marketplaceProducts) {
      if (product.id != null) {
        String? status = _storage.read('connection_status_${product.id}');
        if (status != null) {
          connectionStatuses[product.id!] = status;
        }
      }
    }
  }

  void _saveConnectionStatus(String inventoryId, String status) {
    connectionStatuses[inventoryId] = status;
    _storage.write('connection_status_$inventoryId', status);
  }

  void showConnectConfirmationDialog(String merchantId, String inventoryId, String businessName) {
    final currentStatus = connectionStatuses[inventoryId] ?? 'Connect';
    if (currentStatus == 'Requested' || currentStatus == 'Connected') {
      Get.snackbar("Info", "Connection request already pending.");
      return;
    }

    ConnectionDialogs.showConnectDialog(
      context: Get.context!,
      businessName: businessName,
      onConfirm: () => _requestConnection(merchantId, inventoryId),
    );
  }

  Future<void> _requestConnection(String merchantId, String inventoryId) async {
    isConnecting.value = true;
    try {
      final response = await connectorHomeService.requestConnection(merchantId);

      if (response['success'] == true) {
        _saveConnectionStatus(inventoryId, 'Requested');
        Get.snackbar(
          "Success",
          "Connection request sent successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
        );
      } else {
        final msg = response['message'] ?? "Failed to request connection";
        if (msg.toString().toLowerCase().contains("already pending") ||
            msg.toString().toLowerCase().contains("requested")) {
          _saveConnectionStatus(inventoryId, 'Requested');
        }
        showErrorSheet(msg);
      }
    } catch (e) {
      final errorMsg = e.toString();
      if (errorMsg.toLowerCase().contains("already pending") ||
          errorMsg.toLowerCase().contains("already requested")) {
        _saveConnectionStatus(inventoryId, 'Requested');
        Get.snackbar("Info", "Connection request already pending.");
      } else {
        showErrorSheet("Failed to send connection request. Please try again.");
      }
    } finally {
      isConnecting.value = false;
    }
  }

  void onChangeSearch(String query) {
    searchQuery.value = query;
    if (productList.isNotEmpty) {
      final currentProdIndex = selectedProductIndex.value;
      if (currentProdIndex < productList.length) {
        loadProducts(categoryId: productList[currentProdIndex].id, index: currentProdIndex);
      }
    }
  }

  void onToggleInStock(bool value) {
    inStockOnly.value = value;
    if (productList.isNotEmpty) {
      final currentProdIndex = selectedProductIndex.value;
      if (currentProdIndex < productList.length) {
        loadProducts(categoryId: productList[currentProdIndex].id, index: currentProdIndex);
      }
    }
  }
}
