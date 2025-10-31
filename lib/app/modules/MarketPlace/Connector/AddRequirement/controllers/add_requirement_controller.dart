import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/services/AddRequirementService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/controllers/requirement_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:intl/intl.dart';

class AddRequirementController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final isLoading = false.obs;
  HomeController homeController = Get.find<HomeController>();

  // Form Controllers
  final quantityController = TextEditingController();
  final noteController = TextEditingController();

  // Filters
  RxList<FilterData> filters = <FilterData>[].obs;
  FilterData? uomFilter;
  RxList<String> uomOptions = <String>[].obs;
  Rxn<String> selectedUOM = Rxn<String>();

  // Category Hierarchy Data
  Rx<CategoryModel?> categoryHierarchy = Rx<CategoryModel?>(null);
  RxList<CategoryData> mainCategories = <CategoryData>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  RxList<ProductCategory> productCategories = <ProductCategory>[].obs;
  RxList<ProductSubCategory> subProductCategories = <ProductSubCategory>[].obs;

  // Reactive name lists for dropdowns
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productCategoryNames = <String>[].obs;
  RxList<String> subProductCategoryNames = <String>[].obs;

  // Category Selections
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProductCategory = Rxn<String>();
  Rxn<String> selectedSubProductCategory = Rxn<String>();
  Rxn<int> selectedMainCategoryId = Rxn<int>();
  Rxn<int> selectedSubCategoryId = Rxn<int>();
  Rxn<int> selectedProductCategoryId = Rxn<int>();
  Rxn<int> selectedSubProductCategoryId = Rxn<int>();

  // Site Address
  RxList<SiteLocation> siteLocations = <SiteLocation>[].obs;
  RxInt selectedSiteAddressId = 0.obs;
  RxString selectedSiteAddressName = ''.obs;
  Rxn<SiteLocation> selectedSiteAddress = Rxn<SiteLocation>();

  // Estimate Delivery Date
  Rxn<DateTime> estimateDeliveryDate = Rxn<DateTime>();
  final estimateDeliveryDateController = TextEditingController();

  final requirementService = AddRequirementService();
  final AddProductService filterService = AddProductService();

  int? requirementId; // For edit mode

  @override
  void onInit() {
    super.onInit();
    _initializeCategoryHierarchy();
    _fetchSiteAddresses().then((_) {
      _populateFromArguments(Get.arguments);
    });
  }

  void _initializeCategoryHierarchy() {
    final cachedHierarchy = myPref.getCategoryHierarchyModel();
    if (cachedHierarchy != null) {
      categoryHierarchy.value = cachedHierarchy;
      _populateCategoriesFromHierarchy(cachedHierarchy);
    }
  }

  void _populateCategoriesFromHierarchy(CategoryModel hierarchy) {
    mainCategories.value = hierarchy.data ?? [];
    mainCategoryNames.value = mainCategories
        .map((e) => e.name ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  // Main Category Selection
  void onMainCategorySelected(String? categoryName) {
    if (categoryName == null) {
      _clearSubCategories();
      return;
    }

    selectedMainCategory.value = categoryName;
    final selected = mainCategories.firstWhereOrNull(
      (c) => c.name == categoryName,
    );
    selectedMainCategoryId.value = selected?.id;

    if (selected != null && selected.subCategories != null) {
      subCategories.value = selected.subCategories!;
      subCategoryNames.value = subCategories
          .map((e) => e.name ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      _clearSubCategories();
    }
  }

  // Sub Category Selection
  void onSubCategorySelected(String? subCategoryName) {
    if (subCategoryName == null) {
      _clearProductCategories();
      return;
    }

    selectedSubCategory.value = subCategoryName;
    final selectedSub = subCategories.firstWhereOrNull(
      (s) => s.name == subCategoryName,
    );
    selectedSubCategoryId.value = selectedSub?.id;

    if (selectedSub != null && selectedSub.products != null) {
      productCategories.value = selectedSub.products!;
      productCategoryNames.value = productCategories
          .map((e) => e.name ?? '')
          .where((name) => name.isNotEmpty)
          .toList();

      // Sub-product categories are at SubCategory level
      if (selectedSub.productSubCategories != null &&
          selectedSub.productSubCategories!.isNotEmpty) {
        subProductCategories.value = selectedSub.productSubCategories!;
        subProductCategoryNames.value = subProductCategories
            .map((e) => e.name ?? '')
            .where((name) => name.isNotEmpty)
            .toList();
      } else {
        _clearSubProductCategories();
      }
    } else {
      _clearProductCategories();
    }
  }

  // Product Category Selection
  Future<void> onProductCategorySelected(String? productCategoryName) async {
    if (productCategoryName == null) {
      _clearSubProductCategories();
      _clearFilters();
      return;
    }

    selectedProductCategory.value = productCategoryName;
    final selectedProduct = productCategories.firstWhereOrNull(
      (p) => p.name == productCategoryName,
    );
    selectedProductCategoryId.value = selectedProduct?.id;

    // Fetch filters for the selected product category
    if (selectedProductCategoryId.value != null) {
      await fetchFilters(selectedProductCategoryId.value!);
    }

    // Sub-product categories are at SubCategory level
    if (selectedSubCategory.value != null && subCategories.isNotEmpty) {
      final subCat = subCategories.firstWhereOrNull(
        (s) => s.name == selectedSubCategory.value,
      );
      if (subCat?.productSubCategories != null &&
          subCat!.productSubCategories!.isNotEmpty) {
        subProductCategories.value = subCat.productSubCategories!;
        subProductCategoryNames.value = subProductCategories
            .map((e) => e.name ?? '')
            .where((name) => name.isNotEmpty)
            .toList();
      } else {
        _clearSubProductCategories();
      }
    } else {
      _clearSubProductCategories();
    }
  }

  // Fetch Filters
  Future<void> fetchFilters(
    int productCategoryId, {
    bool showLoader = true,
  }) async {
    try {
      if (showLoader) {
        isLoading.value = true;
      }
      final result = await filterService.getFilter(productCategoryId);

      if (result.success == true && result.data != null) {
        filters.value = result.data!;

        // Find UOM filter
        uomFilter = filters.firstWhereOrNull(
          (filter) =>
              filter.filterName?.toLowerCase() == 'uom' ||
              filter.filterName?.toLowerCase() == 'unit_of_measure' ||
              filter.filterLabel?.toLowerCase().contains('uom') == true ||
              filter.filterLabel?.toLowerCase().contains('unit') == true,
        );

        if (uomFilter != null && uomFilter!.dropdownList != null) {
          uomOptions.value = uomFilter!.dropdownList!;
        } else {
          uomOptions.clear();
          selectedUOM.value = null;
        }
      } else {
        filters.clear();
        uomFilter = null;
        uomOptions.clear();
        selectedUOM.value = null;
      }
    } catch (e) {
      Get.printError(info: 'Error fetching filters: $e');
      filters.clear();
      uomFilter = null;
      uomOptions.clear();
      selectedUOM.value = null;
    } finally {
      if (showLoader) {
        isLoading.value = false;
      }
    }
  }

  void _clearFilters() {
    filters.clear();
    uomFilter = null;
    uomOptions.clear();
    selectedUOM.value = null;
  }

  // Sub Product Category Selection
  void onSubProductCategorySelected(String? subProductCategoryName) {
    if (subProductCategoryName == null) {
      selectedSubProductCategory.value = null;
      selectedSubProductCategoryId.value = null;
      return;
    }

    selectedSubProductCategory.value = subProductCategoryName;
    final selected = subProductCategories.firstWhereOrNull(
      (s) => s.name == subProductCategoryName,
    );
    selectedSubProductCategoryId.value = selected?.id;
  }

  void _clearSubCategories() {
    subCategories.clear();
    subCategoryNames.clear();
    selectedSubCategory.value = null;
    selectedSubCategoryId.value = null;
    _clearProductCategories();
    _clearFilters();
  }

  void _clearProductCategories() {
    productCategories.clear();
    productCategoryNames.clear();
    selectedProductCategory.value = null;
    selectedProductCategoryId.value = null;
    _clearSubProductCategories();
    _clearFilters();
  }

  void _clearSubProductCategories() {
    subProductCategories.clear();
    subProductCategoryNames.clear();
    selectedSubProductCategory.value = null;
    selectedSubProductCategoryId.value = null;
  }

  // Site Address
  Future<void> _fetchSiteAddresses() async {
    siteLocations.value =
        homeController.profileData.value.data?.siteLocations ?? [];
    // Sync selected site address after loading
    _syncSelectedSiteAddress();
  }

  void selectSiteAddress(SiteLocation? site) {
    if (site != null) {
      selectedSiteAddress.value = site;
      selectedSiteAddressId.value = site.id ?? 0;
      selectedSiteAddressName.value = site.siteName ?? '';
    } else {
      selectedSiteAddress.value = null;
      selectedSiteAddressId.value = 0;
      selectedSiteAddressName.value = '';
    }
  }

  // Helper method to sync selectedSiteAddress with ID
  void _syncSelectedSiteAddress() {
    if (selectedSiteAddressId.value > 0) {
      final site = siteLocations.firstWhereOrNull(
        (s) => s.id == selectedSiteAddressId.value,
      );
      selectedSiteAddress.value = site;
      if (site != null) {
        selectedSiteAddressName.value = site.siteName ?? '';
      }
    } else {
      selectedSiteAddress.value = null;
      selectedSiteAddressName.value = '';
    }
  }

  // Date Selection
  Future<void> selectEstimateDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: estimateDeliveryDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      estimateDeliveryDate.value = picked;
      estimateDeliveryDateController.text = formattedEstimateDeliveryDate;
    }
  }

  String get formattedEstimateDeliveryDate {
    if (estimateDeliveryDate.value == null) return '';
    return DateFormat('yyyy-MM-dd').format(estimateDeliveryDate.value!);
  }

  Future<void> _populateFromArguments(dynamic args) async {
    if (args == null) return;

    if (args is Map) {
      requirementId = args['requirementId'];
      log('args: ${args.toString()}');
      // Populate quantity
      if (args['quantity'] != null) {
        quantityController.text = args['quantity'].toString();
      }

      // Populate UOM
      if (args['uom'] != null) {
        selectedUOM.value = args['uom'];
      }

      // Populate note
      if (args['note'] != null) {
        noteController.text = args['note'];
      }

      // Populate estimate delivery date
      if (args['estimate_delivery_date'] != null) {
        try {
          estimateDeliveryDate.value = DateTime.parse(
            args['estimate_delivery_date'],
          );
          estimateDeliveryDateController.text = formattedEstimateDeliveryDate;
        } catch (e) {
          Get.printError(info: 'Error parsing date: $e');
        }
      }

      // Populate site address
      if (args['site_address_id'] != null) {
        final siteId = args['site_address_id'] as int;
        selectedSiteAddressId.value = siteId;
        _syncSelectedSiteAddress();
      }

      // Populate categories from IDs
      if (args['main_category_id'] != null) {
        final mainCatId = args['main_category_id'] as int;
        final mainCat = mainCategories.firstWhereOrNull(
          (c) => c.id == mainCatId,
        );
        if (mainCat != null) {
          selectedMainCategoryId.value = mainCatId;
          selectedMainCategory.value = mainCat.name;

          // Populate sub categories
          if (mainCat.subCategories != null) {
            subCategories.value = mainCat.subCategories!;
            subCategoryNames.value = subCategories
                .map((e) => e.name ?? '')
                .where((name) => name.isNotEmpty)
                .toList();

            // Set sub category if ID provided
            if (args['sub_category_id'] != null) {
              final subCatId = args['sub_category_id'] as int;
              final subCat = subCategories.firstWhereOrNull(
                (s) => s.id == subCatId,
              );
              if (subCat != null) {
                selectedSubCategoryId.value = subCatId;
                selectedSubCategory.value = subCat.name;

                // Populate product categories
                if (subCat.products != null) {
                  productCategories.value = subCat.products!;
                  productCategoryNames.value = productCategories
                      .map((e) => e.name ?? '')
                      .where((name) => name.isNotEmpty)
                      .toList();

                  // Set product category if ID provided
                  if (args['category_product_id'] != null) {
                    final productCatId = args['category_product_id'] as int;
                    final productCat = productCategories.firstWhereOrNull(
                      (p) => p.id == productCatId,
                    );
                    if (productCat != null) {
                      selectedProductCategoryId.value = productCatId;
                      selectedProductCategory.value = productCat.name;

                      // Fetch filters for UOM
                      await fetchFilters(productCatId, showLoader: false);

                      // Populate sub product categories
                      if (subCat.productSubCategories != null &&
                          subCat.productSubCategories!.isNotEmpty) {
                        subProductCategories.value =
                            subCat.productSubCategories!;
                        subProductCategoryNames.value = subProductCategories
                            .map((e) => e.name ?? '')
                            .where((name) => name.isNotEmpty)
                            .toList();

                        // Set sub product category if ID provided
                        if (args['product_sub_category_id'] != null) {
                          final subProductCatId =
                              args['product_sub_category_id'] as int;
                          final subProductCat = subProductCategories
                              .firstWhereOrNull((s) => s.id == subProductCatId);
                          if (subProductCat != null) {
                            selectedSubProductCategoryId.value =
                                subProductCatId;
                            selectedSubProductCategory.value =
                                subProductCat.name;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  bool _validateForm() {
    if (selectedMainCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select main category");
      return false;
    }

    if (selectedSubCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select sub category");
      return false;
    }

    if (selectedProductCategory.value == null) {
      SnackBars.errorSnackBar(content: "Please select product category");
      return false;
    }

    if (quantityController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: "Please enter quantity");
      return false;
    }

    if (selectedSiteAddressName.value.isEmpty) {
      SnackBars.errorSnackBar(content: "Please select site address");
      return false;
    }

    return true;
  }

  Map<String, dynamic> _buildFormData() {
    return {
      "main_category_id": selectedMainCategoryId.value,
      "sub_category_id": selectedSubCategoryId.value,
      "category_product_id": selectedProductCategoryId.value,
      "product_sub_category_id": selectedSubProductCategoryId.value,
      "quantity": int.tryParse(quantityController.text.trim()) ?? 0,
      "uom": selectedUOM.value ?? "",
      "site_address_id": selectedSiteAddressId.value,
      "estimate_delivery_date": formattedEstimateDeliveryDate.isNotEmpty
          ? formattedEstimateDeliveryDate
          : null,
      "note": noteController.text.trim(),
    };
  }

  Future<void> submitRequirement() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    try {
      final data = _buildFormData();

      if (requirementId != null) {
        await requirementService.updateRequirement(
          requirementId: requirementId!,
          data: data,
        );
        final RequirementController requirementController =
            Get.find<RequirementController>();
        await requirementController.fetchRequirementsList();
        Get.back();
      } else {
        await requirementService.createRequirement(data: data);
        Get.back();
      }
    } catch (e) {
      // ignore: avoid_print
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    quantityController.dispose();
    noteController.dispose();
    estimateDeliveryDateController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
