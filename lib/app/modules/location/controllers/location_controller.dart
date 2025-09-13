import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  // Loading state
  RxBool isLoading = false.obs;

  // Search related
  final TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;

  // Google Map variables
  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs; // default to Surat
  RxDouble mapZoom = 14.0.obs;
  Rx<MapType> mapType = MapType.normal.obs;

  final markers = <String, Marker>{}.obs;

  /// Called when Google Map is created
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /// Track camera movement
  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  /// Called when camera stops moving
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

  /// Navigate to manual entry
  void navigateToManualAddress() {
    Get.toNamed('/manual-address');
  }

  /// Use current GPS location
  Future<void> useCurrentLocation() async {
    try {
      isLoading.value = true;
      // fetch location with geolocator / location package
      await Future.delayed(const Duration(seconds: 2));

      currentPosition.value = const LatLng(21.1702, 72.8311); // example
      mapController.animateCamera(
        CameraUpdate.newLatLng(currentPosition.value),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Save location
  void saveLocation() {
    Get.back(result: currentPosition.value);
  }
}
