import 'dart:async';

import 'package:construction_technect/app/core/utils/imports.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressController extends GetxController {
  // Google Maps Controller
  GoogleMapController? mapController;

  // Location data
  final currentPosition = const LatLng(12.9716, 77.5946).obs;
  final selectedPosition = const LatLng(12.9716, 77.5946).obs;
  final currentAddress = ''.obs;
  final searchController = TextEditingController();
  final isLoading = false.obs;
  final isGettingLocation = false.obs;
  final isSearching = false.obs;
  final isFromLogin = false.obs;
  final isFromHome = false.obs;

  // Debounce timer for search
  Timer? _searchDebounce;

  // Map settings
  final mapZoom = 12.0.obs;
  final mapType = MapType.normal.obs;

  // Markers
  final markers = <MarkerId, Marker>{}.obs;

  RxString from = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      from.value = Get.arguments["from"] ?? "";
      isFromLogin.value = Get.arguments['isFromLogin'] ?? false;
      isFromHome.value = Get.arguments['isFromHome'] ?? false;
      isFromHome.value = Get.arguments['isFromHome'] ?? false;
    }

    _handlePassedData();
    _initializeLocation();
  }

  void _handlePassedData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      // Check if it's existing address data
      if (arguments.containsKey('address_line1')) {
        // We have existing address data
        final lat = arguments['latitude']?.toDouble();
        final lng = arguments['longitude']?.toDouble();

        if (lat != null && lng != null) {
          // Use existing coordinates
          final latLng = LatLng(lat, lng);
          currentPosition.value = latLng;
          selectedPosition.value = latLng;
        }
        // If lat/lng is null, we'll use live location in _initializeLocation

        // Set the address text
        final addressLine1 = arguments['address_line1'] ?? '';
        final city = arguments['city'] ?? '';
        final state = arguments['state'] ?? '';
        currentAddress.value = '$addressLine1, $city, $state';
        searchController.text = currentAddress.value;
      } else if (arguments.containsKey('latitude') &&
          arguments.containsKey('longitude')) {
        // We have coordinate data from map interaction
        final lat = arguments['latitude']?.toDouble();
        final lng = arguments['longitude']?.toDouble();

        if (lat != null && lng != null) {
          final latLng = LatLng(lat, lng);
          currentPosition.value = latLng;
          selectedPosition.value = latLng;
          _getAddressFromCoordinates(lat, lng);
        }
      }
    }
  }

  Future<void> _initializeLocation() async {
    try {
      final arguments = Get.arguments;

      if (arguments != null && arguments is Map<String, dynamic>) {
        // Check if we have existing address data
        if (arguments.containsKey('address_line1')) {
          final lat = arguments['latitude']?.toDouble();
          final lng = arguments['longitude']?.toDouble();

          if (lat != null && lng != null) {
            // Address has coordinates - use them (already set in _handlePassedData)
            // Don't get live location
          } else {
            // Address exists but no coordinates - get live location
            await _getCurrentLocation();
          }
        } else {
          // No existing address data - get live location
          await _getCurrentLocation();
        }
      } else {
        // No arguments - get live location
        await _getCurrentLocation();
      }

      _updateMarker();
    } catch (e) {
      Get.printError(info: 'Error initializing location: $e');
      // Continue with default location if current location fails
      _updateMarker();
    }
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      isGettingLocation.value = true;

      // Check if location services are enabled
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.printInfo(
          info: 'Location services disabled, using default location',
        );
        return; // Use default location instead of showing dialog
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.printInfo(
            info: 'Location permission denied, using default location',
          );
          return; // Use default location instead of showing dialog
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.printInfo(
          info:
              'Location permission permanently denied, using default location',
        );
        return; // Use default location instead of showing dialog
      }

      // Get current position with timeout
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      selectedPosition.value = currentPosition.value;

      // Get address from coordinates
      await _getAddressFromCoordinates(position.latitude, position.longitude);

      // Move camera to current location
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(currentPosition.value, mapZoom.value),
        );
      }

      Get.printInfo(
        info:
            'Current location obtained: ${position.latitude}, ${position.longitude}',
      );
    } catch (e) {
      Get.printError(info: 'Error getting location: $e');
      // Don't show error snackbar, just use default location
      Get.printInfo(info: 'Using default location due to error');
    } finally {
      isGettingLocation.value = false;
    }
  }

  void _updateMarker() {
    markers.clear();
    markers[const MarkerId('selected_location')] = Marker(
      markerId: const MarkerId('selected_location'),
      position: selectedPosition.value,
      draggable: true,
      onDragEnd: (LatLng newPosition) {
        selectedPosition.value = newPosition;
        _getAddressFromCoordinates(newPosition.latitude, newPosition.longitude);
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
  }

  // On map created
  void onMapCreated(GoogleMapController controller) {
    try {
      mapController = controller;
      _updateMarker();
      Get.printInfo(info: 'Google Map created successfully');
    } catch (e) {
      Get.printError(info: 'Error creating map: $e');
    }
  }

  // On camera move
  void onCameraMove(CameraPosition position) {
    try {
      selectedPosition.value = position.target;
    } catch (e) {
      Get.printError(info: 'Error in camera move: $e');
    }
  }

  // On camera idle
  void onCameraIdle() {
    try {
      _getAddressFromCoordinates(
        selectedPosition.value.latitude,
        selectedPosition.value.longitude,
      );
      _updateMarker();
    } catch (e) {
      Get.printError(info: 'Error in camera idle: $e');
    }
  }

  // Move to current location
  Future<void> moveToCurrentLocation() async {
    await _getCurrentLocation();
  }

  // Use current location button
  Future<void> useCurrentLocation() async {
    await _getCurrentLocation();
  }

  // Show location service dialog
  void _showLocationServiceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Please enable location services to use this feature.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Geolocator.openLocationSettings();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  // Show location permission dialog
  void _showLocationPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to show your current position.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Geolocator.openAppSettings();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  final Rx<Placemark?> place = Rx<Placemark?>(null);
  late final Placemark? place2;

  // Get address from coordinates
  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        place2 = placemarks[0];
        currentAddress.value =
            '${place2?.street}, ${place2?.locality}, ${place2?.administrativeArea}, ${place2?.country}';
        searchController.text = currentAddress.value;
      }
    } catch (e) {
      Get.printError(info: 'Error getting address: $e');
      currentAddress.value = 'Address not found';
    }
  }

  // Debounced search method
  void onSearchChanged(String query) {
    // Cancel previous timer
    _searchDebounce?.cancel();

    if (query.isEmpty) {
      isSearching.value = false;
      return;
    }

    // Set searching state
    isSearching.value = true;

    // Start new timer
    _searchDebounce = Timer(const Duration(milliseconds: 800), () {
      searchAddress(query);
    });
  }

  // Search for address
  Future<void> searchAddress(String query) async {
    if (query.isEmpty) {
      isSearching.value = false;
      return;
    }

    try {
      final List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final latLng = LatLng(location.latitude, location.longitude);

        selectedPosition.value = latLng;
        currentAddress.value = query;

        // Move camera to searched location
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(latLng, mapZoom.value),
          );
        }

        _updateMarker();
      }
    } catch (e) {
      Get.printError(info: 'Error searching address: $e');
      SnackBars.errorSnackBar(content: 'Address not found');
    } finally {
      isSearching.value = false;
    }
  }

  void navigateToManualAddress({bool isCLocation = false}) {
    // final arguments = Get.arguments;
    // final Map<String, dynamic> addressData = {
    //   'latitude': selectedPosition.value.latitude,
    //   'longitude': selectedPosition.value.longitude,
    //   'address': currentAddress.value,
    //   'isFromLogin': isFromLogin.value,
    // };
    //
    // // If we have existing address data, pass it along
    // if (arguments != null && arguments is Map<String, dynamic>) {
    //   if (arguments.containsKey('id')) {
    //     addressData.addAll(arguments);
    //   }
    // }

    Get.toNamed(
      Routes.ADD_LOCATION_MANUALLY,
      arguments: {
        "from": from.value,
        if (isCLocation) "isCLocation": place.value,
      },
    );
  }

  // Save location
  Future<void> saveLocation() async {
    isLoading.value = true;
    try {
      navigateToManualAddress();
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error saving location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    mapController?.dispose();
    searchController.dispose();
    super.onClose();
  }
}
