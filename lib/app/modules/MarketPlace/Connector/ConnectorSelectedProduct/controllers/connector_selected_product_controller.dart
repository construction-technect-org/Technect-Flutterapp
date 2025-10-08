import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorSelectedProductController extends GetxController {
 
  /// Loading & Search
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();

  /// Page Controller
  late PageController pageController;
  RxInt currentPage = 0.obs;

  /// Map & Location
  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxDouble mapZoom = 14.0.obs;
  Rx<MapType> mapType = MapType.normal.obs;
  final markers = <String, Marker>{}.obs;

  final RxList<String> sites = [
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
  ].obs;
  RxInt selectedSiteIndex = 0.obs;

  /// Category & Product Selection
  // RxList<ConnectorCategory> mainCategories = <ConnectorCategory>[].obs;
  // RxList<ConnectorCategory> subCategories = <ConnectorCategory>[].obs;
  // RxList<ConnectorCategory> categoryProducts = <ConnectorCategory>[].obs;
  RxList<Product> products = <Product>[].obs;

  RxInt selectedMainCategoryIndex = (-1).obs;
  RxInt selectedSubCategoryIndex = (-1).obs;
  RxInt selectedProductCategoryIndex = (-1).obs;
  RxInt selectedProductIndex = (-1).obs;

  /// Services
  final ConnectorSelectedProductServices services = ConnectorSelectedProductServices();

  @override
  void onInit() {
    super.onInit();
    fetchMainCategories();
  }

  /// MAP HANDLERS
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  void onCameraIdle() {}

  /// SEARCH HANDLER
  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) return;
    isSearching.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSearching.value = false;
  }

  /// SITE SELECTION
  void selectSite(int index) {
    selectedSiteIndex.value = index;
  }

  /// PAGE NAVIGATION
  void goToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  RxList<Product> filteredProducts = <Product>[].obs;

  RxString searchQuery = ''.obs;

  Future<void> getAllProducts() async {
    try {
      isLoading.value = true;

      final res = await services.connectorProduct(
        mainCategoryId: selectedMainCategoryId.value ?? '',
        subCategoryId: selectedSubCategoryId.value ?? '',
        categoryProductId: selectedProductId.value ?? '',
      );
      filteredProducts.value = res.data?.products ?? [];

    } catch (e) {
      Get.snackbar("Error", "Failed to load products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<ConnectorCategory> categoryProducts = <ConnectorCategory>[].obs;


  /// OPTIONAL: RESET SELECTIONS
  void resetSelections() {
    selectedMainCategoryIndex.value = -1;
    selectedSubCategoryIndex.value = -1;
    selectedProductCategoryIndex.value = -1;
    selectedProductIndex.value = -1;

    subCategories.clear();
    categoryProducts.clear();
    products.clear();
  }

  //////////////

  RxList<CategoryProduct> productsList = <CategoryProduct>[].obs;
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedMainCategoryId = Rxn<String>();
  Rxn<String> selectedSubCategoryId = Rxn<String>();
  Rxn<String> selectedProductId = Rxn<String>();
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;

  Future<void> fetchMainCategories() async {
    try {
      isLoading(true);
      final result = await AddProductService().mainCategory();
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
      final result = await AddProductService().subCategory(mainCategoryId);
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

  Future<void> fetchProducts(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().productsBySubCategory(subCategoryId);

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

 
}
