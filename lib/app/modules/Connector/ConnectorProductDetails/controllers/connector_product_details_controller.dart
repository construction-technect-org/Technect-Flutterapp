import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorProductDetailsController extends GetxController {
  CommonController commonController = Get.find();

  // Loading state
  RxBool isLoading = false.obs;

  // Search related
  final TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;
  RxInt selectedSiteIndex = 1.obs; // default to Site 2

  // PageView controller for sliding pages
  late PageController pageController;

  // Google Map variables
  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs; // default to Surat
  RxDouble mapZoom = 14.0.obs;
  Rx<MapType> mapType = MapType.normal.obs;

  final markers = <String, Marker>{}.obs;

  /// Sites
  final RxList<String> sites = [
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
    "3VR7+34 Mumbai, Maharashtra,3VR7+34 Mumbai, 460017",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(); // initialize PageController
  }

  /// Google Map callbacks
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  void onCameraIdle() {
    // e.g. fetch address for currentPosition
  }

  /// Search location
  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) return;
    isSearching.value = true;

    // Call your API here for places search...
    await Future.delayed(const Duration(seconds: 1));

    isSearching.value = false;
  }

  /// Select recent site
  void selectSite(int index) {
    selectedSiteIndex.value = index;
  }
}
