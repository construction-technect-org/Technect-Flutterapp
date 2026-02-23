import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/marketplace_category_models.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/services/InventoryService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/services/marketplace_category_service.dart';
import 'package:image_picker/image_picker.dart';

class AddInventoryController extends GetxController {
  final InventoryService _inventoryService = InventoryService();
  final MarketplaceCategoryService _categoryService = MarketplaceCategoryService();

  final isLoading = false.obs;

  // ─────────────────────────────────────────────────────
  // 5-Tier Category Hierarchy
  // ─────────────────────────────────────────────────────
  final modules = <MarketplaceModule>[].obs;
  final mainCategories = <MarketplaceMainCategory>[].obs;
  final categories = <MarketplaceCategory>[].obs;
  final subCategories = <MarketplaceSubCategory>[].obs;
  final categoryProducts = <MarketplaceCategoryProduct>[].obs;

  final selectedModuleId = Rxn<String>();
  final selectedModuleName = Rxn<String>();
  final selectedMainCategoryId = Rxn<String>();
  final selectedCategoryId = Rxn<String>();
  final selectedSubCategoryId = Rxn<String>();
  final selectedCategoryProductId = Rxn<String>();

  // Valid inventoryType values accepted by the API
  static const List<String> inventoryTypeOptions = [
    'product',
    'service',
    'design',
    'fleet',
    'tools',
    'equipment',
    'ppe',
    'other',
  ];
  final selectedInventoryType = 'product'.obs;

  // ─────────────────────────────────────────────────────
  // Common Fields
  // ─────────────────────────────────────────────────────
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final gstPercentageController = TextEditingController();
  final gstAmountController = TextEditingController();
  final finalPriceController = TextEditingController();
  final noteController = TextEditingController();
  final descriptionController = TextEditingController();
  final termsController = TextEditingController();

  // Product Specific Fields
  final brandController = TextEditingController();
  final stockController = TextEditingController();
  final uomController = TextEditingController(); // Unit of Measurement
  final uocController = TextEditingController(); // Unit of Count
  final packageTypeController = TextEditingController();
  final shapeController = TextEditingController();
  final textureController = TextEditingController();
  final colourController = TextEditingController();
  final sizeController = TextEditingController();
  final warehouseDetailsController = TextEditingController();

  // Optional physical properties
  final finenessModulesController = TextEditingController();
  final specificGravityController = TextEditingController();
  final bulkDensityController = TextEditingController();
  final waterAbsorptionController = TextEditingController();
  final moistureContentController = TextEditingController();
  final machineTypeController = TextEditingController();

  // Generic Service Fields
  final unitController = TextEditingController();
  final referenceUrlController = TextEditingController();
  final featuresController = TextEditingController(); // JSON string e.g. [{"key":"val"}]
  final referenceFilesController = TextEditingController();

  // Observables
  final isAvailable = true.obs;

