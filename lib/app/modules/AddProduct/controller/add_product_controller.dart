import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:construction_technect/app/modules/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/AddProduct/models/ProductModel.dart';
import 'package:construction_technect/app/modules/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/core/utils/imports.dart'; // your CommonDropdown

class AddProductController extends GetxController {
  // ---------------- Form Controllers ----------------
  final productNameController = TextEditingController();
  final uomController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();

  final packageSizeController = TextEditingController();
  final shapeController = TextEditingController();
  final textureController = TextEditingController();
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

  // Reactive name lists for dropdowns
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;

  RxList<String> uomList = <String>["Kg", "Liters", "Pieces"].obs;

  // ---------------- Selections ----------------
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();

  // ---------------- State ----------------
  RxBool showExtraFields = false.obs;
  RxString pickedFileName = "Img45.jpg".obs;
  RxBool isEnabled = false.obs;
  RxBool isLoading = false.obs;

  final AddProductService _service = AddProductService();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
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
    if (selectedSub != null) {
      fetchProducts(selectedSub.id);
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

  void onProductSelected(String? productName) {
    selectedProduct.value = productName;
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
  }

  Future<void> pickFile() async {
    pickedFileName.value = "MyNewFile.png";
  }
}
