import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddProductController extends GetxController {
  final pageController = PageController();
  Product product = Product();

  // ProductManagementController controller = Get.find();

  // ---------------- Form Controllers ----------------

  RxList addProduct = [
    "1.Basic Product Details",
    "2.Pricing & Units",
    "3.Technical Specifications",
  ].obs;
  RxList<String?> imageSlots = List<String?>.filled(5, null).obs;
  Map<String, String> removedImages = {};

  RxBool isOutStock = true.obs;
  final productCodeController = TextEditingController();
  final noteStockController = TextEditingController();
  final noteController = TextEditingController();
  final amountController = TextEditingController();

  final productNameController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();
  final brandNameController = TextEditingController();

  // ---------------- DropDown Data ----------------
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  RxList<CategoryProduct> productsList = <CategoryProduct>[].obs;
  RxList<FilterData> filters = <FilterData>[].obs;

  // Reactive name lists for dropdowns
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;

  RxList<String> gstList = <String>["5%", "12%", "18%", "28%"].obs;

  // ---------------- Selections ----------------
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedMainCategoryId = Rxn<String>();
  Rxn<String> selectedSubCategoryId = Rxn<String>();
  Rxn<String> selectedProductId = Rxn<String>();
  Rxn<String> selectedGST = Rxn<String>();

  // ---------------- State ----------------
  RxBool showExtraFields = false.obs;
  RxList<String> pickedFilePathList = <String>[].obs;
  RxBool isEnabled = true.obs;
  RxBool isLoading = false.obs;

  final AddProductService _service = AddProductService();
  bool isEdit = false;
  final VoidCallback? onApiCall =Get.arguments!=null? Get.arguments['onApiCall'] : () {};

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      isEdit = args['isEdit'] ?? false;
      product = args['product'] ?? Product();
      if (isEdit == true) {
        WidgetsBinding.instance.addPostFrameCallback((val) async {
          selectedVideo.value = File("abc");
          videoPlayerController?.dispose();
          videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(APIConstants.bucketUrl + product.productVideo.toString()),
          );
          await videoPlayerController!.initialize();
          videoPlayerController!.setLooping(false);
        });
      }

      _initializeEditMode();
    }
    initCalled();
  }

  Future<void> initCalled() async {
    await fetchMainCategories();
    if (isEdit && product.subCategoryId != null) {
      _storedFilterValues = product.filterValues;
      await fetchSubCategories(product.mainCategoryId ?? 0);
      await fetchProducts(product.subCategoryId ?? 0);
      await getFilter(product.categoryProductId ?? 0);
      selectedMainCategory.value = product.mainCategoryName ?? '';
      selectedSubCategory.value = product.subCategoryName ?? '';
      selectedProduct.value = product.categoryProductName ?? '';

      selectedMainCategoryId.value = (product.mainCategoryId ?? 0).toString();
      selectedSubCategoryId.value = (product.subCategoryId ?? 0).toString();
      selectedProductId.value = (product.categoryProductId ?? 0).toString();
    }
  }

  void _initializeEditMode() {
    productNameController.text = product.productName ?? '';
    productCodeController.text = product.productCode ?? '';
    amountController.text = product.totalAmount ?? '';
    noteController.text = product.productNote ?? '';
    isOutStock.value = !(product.outOfStock ?? false);
    stockController.text = product.stockQty?.toString() ?? '';
    priceController.text = product.price ?? '';
    if ((product.gstPercentage ?? "").isNotEmpty) {
      selectedGST.value = "${product.gstPercentage?.split(".").first}%";
      print(selectedGST.value);
    }
    gstPriceController.text = product.gstAmount ?? '';
    termsController.text = product.termsAndConditions ?? '';
    brandNameController.text = product.brand ?? '';
    if ((product.images ?? []).isNotEmpty) {
      for (final image in product.images!) {
        pickedFilePathList.add("${APIConstants.bucketUrl}${image.s3Key!}");
      }
    }
    // 🟩 Always create 5 slots
    imageSlots.value = List<String?>.filled(5, null);

    // 🟨 Fill existing images
    final existingImages = product.images ?? [];
    for (int i = 0; i < existingImages.length && i < 5; i++) {
      imageSlots[i] = "${APIConstants.bucketUrl}${existingImages[i].s3Key!}";
    }
  }

  void removeImageAt(int index) {
    if (imageSlots[index] != null) {
      removedImages["remove_image_${index + 1}"] = "remove";
      imageSlots[index] = null;
    }
  }

  Map<String, dynamic>? _storedFilterValues;

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

    final selected = mainCategories.firstWhereOrNull(
      (c) => c.name == categoryName,
    );
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

    final selectedSub = subCategories.firstWhereOrNull(
      (s) => s.name == subCategoryName,
    );
    selectedSubCategoryId.value = '${selectedSub?.id ?? 0}';

    if (selectedSub != null) {
      await fetchProducts(selectedSub.id ?? 0);
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
  final Map<String, Rxn<String>> dropdownValues = {};
  final Map<String, RxList<String>> multiDropdownValues = {};

  Future<void> getFilter(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await _service.getFilter(subCategoryId);

      if (result.success == true) {
        filters.value = (result.data as List<FilterData>)
            .map((e) => e)
            .toList();
        for (final FilterData filter in filters) {
          if (filter.filterType == 'dropdown') {
            dropdownValues[filter.filterName ?? ''] = Rxn<String>();
          } else if (filter.filterType == 'dropdown_multiple') {
            multiDropdownValues[filter.filterName ?? ''] = <String>[].obs;
          } else {
            dynamicControllers[filter.filterName ?? ''] =
                TextEditingController();
          }
        }

        if (isEdit &&
            _storedFilterValues != null &&
            _storedFilterValues!.isNotEmpty) {
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
      final Map<String, dynamic> filterValues = _storedFilterValues!;

      filterValues.forEach((key, value) {
        dynamic actualValue;

        // 🟩 If API sends structured object {label, value}
        if (value is Map<String, dynamic>) {
          actualValue = value['value'];
        } else {
          actualValue = value;
        }

        // 🟦 If stored value is JSON string list → decode it
        if (actualValue is String &&
            actualValue.trim().startsWith('[') &&
            actualValue.trim().endsWith(']')) {
          try {
            actualValue = jsonDecode(actualValue);
          } catch (_) {}
        }

        // 🟨 Now assign based on field type
        if (actualValue == null) return;

        // Text fields
        if (dynamicControllers.containsKey(key)) {
          if (actualValue is List) {
            dynamicControllers[key]!.text = actualValue.join(', ');
          } else {
            dynamicControllers[key]!.text = actualValue.toString();
          }
        }
        // Dropdown (single)
        else if (dropdownValues.containsKey(key)) {
          if (actualValue is String) {
            dropdownValues[key]!.value = actualValue;
          } else if (actualValue is List && actualValue.isNotEmpty) {
            dropdownValues[key]!.value = actualValue.first.toString();
          }
        }
        // Dropdown multiple (list)
        else if (multiDropdownValues.containsKey(key)) {
          final listValue = (actualValue is List)
              ? actualValue.map((e) => e.toString()).toList()
              : [actualValue.toString()];

          multiDropdownValues[key]!.assignAll(listValue);
        }
      });
    } catch (e) {
      log('Error parsing stored filter values: $e');
    }
  }

  Future<void> onProductSelected(String? productName) async {
    selectedProduct.value = productName;
    final selectedCategorySub = productsList.firstWhereOrNull(
      (s) => s.name == productName,
    );
    selectedProductId.value = '${selectedCategorySub?.id ?? 0}';
    await getFilter(selectedCategorySub?.id ?? 0);
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

  void submitProduct(GlobalKey<FormState> formKey) {
    showExtraFields.value = true;
    createProductValidation(formKey);
  }

  void gstCalculate() {
    final double amount =
        double.parse(
          priceController.text.isEmpty ? '0.0' : priceController.text,
        ) *
        double.parse(
          selectedGST.value.toString().replaceAll("%", "").isEmpty
              ? '0.0'
              : (selectedGST.value.toString().replaceAll("%", "")),
        ) /
        100;
    gstPriceController.text = amount.toStringAsFixed(2);
    amountController.text = (amount + double.parse(priceController.text))
        .toStringAsFixed(2);
  }

  Future<void> pickImage() async {
    try {
      final XFile? result = await CommonConstant().pickImageFromGallery();

      if (result != null && result.path.isNotEmpty) {
        final XFile file = result;
        pickedFilePathList.add(file.path);
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to pick file: $e', time: 3);
    }
  }

  Future<void> pickImageEdit() async {
    try {
      final XFile? picked = await CommonConstant().pickImageFromGallery();
      if (picked != null && picked.path.isNotEmpty) {
        // 🟩 Step 1: Remove stale remove flags for occupied slots
        final toRemove = <String>[];
        removedImages.forEach((key, value) {
          final index = int.parse(key.split('_').last) - 1;
          if (index >= 0 &&
              index < imageSlots.length &&
              imageSlots[index] != null) {
            toRemove.add(key);
          }
        });
        for (final key in toRemove) {
          removedImages.remove(key);
        }

        // 🟨 Step 2: Find first empty slot
        final emptyIndex = imageSlots.indexWhere((e) => e == null);

        if (emptyIndex != -1) {
          // 🟦 Step 3: Cancel its removal flag (if existed)
          removedImages.remove("remove_image_${emptyIndex + 1}");

          // 🟧 Step 4: Assign new file
          imageSlots[emptyIndex] = picked.path;
        } else {
          SnackBars.errorSnackBar(content: "Maximum 5 images allowed");
        }

        // 🟥 Step 5: Cleanup: remove remove flags if at least one valid image exists
        final hasAnyImage = imageSlots.any(
          (e) => e != null && e.toString().isNotEmpty,
        );
        if (hasAnyImage) {
          removedImages.removeWhere((key, value) {
            final index = int.parse(key.split('_').last) - 1;
            return index >= 0 &&
                index < imageSlots.length &&
                imageSlots[index] != null;
          });
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Failed to pick image: $e", time: 3);
    }
  }

  void createProductValidation(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;

    // if (brandNameController.text.isEmpty) {
    //   SnackBars.errorSnackBar(content: 'Brand name is required');
    //   return;
    // }

    if (form != null && !form.validate()) {
      return;
    }

    // If validation passes
    if (isEdit) {
      updateProduct();
    } else {
      navigate();
    }
  }

  Map<String, dynamic> buildFilterValues() {
    final Map<String, dynamic> filterValues = {};

    for (final filter in filters) {
      final filterName = filter.filterName ?? '';
      if (filterName.isEmpty) continue;

      // For dropdown filters
      if (filter.filterType == 'dropdown') {
        final selectedValue = dropdownValues[filterName]?.value;
        if (selectedValue != null && selectedValue.isNotEmpty) {
          filterValues[filterName] = selectedValue;
        }
      } else if (filter.filterType == 'dropdown_multiple') {
        final selectedList = multiDropdownValues[filterName];
        if (selectedList != null && selectedList.isNotEmpty) {
          filterValues[filterName] = selectedList.toList();
        }
      } else {
        final textValue = dynamicControllers[filterName]?.text.trim();
        if (textValue != null && textValue.isNotEmpty) {
          filterValues[filterName] = textValue;
        }
      }
    }

    print(filterValues);

    return filterValues;
  }

  Map<String, dynamic> buildFilterValues2() {
    final Map<String, dynamic> filterValues = {};

    for (final filter in filters) {
      final filterName = filter.filterName ?? '';
      if (filterName.isEmpty) continue;

      String? value;

      // Dropdown filters
      if (filter.filterType == 'dropdown') {
        final selectedValue = dropdownValues[filterName]?.value;
        if (selectedValue != null && selectedValue.isNotEmpty) {
          value = selectedValue;
        }
      }
      if (filter.filterType == 'dropdown_multiple') {
        final selectedList = multiDropdownValues[filterName];
        if (selectedList != null && selectedList.isNotEmpty) {
          filterValues[filterName] = selectedList.toList();
        }
      } else {
        final textValue = dynamicControllers[filterName]?.text.trim();
        if (textValue != null && textValue.isNotEmpty) {
          value = textValue;
        }
      }

      if (value != null && value.isNotEmpty) {
        filterValues[filterName] = {
          "value": value,
          "display_value": value == filter.unit
              ? value
              : value +
                    (filter.unit != null && filter.unit!.isNotEmpty
                        ? " ${filter.unit}"
                        : ""),
          "unit": filter.unit,
          "label": filter.filterLabel ?? _formatKeyName(filterName),
          "type": filter.filterType ?? "text",
        };
      }
    }

    if (kDebugMode) {
      print("Built filter values: $filterValues");
    }
    return filterValues;
  }

  String _formatKeyName(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word,
        )
        .join(' ');
  }

  void navigate() {
    hideKeyboard();
    final List<ProductImage> productImages = pickedFilePathList.map((file) {
      return ProductImage(s3Url: file);
    }).toList();
    final Product p = Product(
      images: productImages,
      gstAmount: gstPriceController.text,
      merchantGstNumber:
          Get.find<HomeController>()
              .profileData
              .value
              .data
              ?.merchantProfile
              ?.gstinNumber ??
          '',
      mainCategoryName: selectedMainCategory.value,
      subCategoryName: selectedSubCategory.value,
      productName: productNameController.text,
      productVideo: selectedVideo.value?.path,
      categoryProductName: selectedProduct.value,
      brand: brandNameController.text,
      mainCategoryId: int.parse(selectedMainCategoryId.value ?? "0"),
      subCategoryId: int.parse(selectedSubCategoryId.value ?? "0"),
      categoryProductId: int.parse(selectedProductId.value ?? "0"),
      price: priceController.text,
      productCode: productCodeController.text,
      totalAmount: amountController.text,
      productNote: noteController.text,
      gstPercentage: (selectedGST.value ?? "").replaceAll("%", ""),
      termsAndConditions: termsController.text,
      outOfStock: false,
      stockQty: int.parse(
        stockController.text.isEmpty ? "0" : stockController.text,
      ),
      filterValues: buildFilterValues2(),
    );
    Get.toNamed(
      Routes.PRODUCT_DETAILS,
      arguments: {"product": p, "isFromAdd": true, "isFromConnector": false},
    );
  }

  Future<void> createProduct() async {
    isLoading.value = true;
    Map<String, dynamic> fields = {};
    final imageList = pickedFilePathList;
    int index = 1;
    final Map<String, String> selectedFiles = {};
    for (final path in imageList) {
      if (path.contains('http')) {
        fields["image_$index"] = path;
      } else {
        selectedFiles["image_$index"] = path;
      }
      index++;
    }

    selectedFiles["video"] = selectedVideo.value?.path ?? "";

    final Map<String, String> payload = {};
    dynamicControllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        payload[key] = controller.text;
      }
    });
    fields = {
      "main_category_id": selectedMainCategoryId.value,
      "sub_category_id": selectedSubCategoryId.value,
    };

    if (productNames.isNotEmpty && selectedProductId.value != null) {
      fields["category_product_id"] = selectedProductId.value;
    }

    fields.addAll({
      "price": priceController.text,
      "total_amount": amountController.text,
      "product_note": noteController.text,
      "gst_percentage": (selectedGST.value ?? "").replaceAll("%", ""),
      "terms_and_conditions": termsController.text,
      "stock_qty": isOutStock.value == true
          ? int.parse(stockController.text)
          : 0,
      "outofstock": !isOutStock.value,
      "brand": brandNameController.text,
      // "is_active": isEnabled.value,
      "is_featured": false,
      "sort_order": "1",
      "filter_values": jsonEncode(buildFilterValues()),
    });
    try {
      final addTeamResponse = await _service.createProduct(
        fields: fields,
        files: selectedFiles,
      );
      if (addTeamResponse.success == true) {
        // await controller.fetchProducts();
        isLoading.value = false;
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

    final Map<String, dynamic> fields = {};
    final Map<String, String> selectedFiles = {};

    // 🟩 Step 1: Prepare a copy of remove map
    final Map<String, String> tempRemoved = Map.from(removedImages);

    // 🟦 Step 2: Rebuild fields and remove flags properly
    for (int i = 0; i < imageSlots.length; i++) {
      final path = imageSlots[i];
      final key = "image_${i + 1}";

      if (path == null || path.trim().isEmpty) {
        // slot is empty => keep/remove flag
        tempRemoved["remove_image_${i + 1}"] = "remove";
        continue;
      }

      // slot has an image, so ensure it's not marked removed
      tempRemoved.remove("remove_image_${i + 1}");

      if (path.contains('http')) {
        fields[key] = path;
      } else {
        selectedFiles[key] = path;
      }
    }
    if ((selectedVideo.value?.path ?? "") != "abc") {
      selectedFiles["video"] = selectedVideo.value?.path ?? "";
    }

    // 🟥 Step 3: Add remove flags to fields
    fields.addAll(tempRemoved);

    // 🟨 Step 4: Add product fields
    fields.addAll({
      "price": priceController.text,
      "gst_percentage": (selectedGST.value ?? "").replaceAll("%", ""),
      "terms_and_conditions": termsController.text,
      "stock_qty": isOutStock.value ? stockController.text : "0",
      "brand": brandNameController.text,
      // "is_active": isEnabled.value.toString(),
      "is_featured": "false",
      "sort_order": "1",
      "low_stock_threshold": "10",
      "filter_values": json.encode(buildFilterValues()),
      "total_amount": amountController.text,
      "product_note": noteController.text,
      "outofstock": !isOutStock.value,
      "outofstock_note": noteStockController.text,
    });

    try {
      final res = await _service.updateProduct(
        productId: product.id!,
        fields: fields,
        files: selectedFiles.isNotEmpty ? selectedFiles : null,
      );

      if (res.success) {
        onApiCall?.call();

        Get.back();
        Get.back();
      } else {
        SnackBars.errorSnackBar(
          content: res.message ?? 'Something went wrong!',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Update failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final Rx<File?> selectedVideo = Rx<File?>(null);
  VideoPlayerController? videoPlayerController;

  Future<void> openVideoPickerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Video Option", style: MyTexts.medium16),
                const Gap(20),
                ListTile(
                  leading: const Icon(Icons.videocam_rounded),
                  title: const Text("Record Video"),
                  onTap: () {
                    Get.back();
                    pickVideo(isRecord: true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_library_rounded),
                  title: const Text("Upload from Gallery"),
                  onTap: () {
                    Get.back();
                    pickVideo(isRecord: false);
                  },
                ),
                const Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickVideo({required bool isRecord}) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickVideo(
      source: isRecord ? ImageSource.camera : ImageSource.gallery,
      maxDuration: const Duration(minutes: 2),
    );

    if (picked != null) {
      final file = File(picked.path);
      final sizeInMB = file.lengthSync() / (1024 * 1024);
      if (sizeInMB > 24) {
        SnackBars.errorSnackBar(content: "Video must be less than 24 MB");
        return;
      }

      selectedVideo.value = file;
      videoPlayerController?.dispose();
      videoPlayerController = VideoPlayerController.file(file);
      await videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
    }
  }

  void removeVideo() {
    selectedVideo.value = null;
    videoPlayerController?.dispose();
    videoPlayerController = null;
  }
}
