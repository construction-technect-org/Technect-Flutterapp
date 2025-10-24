import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/controller/delivery_location_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddDeliveryAddressController extends GetxController {
  RxBool isLoading = false.obs;
  HomeController homeController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  DeliveryLocationController controller = Get.find();
  RxBool isEditMode = false.obs;
  RxString editAddressId = ''.obs;

  RxBool isSearching = false.obs;
  RxString selectedAddress = ''.obs;
  RxList<Prediction> searchResults = <Prediction>[].obs;

  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxDouble mapZoom = 14.0.obs;
  Rx<MapType> mapType = MapType.normal.obs;

  @override
  void onInit() {
    super.onInit();
    _checkEditMode();
    _getCurrentLocation();
  }

  @override
  void onClose() {
    searchController.dispose();
    addressNameController.dispose();
    landmarkController.dispose();
    super.onClose();
  }

  void _checkEditMode() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['isEdit'] == true) {
      isEditMode.value = true;
      editAddressId.value = (arguments['addressId'] ?? 0).toString();
      addressNameController.text = arguments['addressName'] ?? '';
      landmarkController.text = arguments['landmark'] ?? '';
      selectedAddress.value = arguments['fullAddress'] ?? '';
      searchController.text = arguments['fullAddress'] ?? '';

      if (arguments['latitude'] != null && arguments['longitude'] != null) {
        try {
          final lat = double.parse(arguments['latitude']);
          final lng = double.parse(arguments['longitude']);
          currentPosition.value = LatLng(lat, lng);
        } catch (e) {
          // NO Error
        }
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      isLoading.value = true;

      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        SnackBars.errorSnackBar(
          content: 'Location services are disabled. Please enable location services.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SnackBars.errorSnackBar(content: 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        SnackBars.errorSnackBar(content: 'Location permissions are permanently denied.');
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error getting current location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  void onCameraIdle() {
    if (isSearching.value == false) {
      searchController.clear();
      _getAddressFromCoordinates(
        currentPosition.value.latitude,
        currentPosition.value.longitude,
      );
    } else {
      isSearching.value = false;
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        final String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        selectedAddress.value = address;
      }
    } catch (e) {
      selectedAddress.value = 'Address not found';
    }
  }

  bool _validateForm() {
    if (addressNameController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter address name');
      return false;
    }

    if (landmarkController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter landmark');
      return false;
    }

    return true;
  }

  Future<void> submitDeliveryAddress() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      final Map<String, dynamic> deliveryAddress = {
        "site_name": addressNameController.text.trim(),
        "full_address": selectedAddress.value,
        "landmark": landmarkController.text.trim(),
        "latitude": currentPosition.value.latitude,
        "longitude": currentPosition.value.longitude,
        "is_default": true,
      };
      log(deliveryAddress.toString());
      if (isEditMode.value) {
        await DeliveryAddressService.updateDeliveryAddress(
          editAddressId.value,
          deliveryAddress,
        );
      } else {
        await DeliveryAddressService.submitDeliveryAddress(deliveryAddress);
      }

      await homeController.fetchProfileData();

      Get.back();
    } catch (e) {
      // No error
    } finally {
      isLoading.value = false;
    }
  }
}