  // ─────────────────────────────────────────────────────
  // Media
  // ─────────────────────────────────────────────────────
  final RxList<String> pickedFilePathList = <String>[].obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchModules();
    // Auto-calculate finalPrice when price or gstAmount changes
    priceController.addListener(_recalcFinalPrice);
    gstPercentageController.addListener(_recalcGstAndFinalPrice);
  }

  void _recalcGstAndFinalPrice() {
    final price = double.tryParse(priceController.text) ?? 0;
    final gstPct = double.tryParse(gstPercentageController.text) ?? 0;
    final gstAmt = (price * gstPct) / 100;
    gstAmountController.text = gstAmt == 0 ? '' : gstAmt.toStringAsFixed(2);
    _recalcFinalPrice();
  }

  void _recalcFinalPrice() {
    final price = double.tryParse(priceController.text) ?? 0;
    final gstAmt = double.tryParse(gstAmountController.text) ?? 0;
    final final_ = price + gstAmt;
    finalPriceController.text = final_ == 0 ? '' : final_.toStringAsFixed(2);
  }

  // ─────────────────────────────────────────────────────
  // Category Fetching Methods
  // ─────────────────────────────────────────────────────

  Future<void> fetchModules() async {
    try {
      isLoading.value = true;
      final response = await _categoryService.getModules();
      if (response.success && response.data.isNotEmpty) {
        modules.assignAll(response.data);
        // Auto-select the first module and load its main categories
        await onModuleSelected(response.data.first.id, response.data.first.name);
      }
    } catch (e) {
      log("Error fetching modules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onModuleSelected(String? moduleId, [String? moduleName]) async {
    selectedModuleId.value = moduleId;
    selectedModuleName.value = moduleName;
    selectedMainCategoryId.value = null;
    selectedCategoryId.value = null;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    mainCategories.clear();
    categories.clear();
    subCategories.clear();
    categoryProducts.clear();

    if (moduleId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getMainCategories(moduleId);
      if (response.success) {
        mainCategories.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching main categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onMainCategorySelected(String? mainCategoryId) async {
    selectedMainCategoryId.value = mainCategoryId;
    selectedCategoryId.value = null;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    categories.clear();
    subCategories.clear();
    categoryProducts.clear();

    if (mainCategoryId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getCategories(mainCategoryId);
      if (response.success) {
        categories.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onCategorySelected(String? categoryId) async {
    selectedCategoryId.value = categoryId;
    selectedSubCategoryId.value = null;
    selectedCategoryProductId.value = null;
    subCategories.clear();
    categoryProducts.clear();

    if (categoryId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getSubCategories(categoryId);
      if (response.success) {
        subCategories.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching sub-categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubCategorySelected(String? subCategoryId) async {
    selectedSubCategoryId.value = subCategoryId;
    selectedCategoryProductId.value = null;
    categoryProducts.clear();

    if (subCategoryId == null) return;
    try {
      isLoading.value = true;
      final response = await _categoryService.getCategoryProducts(subCategoryId);
      if (response.success) {
        categoryProducts.assignAll(response.data);
      }
    } catch (e) {
      log("Error fetching category products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────
  // Media Logic
  // ─────────────────────────────────────────────────────

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      pickedFilePathList.addAll(images.map((e) => e.path));
    }
  }

  void removeImage(int index) {
    pickedFilePathList.removeAt(index);
  }

  // ─────────────────────────────────────────────────────
  // Create Product (Material)
  // API: POST /v1/api/marketplace/inventory/products
  // Files: sent as repeated "files" key (not image_1, image_2)
  // ─────────────────────────────────────────────────────

  Future<void> createProduct() async {
    if (selectedCategoryProductId.value == null ||
        nameController.text.isEmpty ||
        priceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please fill all required fields");
      return;
    }

    isLoading.value = true;
    final type = selectedInventoryType.value;

    // Route non-product types to the generic API
    if (type != 'product') {
      final Map<String, dynamic> genericFields = {
        "inventoryType": type,
        "categoryProductId": selectedCategoryProductId.value,
        "name": nameController.text,
        if (brandController.text.isNotEmpty) "brand": brandController.text,
        if (descriptionController.text.isNotEmpty) "description": descriptionController.text,
        "price": priceController.text,
        "gstPercentage": gstPercentageController.text,
        "gstAmount": gstAmountController.text,
        "finalPrice": finalPriceController.text,
        "stock": stockController.text,
        "isAvailable": isAvailable.value ? "true" : "false",
        // Map the product form's UOM to generic 'unit' (it is required by backend)
        "unit": uomController.text.isNotEmpty ? uomController.text : "item",
        if (noteController.text.isNotEmpty) "note": noteController.text,
      };

      try {
        final response = await _inventoryService.createInventoryGeneric(
          fields: genericFields,
          filePaths: pickedFilePathList,
        );
        if (response['success'] == true) {
          Get.back();
          SnackBars.successSnackBar(content: "Inventory item added");
        } else {
          SnackBars.errorSnackBar(content: response['message'] ?? "Failed to add item");
        }
      } catch (e) {
        SnackBars.errorSnackBar(content: "Error: $e");
      } finally {
        isLoading.value = false;
      }
      return;
    }

    // Otherwise, continue with the product API payload
    // All field names are camelCase to match the API spec
    final Map<String, dynamic> fields = {
      "inventoryType": selectedInventoryType.value,
      "categoryProductId": selectedCategoryProductId.value,
      "name": nameController.text,
      "brand": brandController.text,
      "description": descriptionController.text,
      "price": priceController.text,
      "gstPercentage": gstPercentageController.text,
      "gstAmount": gstAmountController.text,
      "finalPrice": finalPriceController.text,
      "stock": stockController.text,
      "isAvailable": isAvailable.value ? "true" : "false",
      "warehouseDetails": warehouseDetailsController.text,
      "note": noteController.text,
      "termsAndConditions": termsController.text,
      "uom": uomController.text,
      "uoc": uocController.text,
      "packageType": packageTypeController.text,
      "shape": shapeController.text,
      "texture": textureController.text,
      "colour": colourController.text,
      "size": sizeController.text,
      if (finenessModulesController.text.isNotEmpty)
        "finenessModules": finenessModulesController.text,
      if (specificGravityController.text.isNotEmpty)
        "specificGravity": specificGravityController.text,
      if (bulkDensityController.text.isNotEmpty) "bulkDensity": bulkDensityController.text,
      if (waterAbsorptionController.text.isNotEmpty)
        "waterAbsorption": waterAbsorptionController.text,
      if (moistureContentController.text.isNotEmpty)
        "moistureContent": moistureContentController.text,
      if (machineTypeController.text.isNotEmpty) "machineType": machineTypeController.text,
    };

    // Files must all use the SAME key "files" (API expects an array)
    final Map<String, String> files = {};
    for (int i = 0; i < pickedFilePathList.length; i++) {
      files["files"] = pickedFilePathList[i]; // only sends last - see below
    }

    // For multiple files with the same key, we use a list approach
    // The ApiManager's postMultipart must support repeated keys.
    // We pass them indexed but with the field named "files[]" or "files"
    // depending on the server. Current best approach: pass all as "files".
    final Map<String, String> filesMap = {};
    for (int i = 0; i < pickedFilePathList.length; i++) {
      filesMap["files"] = pickedFilePathList[i];
    }

    try {
      final response = await _inventoryService.createInventoryProduct(
        fields: fields,
        files: filesMap,
        filePaths: pickedFilePathList,
      );
      if (response['success'] == true) {
        Get.back();
        SnackBars.successSnackBar(content: "Product added to inventory");
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? "Failed to add product");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────
  // Create Service (Generic)
  // ─────────────────────────────────────────────────────

  Future<void> createService() async {
    if (selectedCategoryProductId.value == null ||
        nameController.text.isEmpty ||
        priceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please fill all required fields");
      return;
    }

    isLoading.value = true;
    final Map<String, dynamic> fields = {
      "inventoryType": selectedInventoryType.value,
      "categoryProductId": selectedCategoryProductId.value,
      "name": nameController.text,
      if (brandController.text.isNotEmpty) "brand": brandController.text,
      if (descriptionController.text.isNotEmpty) "description": descriptionController.text,
      "price": priceController.text,
      "gstPercentage": gstPercentageController.text,
      "gstAmount": gstAmountController.text,
      "finalPrice": finalPriceController.text,
      "stock": stockController.text,
      "isAvailable": isAvailable.value ? "true" : "false",
      "unit": unitController.text,
      "uom": unitController.text,
      if (noteController.text.isNotEmpty) "note": noteController.text,
      if (referenceUrlController.text.isNotEmpty) "referenceUrl": referenceUrlController.text,
      if (featuresController.text.isNotEmpty) "features": featuresController.text,
    };

    try {
      final response = await _inventoryService.createInventoryGeneric(
        fields: fields,
        filePaths: pickedFilePathList,
      );
      if (response['success'] == true) {
        Get.back();
        SnackBars.successSnackBar(content: "Service added to inventory");
      } else {
        SnackBars.errorSnackBar(content: response['message'] ?? "Failed to add service");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────
  // Dispose
  // ─────────────────────────────────────────────────────

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    gstPercentageController.dispose();
    gstAmountController.dispose();
    finalPriceController.dispose();
    noteController.dispose();
    descriptionController.dispose();
    termsController.dispose();
    brandController.dispose();
    stockController.dispose();
    uomController.dispose();
    uocController.dispose();
    packageTypeController.dispose();
    shapeController.dispose();
    textureController.dispose();
    colourController.dispose();
    sizeController.dispose();
    warehouseDetailsController.dispose();
    finenessModulesController.dispose();
    specificGravityController.dispose();
    bulkDensityController.dispose();
    waterAbsorptionController.dispose();
    moistureContentController.dispose();
    machineTypeController.dispose();
    unitController.dispose();
    referenceUrlController.dispose();
    featuresController.dispose();
    referenceFilesController.dispose();
    super.onClose();
  }
}
