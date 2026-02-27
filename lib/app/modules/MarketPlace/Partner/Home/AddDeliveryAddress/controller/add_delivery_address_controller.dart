import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddDeliveryAddressController extends GetxController {
  RxBool isLoading = false.obs;

  FocusNode googleFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController buildingBlockController = TextEditingController();
  final TextEditingController landmarkAreaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  RxString selectedLabel = 'Billing Address'.obs;
  final List<String> labelOptions = [
    'Billing Address',
    'Office Address',
    'Project Address',
    'Manufacturing Address',
  ];

  RxBool isEditMode = false.obs;
  RxString editAddressId = ''.obs;

  RxBool isSearching = false.obs;
  RxString selectedAddress = ''.obs;
  RxList<Prediction> searchResults = <Prediction>[].obs;

  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxDouble mapZoom = 16.0.obs;
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
    houseNoController.dispose();
    buildingBlockController.dispose();
    landmarkAreaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }

  void _checkEditMode() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['isEdit'] == true) {
      isEditMode.value = true;
      editAddressId.value = (arguments['addressId'] ?? 0).toString();
      selectedLabel.value = arguments['label'] ?? arguments['siteName'] ?? 'Billing Address';
      houseNoController.text = arguments['addressLine1'] ?? arguments['addressName'] ?? '';
      buildingBlockController.text = arguments['addressLine2'] ?? '';
      landmarkAreaController.text = arguments['landmark'] ?? '';
      pincodeController.text = arguments['pincode'] ?? '';
      cityController.text = arguments['city'] ?? '';
      stateController.text = arguments['state'] ?? '';
      countryController.text = arguments['country'] ?? '';
      selectedAddress.value = arguments['fullAddress'] ?? '';
      searchController.text = arguments['fullAddress'] ?? '';

      if (arguments['latitude'] != null && arguments['longitude'] != null) {
        try {
          final lat = double.parse(arguments['latitude'].toString());
          final lng = double.parse(arguments['longitude'].toString());
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
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
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
      _getAddressFromCoordinates(currentPosition.value.latitude, currentPosition.value.longitude);
    } else {
      isSearching.value = false;
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];

        // Auto-fill fields
        pincodeController.text = place.postalCode ?? '';
        cityController.text = place.locality ?? place.subAdministrativeArea ?? '';
        stateController.text = place.administrativeArea ?? '';
        countryController.text = place.country ?? '';
        landmarkAreaController.text = place.subLocality ?? '';

        final String address = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.postalCode,
          place.country,
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        selectedAddress.value = address;
        searchController.text = address;
      }
    } catch (e) {
      selectedAddress.value = 'Address not found';
    }
  }

  bool _validateForm() {
    if (houseNoController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter House no. and floor');
      return false;
    }

    if (pincodeController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter Pincode');
      return false;
    }

    return true;
  }

  Future<void> submitDeliveryAddress() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      final String addressLine2 = [
        buildingBlockController.text.trim(),
        landmarkAreaController.text.trim(),
      ].where((element) => element.isNotEmpty).join(", ");

      final Map<String, dynamic> payload = {
        "label": selectedLabel.value,
        "addressLine1": houseNoController.text.trim(),
        "addressLine2": addressLine2,
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "country": countryController.text.trim(),
        "latitude": currentPosition.value.latitude,
        "longitude": currentPosition.value.longitude,
        "isDefault": false,
      };

      log("Address Payload: ${payload.toString()}");

      if (isEditMode.value) {
        await DeliveryAddressService.updateAddress(editAddressId.value, payload);
      } else {
        await DeliveryAddressService.createAddress(payload);
      }

      await Get.find<CommonController>().fetchProfileData();
      await Get.find<CommonController>().fetchAddresses();

      Get.back();

      SnackBars.successSnackBar(
        content: isEditMode.value ? "Address updated successfully" : "Address created successfully",
      );
    } catch (e) {
      log("Error submitting address: $e");
      SnackBars.errorSnackBar(content: "Failed to save address: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
