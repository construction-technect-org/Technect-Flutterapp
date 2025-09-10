import 'dart:convert';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart'; // your CommonDropdown
import 'package:construction_technect/app/modules/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/AddProduct/service/AddProductService.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddProductController extends GetxController {
  final pageController = PageController();
  // ---------------- Form Controllers ----------------
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
  final grainSizeController = TextEditingController();
  final finenessModulusController = TextEditingController();
  final siltContentController = TextEditingController();
  final clayDustContentController = TextEditingController();
  final moistureContentController = TextEditingController();
  final specificGravityController = TextEditingController();
  final bulkDensityController = TextEditingController();
  final waterAbsorptionController = TextEditingController();
  final zoneController = TextEditingController();

  // ---------------- DropDown Data ----------------
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  RxList<Product> productsList = <Product>[].obs;
  RxList<FilterData> filters = <FilterData>[].obs;
  // Reactive name lists for dropdowns
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;

  RxList<String> uomList = <String>["Kg", "truck"].obs;

  // ---------------- Selections ----------------
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedMainCategoryId = Rxn<String>();
  Rxn<String> selectedSubCategoryId = Rxn<String>();
  Rxn<String> selectedProductId = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();

  // ---------------- State ----------------
  RxBool showExtraFields = false.obs;
  RxString pickedFileName = "".obs;
  RxString pickedFilePath = "".obs;
  RxBool isEnabled = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateProduct = false.obs;

  final AddProductService _service = AddProductService();
  bool isEdit = false;
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      isEdit = args['isEdit'] ?? false;
      isEnabled.value = args["isEnabled"] ?? false;
    }
    fetchMainCategories();
  }

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
      fetchSubCategories(selected.id);
    }
  }

  // ---------------- SubCategory ----------------
  void onSubCategorySelected(String? subCategoryName) {
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
      fetchProducts(selectedSub.id);
      getFilter(selectedSub.id);
    }
  }

  // ---------------- Products ----------------
  Future<void> fetchProducts(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await _service.productsBySubCategory(subCategoryId);

      if (result.success) {
        productsList.value = result.data;
        productNames.value = result.data.map((e) => e.name).toList();
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
        for (FilterData filter in filters) {
          dynamicControllers[filter.filterName ?? ''] = TextEditingController();
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
      if (result.success) {
        mainCategories.value = result.data;
        mainCategoryNames.value = result.data.map((e) => e.name).toList();
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
      if (result.success) {
        subCategories.value = result.data;
        subCategoryNames.value = result.data.map((e) => e.name).toList();
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

  // ---------------- Helpers ----------------
  void submitProduct() {
    showExtraFields.value = true;
    createProductValidation();
  }

  void gstCalculate() {
    final double amount =
        (double.parse(priceController.text.isEmpty ? '0.0' : priceController.text) *
            double.parse(gstController.text.isEmpty ? '0.0' : gstController.text)) /
        100;
    gstPriceController.text = amount.toString();
  }

  Future<void> pickFile() async {
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
    } else if (selectedMainCategoryId.value == null) {
      SnackBars.errorSnackBar(content: 'Main category is required');
      isRequired = false;
    } else if (selectedSubCategoryId.value == null) {
      SnackBars.errorSnackBar(content: 'Sub category is required');
      isRequired = false;
    } else if (selectedProductId.value == null) {
      SnackBars.errorSnackBar(content: 'Product is required');
      isRequired = false;
    } else if (selectedUom.value == null) {
      SnackBars.errorSnackBar(content: 'UOM is required');
      isRequired = false;
    } else if (priceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Price is required');
      isRequired = false;
    } else if (stockController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Stock is required');
      isRequired = false;
    } else if (gstPriceController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'GST price is required');
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
      SnackBars.errorSnackBar(content: 'Size is required');
    } else if (weightController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Weight is required');
    } else {
      createProduct();
    }
  }

  Future<void> createProduct() async {
    isLoadingCreateProduct.value = true;
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
      "category_product_id": selectedProductId.value,
      "stock_quantity": stockController.text,
      "brand": brandNameController.text,
      "uom": selectedUom.value,
      "package_type": packageTypeController.text,
      "package_size": packageSizeController.text,
      "shape": shapeController.text,
      "texture": textureController.text,
      "colour": colorController.text,
      "size": sizeController.text,
      "weight": weightController.text,
      "is_active": isEnabled.value,
      "is_featured": false,
      "sort_order": "1",
      "filter_values": json.encode(payload),
    };

    try {
      final addTeamResponse = await _service.createProduct(
        fields: fields,
        files: selectedFiles,
      );

      if (addTeamResponse.success == true) {
        isLoadingCreateProduct.value = false;
        Get.back();
      } else {
        isLoadingCreateProduct.value = false;
        SnackBars.errorSnackBar(
          content: addTeamResponse.message ?? 'Something went wrong!!',
        );
      }
    } catch (e) {
      isLoadingCreateProduct.value = false;
    }
  }
}
