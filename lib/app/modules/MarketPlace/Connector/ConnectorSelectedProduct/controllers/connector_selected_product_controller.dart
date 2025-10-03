import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
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
  RxList<ConnectorCategory> mainCategories = <ConnectorCategory>[].obs;
  RxList<ConnectorCategory> subCategories = <ConnectorCategory>[].obs;
  RxList<ConnectorCategory> categoryProducts = <ConnectorCategory>[].obs;
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
    pageController = PageController();
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

  /// MAIN CATEGORY SELECTION
  Future<void> selectMainCategory(int index) async {
    selectedMainCategoryIndex.value = index;
    selectedSubCategoryIndex.value = -1;
    selectedProductCategoryIndex.value = -1;
    selectedProductIndex.value = -1;

    subCategories.clear();
    categoryProducts.clear();
    products.clear();

    try {
      isLoading.value = true;
      final res = await services.connectorProduct(
        mainCategoryId: mainCategories[index].id,
      );
      subCategories.value = res.data?.filters.subCategories ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load subcategories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// SUBCATEGORY SELECTION
  Future<void> selectSubCategory(int index) async {
    selectedSubCategoryIndex.value = index;
    selectedProductCategoryIndex.value = -1;
    selectedProductIndex.value = -1;

    categoryProducts.clear();
    products.clear();

    try {
      isLoading.value = true;
      final res = await services.connectorProduct(
        mainCategoryId: mainCategories[selectedMainCategoryIndex.value].id,
        subCategoryId: subCategories[index].id,
      );
      categoryProducts.value = res.data?.filters.categoryProducts ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load category products: $e");
    } finally {
      isLoading.value = false;
    }
  }

 /// FETCH MAIN CATEGORIES
  Future<void> fetchMainCategories() async {
    try {
      isLoading.value = true;
      final res = await services.connectorProduct();
      mainCategories.value = res.data?.filters.mainCategories ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load bottom categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// PRODUCT SELECTION
  void selectProductItem(int index) {
    selectedProductIndex.value = index;
    goToPage(2); // Slide to next screen
  }

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

 
}
