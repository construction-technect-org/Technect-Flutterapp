import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/main.dart';
import 'package:get/get.dart';

class SelectedProductController extends GetxController {
  // Observable variables
  RxInt selectedProductIndex = (-1).obs;

  // View state management
  RxBool isProductView = false.obs;
  RxBool isLoadingProducts = false.obs;
  RxBool isLoading = false.obs;

  // Product categories (from CategoryData model) and main products from API
  Rx<SubCategory> productCategories = SubCategory().obs;
  Rx<ConnectorSelectedProductModel?> productListModel =
      Rx<ConnectorSelectedProductModel?>(null);
  RxInt selectedProductCategoryIndex = 0.obs;

  // Variables for categories and products
  Rx<CategoryData?> mainCategory = CategoryData().obs; // Main Category
  RxList<SubCategory> subCategories = <SubCategory>[].obs; // Sub Category
  Rx<SubCategory?> selectedSubCategory = Rx<SubCategory?>(null);
  RxList<ProductCategory> products = <ProductCategory>[].obs;
  Rx<ProductCategory?> selectedProduct = Rx<ProductCategory?>(null);

  // Arguments from navigation
  int? mainCategoryId;
  String? mainCategoryName;
  RxInt selectedSubCategoryId = 0.obs;

  // Location data (you can get this from device location or user input)
  double latitude = 28.6139;
  double longitude = 77.2090;
  double radiusKm = 500022200;

  // Service instance
  final ConnectorSelectedProductServices services = ConnectorSelectedProductServices();

  @override
  void onInit() {
    super.onInit();
    // Get arguments passed from home page
    final arguments = Get.arguments as Map<String, dynamic>?;
    mainCategoryId = arguments?['mainCategoryId'] ?? 0;
    mainCategoryName = arguments?['mainCategoryName'] ?? 'Select Product';
    selectedSubCategoryId.value = arguments?['selectedSubCategoryId'] ?? 0;

    _initializeProductCategories();
  }

  void _initializeProductCategories() {
    if (mainCategoryId != null) {
      final categoryHierarchy = myPref.getCategoryHierarchyModel();

      mainCategory.value =
          categoryHierarchy?.data!.firstWhere(
            (category) => category.id == mainCategoryId,
          ) ??
          CategoryData();

      subCategories.value = mainCategory.value?.subCategories ?? <SubCategory>[];

      if (selectedSubCategoryId.value != 0) {
        selectedSubCategory.value = subCategories.firstWhere((element) {
          return selectedSubCategoryId.value == element.id;
        });
        products.value = selectedSubCategory.value?.products ?? <ProductCategory>[];
      }
    }
  }

  // Methods
  void selectSubCategory(int index) {
    selectedSubCategoryId.value = subCategories[index].id ?? 0;
    selectedSubCategory.value = subCategories[index];
    products.value = selectedSubCategory.value?.products ?? [];
    selectedProductIndex.value = -1; // Reset product selection
  }

  void selectProduct(int index) {
    selectedProductIndex.value = index;
    selectedProduct.value = products[index];
  }

  // Call API when product is clicked
  Future<void> fetchProductsFromApi({bool? isLoading}) async {
    if (selectedProduct.value == null || selectedSubCategory.value == null) {
      return;
    }

    isLoadingProducts.value = isLoading ?? true;

    try {
      // Call the service
      productListModel.value = await services.connectorProduct(
        mainCategoryId: mainCategoryId.toString(),
        subCategoryId: selectedSubCategory.value!.id.toString(),
        categoryProductId: selectedProduct.value!.id.toString(),
        radius: radiusKm.toInt(),
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        filters: {},
      );

      isProductView.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  Future<void> notifyMeApi({int? mID}) async {
    try {
      isLoading.value = true;
      final res = await services.notifyMe(mID: mID);
      if (res.success == true) {
        await fetchProductsFromApi(isLoading: false);
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToConnectApi({int? mID, int? pID, String? message}) async {
    try {
      isLoading.value = true;
      final res = await services.addToConnect(mID: mID, message: message, pID: pID);
      if (res.success == true) {
        await fetchProductsFromApi(isLoading: false);
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> wishListApi({required int mID, required String status}) async {
    try {
      isLoading.value = true;
      final res = await WishListServices().wishList(mID: mID, status: status);
      if (res.success == true) {
        await fetchProductsFromApi(isLoading: false);
      }
    } catch (e) {
      // No Error
    } finally {
      isLoading.value = false;
    }
  }

  // Select product category
  void selectProductCategory(int index) {
    selectedProductCategoryIndex.value = index;
    selectedProduct.value = productCategories.value.products?[index] ?? ProductCategory();
    fetchProductsFromApi();
  }

  // Go back to category view
  void goBackToCategoryView() {
    isProductView.value = false;
    productListModel.value = null;
    selectedProductCategoryIndex.value = 0;
  }
}
