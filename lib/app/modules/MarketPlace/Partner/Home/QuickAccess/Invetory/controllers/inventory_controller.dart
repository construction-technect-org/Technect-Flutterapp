import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/inventory_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/marketplace_category_models.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/services/InventoryService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/services/marketplace_category_service.dart';

class InventoryController extends GetxController {
  final InventoryService _inventoryService = InventoryService();
  final MarketplaceCategoryService _categoryService = MarketplaceCategoryService();

  RxBool isLoading = false.obs;

  // New Unified Inventory List State
  Rx<InventoryListResponse> inventoryList = InventoryListResponse().obs;
  RxList<InventoryItem> filteredItems = <InventoryItem>[].obs;

  RxString searchQuery = ''.obs;

  // inventoryType currently selected (matches API enum: product, service, design, etc.)
  RxString selectedStatus = "product".obs;

  TextEditingController searchController = TextEditingController();

  // ─────────────────────────────────────────────────────
  // 5-Tier Category Hierarchy for Filtering
  // ─────────────────────────────────────────────────────
  final modules = <MarketplaceModule>[].obs;
  final mainCategories = <MarketplaceMainCategory>[].obs;
  final categories = <MarketplaceCategory>[].obs;
  final subCategories = <MarketplaceSubCategory>[].obs;
  final categoryProducts = <MarketplaceCategoryProduct>[].obs;

  final selectedModuleId = Rxn<String>();
  final selectedMainCategoryId = Rxn<String>();
  final selectedCategoryId = Rxn<String>();
  final selectedSubCategoryId = Rxn<String>();
  final selectedCategoryProductId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    // Fetch initial filter data and list
    fetchModules();
    fetchInventoryList();
  }

  // ─────────────────────────────────────────────────────
  // Inventory List Fetching
  // ─────────────────────────────────────────────────────

  Future<void> fetchInventoryList() async {
    try {
      isLoading.value = true;
      final result = await _inventoryService.fetchInventoryItems(
        inventoryType: selectedStatus.value,
        categoryProductId: selectedCategoryProductId.value,
      );

      if (result.success == true) {
        inventoryList.value = result;
        filteredItems.assignAll(result.data ?? []);
        // Re-apply any active search
        searchProducts(searchQuery.value);
      }
    } catch (e) {
      log('Error fetching unified inventory', error: e);
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String? value) {
    searchQuery.value = value ?? '';
    final allItems = inventoryList.value.data ?? [];

    if (value == null || value.isEmpty) {
      filteredItems.assignAll(allItems);
    } else {
      final q = value.toLowerCase();
      filteredItems.assignAll(
        allItems.where((item) {
          return (item.name?.toLowerCase().contains(q) ?? false) ||
              (item.brand?.toLowerCase().contains(q) ?? false) ||
              (item.categoryProductName.toLowerCase().contains(q));
        }).toList(),
      );
    }
  }

  Future<void> setInventoryType(String type) async {
    if (selectedStatus.value != type) {
      selectedStatus.value = type;
      searchController.clear();
      searchQuery.value = "";
      await fetchInventoryList();
    }
  }

  // ─────────────────────────────────────────────────────
  // Category Fetching Methods (Filters)
  // ─────────────────────────────────────────────────────

  Future<void> fetchModules() async {
    try {
      final response = await _categoryService.getModules();
      if (response.success && response.data.isNotEmpty) {
        modules.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching modules filter: $e");
    }
  }

  Future<void> onModuleSelected(String? moduleId) async {
    selectedModuleId.value = moduleId;
    selectedMainCategoryId.value = null;
    selectedCategoryId.value = null;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    mainCategories.clear();
    categories.clear();
    subCategories.clear();
    categoryProducts.clear();

    // Trigger list fetch
    fetchInventoryList();

    if (moduleId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getMainCategories(moduleId);
      if (response.success) {
        mainCategories.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching main categories filter: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onMainCategorySelected(String? mainCatId) async {
    selectedMainCategoryId.value = mainCatId;
    selectedCategoryId.value = null;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    categories.clear();
    subCategories.clear();
    categoryProducts.clear();

    fetchInventoryList();

    if (mainCatId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getCategories(mainCatId);
      if (response.success) {
        categories.assignAll(response.data);
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onCategorySelected(String? catId) async {
    selectedCategoryId.value = catId;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    subCategories.clear();
    categoryProducts.clear();

    fetchInventoryList();

    if (catId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getSubCategories(catId);
      if (response.success) {
        subCategories.assignAll(response.data);
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubCategorySelected(String? subCatId) async {
    selectedSubCategoryId.value = subCatId;
    selectedCategoryProductId.value = null;
    categoryProducts.clear();

    fetchInventoryList();

    if (subCatId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getCategoryProducts(subCatId);
      if (response.success) {
        categoryProducts.assignAll(response.data);
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onCategoryProductSelected(String? prodId) {
    selectedCategoryProductId.value = prodId;
    fetchInventoryList();
  }
}
