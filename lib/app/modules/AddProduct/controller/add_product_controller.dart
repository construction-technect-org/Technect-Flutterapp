import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart'; // your CommonDropdown
import 'package:construction_technect/app/modules/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/modules/ProductManagement/controllers/product_management_controller.dart';
import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddProductController extends GetxController {
  final pageController = PageController();
  Product product = Product();
  ProductManagementController controller = Get.find();

  // ---------------- Form Controllers ----------------

  RxBool isOutStock = false.obs;
  final productCodeController = TextEditingController();
  final noteStockController = TextEditingController();
  final noteController = TextEditingController();
  final uocController = TextEditingController();
  final amountController = TextEditingController();

  final productNameController = TextEditingController();
  final stockController = TextEditingController();
  final uomController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();
  final packageSizeController = TextEditingController();
  final brandNameController = TextEditingController();
  final weightController = TextEditingController();
  final shapeController = TextEditingController();
  final textureController = TextEditingController();
  final sizeController = TextEditingController();
  final colorController = TextEditingController();
  final packageTypeController = TextEditingController();

  // ---------------- DropDown Data ----------------
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  RxList<CategoryProduct> productsList = <CategoryProduct>[].obs;
  RxList<FilterData> filters = <FilterData>[].obs;

  // Reactive name lists for dropdowns
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;

  RxList<String> uomList = <String>["Kg", "Tones"].obs;
  RxList<String> gstList = <String>["5%", "12%", "18%", "28%"].obs;

  // ---------------- Selections ----------------
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedMainCategoryId = Rxn<String>();
  Rxn<String> selectedSubCategoryId = Rxn<String>();
  Rxn<String> selectedProductId = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();
  Rxn<String> selectedGST = Rxn<String>();

  // ---------------- State ----------------
  RxBool showExtraFields = false.obs;
  RxString pickedFileName = "".obs;
  RxString pickedFilePath = "".obs;
  RxBool isEnabled = true.obs;
  RxBool isLoading = false.obs;

  final AddProductService _service = AddProductService();
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      isEdit = args['isEdit'] ?? false;
      product = args['product'] ?? Product();
      if (isEdit) {
        _initializeEditMode();
      }
    }
    initCalled();
  }

  Future<void> initCalled() async {
    await fetchMainCategories();
    if (isEdit && product.subCategoryId != null) {
      await fetchSubCategories(product.mainCategoryId ?? 0);
      await fetchProducts(product.subCategoryId ?? 0);
      await getFilter(product.subCategoryId ?? 0);
      _initializeEditMode();
    }
  }

  void _initializeEditMode() {
    productNameController.text = product.productName ?? '';
    productCodeController.text = product.productCode ?? '';
    uocController.text = product.uoc.toString();
    amountController.text = product.totalAmount ?? '';
    noteController.text = product.productNote ?? '';
    noteStockController.text = product.outOfStockNote ?? '';
    sizeController.text = product.grainSize ?? '';
    isOutStock.value = !(product.outOfStock ?? false);
    stockController.text = product.stockQuantity?.toString() ?? '';
    priceController.text = product.price ?? '';
    if ((product.gstPercentage ?? "").isNotEmpty) {
      selectedGST.value = "${product.gstPercentage?.split(".").first}%";
      print(selectedGST.value);
    }
    gstPriceController.text = product.gstAmount ?? '';
    termsController.text = product.termsAndConditions ?? '';
    packageSizeController.text = product.packageSize ?? '';
    brandNameController.text = product.brand ?? '';
    weightController.text = product.weight ?? '';
    shapeController.text = product.shape ?? '';
    textureController.text = product.texture ?? '';
    sizeController.text = product.size ?? '';
    colorController.text = product.colour ?? '';
    packageTypeController.text = product.packageType ?? '';

    selectedUom.value = product.uom ?? '';
    isEnabled.value = product.isActive ?? true;

    selectedMainCategory.value = product.mainCategoryName ?? '';
    selectedSubCategory.value = product.subCategoryName ?? '';
    selectedProduct.value = product.categoryProductName ?? '';

    selectedMainCategoryId.value = (product.mainCategoryId ?? 0).toString();
    selectedSubCategoryId.value = (product.subCategoryId ?? 0).toString();
    selectedProductId.value = (product.categoryProductId ?? 0).toString();

    // Set existing product image for display
    if (product.productImage != null && product.productImage!.isNotEmpty) {
      pickedFilePath.value = "${APIConstants.bucketUrl}${product.productImage!}";
      pickedFileName.value = "Current product image";
    }

    // Store filter values for later use after filters are loaded
    _storedFilterValues = product.filterValues;
  }

  String? _storedFilterValues;

  @override
  void onClose() {
    productNameController.dispose();
    priceController.dispose();
    gstController.dispose();
    gstPriceController.dispose();
    termsController.dispose();
    super.onClose();
  }

  // ---------------- Main Category ----------------
  void onMainCategorySelected(String? categoryName) {
    if (categoryName == null) {
      subCategories.clear();
      subCategoryNames.clear();
      selectedSubCategory.value = null;
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
      selectedMainCategory.value = null;
      return;
    }

    selectedMainCategory.value = categoryName;

    final selected = mainCategories.firstWhereOrNull((c) => c.name == categoryName);
    selectedMainCategoryId.value = '${selected?.id ?? 0}';
    if (selected != null) {
      fetchSubCategories(selected.id ?? 0);
    }
  }

  // ---------------- SubCategory ----------------
  Future<void> onSubCategorySelected(String? subCategoryName) async {
    if (subCategoryName == null) {
      selectedSubCategory.value = null;
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
      subCategoryNames.clear();
      return;
    }

    selectedSubCategory.value = subCategoryName;

    final selectedSub = subCategories.firstWhereOrNull((s) => s.name == subCategoryName);
    selectedSubCategoryId.value = '${selectedSub?.id ?? 0}';

    if (selectedSub != null) {
      await fetchProducts(selectedSub.id ?? 0);
      await getFilter(selectedSub.id ?? 0);
    }
  }

  // ---------------- Products ----------------
  Future<void> fetchProducts(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await _service.productsBySubCategory(subCategoryId);

      if ((result.success) == true) {
        productsList.value = result.data ?? [];
        productNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
        selectedProduct.value = null;
      } else {
        productsList.clear();
        productNames.clear();
        selectedProduct.value = null;
      }
    } catch (e) {
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } finally {
      isLoading(false);
    }
  }

  Map<String, TextEditingController> dynamicControllers = {};

  Future<void> getFilter(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await _service.getFilter(subCategoryId);

      if (result.success == true) {
        filters.value = (result.data as List<FilterData>).map((e) => e).toList();
        for (final FilterData filter in filters) {
          dynamicControllers[filter.filterName ?? ''] = TextEditingController();
        }

        if (isEdit && _storedFilterValues != null && _storedFilterValues!.isNotEmpty) {
          _populateFilterControllers();
        }
      } else {
        filters.clear();
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      filters.clear();
    } finally {
      isLoading(false);
    }
  }

  void _populateFilterControllers() {
    if (_storedFilterValues == null || _storedFilterValues!.isEmpty) return;

    try {
      final Map<String, dynamic> filterValues = jsonDecode(_storedFilterValues!);

      // Populate each dynamic controller with its corresponding value
      filterValues.forEach((key, value) {
        if (dynamicControllers.containsKey(key)) {
          dynamicControllers[key]!.text = value.toString();
        }
      });
    } catch (e) {
      log('Error parsing stored filter values: $e');
    }
  }

  void onProductSelected(String? productName) {
    selectedProduct.value = productName;
    final selectedSub = productsList.firstWhereOrNull((s) => s.name == productName);
    selectedProductId.value = '${selectedSub?.id ?? 0}';
  }

  // ---------------- API Calls ----------------
  Future<void> fetchMainCategories() async {
    try {
      isLoading(true);
      final result = await _service.mainCategory();
      if ((result.success) == true) {
        mainCategories.value = result.data ?? [];
        mainCategoryNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
      } else {
        mainCategories.clear();
        mainCategoryNames.clear();
      }
    } catch (e) {
      mainCategories.clear();
      mainCategoryNames.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubCategories(int mainCategoryId) async {
    try {
      isLoading(true);
      final result = await _service.subCategory(mainCategoryId);
      if ((result.success) == true) {
        subCategories.value = result.data ?? [];
        subCategoryNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
      } else {
        subCategories.clear();
        subCategoryNames.clear();
      }

      selectedSubCategory.value = null;
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } catch (e) {
      subCategories.clear();
      subCategoryNames.clear();
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } finally {
      isLoading(false);
    }
  }

  void submitProduct() {
    showExtraFields.value = true;
    createProductValidation();
  }

  void gstCalculate() {
    final double amount =
        double.parse(priceController.text.isEmpty ? '0.0' : priceController.text) *
        double.parse(
          selectedGST.value.toString().replaceAll("%", "").isEmpty
              ? '0.0'
              : (selectedGST.value.toString().replaceAll("%", "")),
        ) /
        100;
    gstPriceController.text = amount.toStringAsFixed(2);
    amountController.text = (amount + double.parse(priceController.text)).toStringAsFixed(
      2,
    );
  }

  Future<void> pickImage() async {
    try {
      final XFile? result = await CommonConstant().pickImageFromGallery();

      if (result != null && result.path.isNotEmpty) {
        final XFile file = result;
        pickedFileName.value = file.name;
        pickedFilePath.value = file.path;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick file: $e', time: 3);
    }
  }

  Future<bool> firstPartValidation() async {
    bool isRequired = false;
    if (pickedFilePath.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Product image is required');
      isRequired = false;
    } else if (productNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Product name is required');
      isRequired = false;
    }
    // else if (productCodeController.text.isEmpty) {
    //   SnackBars.errorSnackBar(content: 'Product code is required');
    //   isRequired = false;
    // }
    else if (selectedMainCategoryId.value == null) {
      SnackBars.errorSnackBar(content: 'Main category is required');
      isRequired = false;
    } else if (selectedSubCategoryId.value == null) {
      SnackBars.errorSnackBar(content: 'Sub category is required');
      isRequired = false;
    } else if (productNames.isNotEmpty && selectedProductId.value == null) {
      SnackBars.errorSnackBar(content: 'Product is required');
      isRequired = false;
    }
    else if ( isOutStock.value==true && stockController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Stock Quantity is required');
      isRequired = false;
    }
    else if ( isOutStock.value==true && int.parse(stockController.text)==0) {
      SnackBars.errorSnackBar(content: 'Stock Quantity can not be zero');
      isRequired = false;
    }
    else if (selectedUom.value == null) {
      SnackBars.errorSnackBar(content: 'UOM is required');
      isRequired = false;
    } else if (uocController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'UOC is required');
      isRequired = false;
    } else if (priceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Rate is required');
      isRequired = false;
    } else if (selectedGST.value == null) {
      SnackBars.errorSnackBar(content: 'GST percentage is required');
      isRequired = false;
    } else if (noteController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Note is required');
      isRequired = false;
    } else if (termsController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Terms is required');
      isRequired = false;
    } else {
      isRequired = true;
    }
    return isRequired;
  }

  void createProductValidation() {
    if (brandNameController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Brand name is required');
    } else if (packageTypeController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Package type is required');
    } else if (packageSizeController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Package size is required');
    } else if (shapeController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Shape is required');
    } else if (textureController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Texture is required');
    } else if (colorController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Color is required');
    } else if (sizeController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Grain Size is required');
    } else {
      if (isEdit) {
        updateProduct();
      } else {
        navigate();
      }
    }
  }

  void navigate() {
    hideKeyboard();
    final Map<String, String> payload = {};
    dynamicControllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        payload[key] = controller.text;
      }
    });
    final Product p = Product(
      // categoryProductName: selectedSubCategory.value,
      productImage: pickedFilePath.value,
      gstAmount: gstPriceController.text,
      mainCategoryName: selectedMainCategory.value,
      subCategoryName: selectedSubCategory.value,
      productName: productNameController.text,
      shape: shapeController.text,
      brand: brandNameController.text,
      mainCategoryId: int.parse(selectedMainCategoryId.value ?? "0"),
      subCategoryId: int.parse(selectedSubCategoryId.value ?? "0"),
      categoryProductId: int.parse(selectedProductId.value ?? "0"),
      price: priceController.text,
      productCode: productCodeController.text,
      totalAmount: amountController.text,
      grainSize: sizeController.text,
      size: packageSizeController.text,
      productNote: noteController.text,
      gstPercentage: (selectedGST.value ?? "").replaceAll("%", ""),
      termsAndConditions: termsController.text,
      outOfStock: false,
      stockQuantity: int.parse(stockController.text),
      uom: selectedUom.value,
      uoc: uocController.text,
      packageType: packageTypeController.text,
      packageSize: packageSizeController.text,
      texture: textureController.text,
      colour: colorController.text,
      isActive: isEnabled.value,
      isFeatured: false,
      sortOrder: 1,
      filterValues: json.encode(payload),
    );
    Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {"product": p, "isFromAdd": true});
  }

  Future<void> createProduct() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    final Map<String, String> selectedFiles = {"product_image": pickedFilePath.value};

    final Map<String, String> payload = {};
    dynamicControllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        payload[key] = controller.text;
      }
    });
    fields = {
      "product_name": productNameController.text,
      "main_category_id": selectedMainCategoryId.value,
      "sub_category_id": selectedSubCategoryId.value,
    };

    if (productNames.isNotEmpty && selectedProductId.value != null) {
      fields["category_product_id"] = selectedProductId.value;
    }

    fields.addAll({
      "price": priceController.text,
      "total_amount": amountController.text,
      "grain_size": sizeController.text,
      "product_note": noteController.text,
      "gst_percentage": (selectedGST.value ?? "").replaceAll("%", ""),
      "terms_and_conditions": termsController.text,
      "stock_qty": isOutStock.value == true ? int.parse(stockController.text) : 0,
      "outofstock": !isOutStock.value,
      "brand": brandNameController.text,
      "uom": selectedUom.value,
      "uoc": uocController.text,
      "package_type": packageTypeController.text,
      "package_size": packageSizeController.text,
      "shape": shapeController.text,
      "texture": textureController.text,
      "colour": colorController.text,
      "size": packageSizeController.text,
      // "weight": "0",
      "is_active": isEnabled.value,
      "is_featured": false,
      "sort_order": "1",
      "filter_values": json.encode(payload),
    });
    log('fields $fields');
    try {
      final addTeamResponse = await _service.createProduct(
        fields: fields,
        files: selectedFiles,
      );

      if (addTeamResponse.success == true) {
        await controller.fetchProducts();
        isLoading.value = false;
        Get.back();
        Get.back();
        Get.back();
      } else {
        isLoading.value = false;
        SnackBars.errorSnackBar(
          content: addTeamResponse.message ?? 'Something went wrong!!',
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  /// Update existing product
  Future<void> updateProduct() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};

    final Map<String, String> selectedFiles = {};
    final String existingImageUrl =
        "${APIConstants.bucketUrl}${product.productImage ?? ''}";

    if (pickedFilePath.value.isNotEmpty &&
        pickedFilePath.value != existingImageUrl &&
        !pickedFilePath.value.contains('http')) {
      selectedFiles["product_image"] = pickedFilePath.value;
    }

    final Map<String, String> payload = {};
    dynamicControllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        payload[key] = controller.text;
      }
    });

    fields = {
      "product_name": productNameController.text,
      "price": priceController.text,
      "gst_percentage": (selectedGST.value ?? "").replaceAll("%", ""),
      "terms_and_conditions": termsController.text,
      "stock_qty": isOutStock.value ? stockController.text : "0",
      "brand": brandNameController.text,
      "uom": selectedUom.value,
      "package_type": packageTypeController.text,
      "package_size": packageSizeController.text,
      "shape": shapeController.text,
      "texture": textureController.text,
      "colour": colorController.text,
      "size": sizeController.text,
      "weight": weightController.text,
      "is_active": isEnabled.value.toString(),
      "is_featured": "false",
      "sort_order": "1",
      "low_stock_threshold": "10",
      "filter_values": json.encode(payload),
      "total_amount": amountController.text,
      "grain_size": sizeController.text,
      "product_note": noteController.text,
      "outofstock_note": noteStockController.text,
      "outofstock": !isOutStock.value,
      "uoc": uocController.text,
    };

    try {
      final updateResponse = await _service.updateProduct(
        productId: product.id!,
        fields: fields,
        files: selectedFiles.isNotEmpty ? selectedFiles : null,
      );

      if (updateResponse.success == true) {
        await controller.fetchProducts();
        isLoading.value = false;

        Get.back();
        Get.back();
      } else {
        isLoading.value = false;
        SnackBars.errorSnackBar(
          content: updateResponse.message ?? 'Something went wrong!!',
        );
      }
    } catch (e) {
      isLoading.value = false;
      SnackBars.errorSnackBar(content: 'Error updating product: $e');
    }
  }
}

/// product_code, uoc, total_amount, product_note,oos_note, grain_size

///weight,stock_quantity
