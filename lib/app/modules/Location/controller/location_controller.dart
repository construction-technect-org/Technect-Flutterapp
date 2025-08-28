import 'package:get/get.dart';

class LocationController extends GetxController {
  // Example observables
  RxString searchQuery = "".obs;
  RxString currentLocation = "".obs;

  // Example methods
  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void useCurrentLocation() {
    currentLocation.value = "Using GPS location...";
    // TODO: integrate with location service later
  }
}
