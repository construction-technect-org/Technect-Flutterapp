import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorSelectedProductController extends GetxController {
  CommonController commonController = Get.find();

  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;
  RxInt selectedSiteIndex = 1.obs;

  late PageController pageController;

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

  final List<CategoryItem> selectSubCategory = [CategoryItem("Sand", Asset.Product)];

  final List<CategoryItem> selectProduct = [
    CategoryItem("Manufature Sand", Asset.Product),
    CategoryItem("Concrete Sand", Asset.Product),
    CategoryItem("Plastering Sand", Asset.Product),
    CategoryItem("River Sand", Asset.Product),
    CategoryItem("Dust", Asset.Product),
  ];

  RxInt selectedIndex = (-1).obs;
  RxInt currentPage = 0.obs;

  RxInt selectedMainCategoryIndex = (-1).obs;
  RxInt selectedSubCategoryIndex = (-1).obs;

  final RxList<String> products = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  void onCameraIdle() {}

  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) return;
    isSearching.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSearching.value = false;
  }

  void selectSite(int index) {
    selectedSiteIndex.value = index;
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }

  void selectMainCategory(int index) {
    selectedMainCategoryIndex.value = index;
    selectedSubCategoryIndex.value = -1;
    selectedIndex.value = -1;
    products.clear();
  }

  void selectCategoryItem(int index) {
    selectedIndex.value = index;
    selectedSubCategoryIndex.value = -1;
    products.clear();
  }

  void selectSubCategoryItem(int index) {
    selectedSubCategoryIndex.value = index;
    // Example: Fill products dynamically based on subcategory
    products.value = selectProduct.map((e) => e.name).toList();
  }

  void selectProductItem(int index) {
    // Navigate to next page or perform any action
    goToPage(2); // Assuming page 2 is the next slider page
  }

  void goToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
