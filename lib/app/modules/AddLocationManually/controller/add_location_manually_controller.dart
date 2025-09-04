import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddLocationManually/services/address_service.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class AddLocationController extends GetxController {
  // Form controllers
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // State variables
  final isLoading = false.obs;
  final locationAdded = false.obs;
  final isEditing = false.obs;
  int? existingAddressId;

  // Service
  final AddressService _addressService = AddressService();
  HomeController homeController = Get.find<HomeController>();
  @override
  void onInit() {
    super.onInit();
    _handlePassedData();
  }

  void _handlePassedData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      // Check if it's existing address data
      if (arguments.containsKey('id')) {
        isEditing.value = true;
        existingAddressId = arguments['id'];
        _prefillForm(arguments);
      } else if (arguments.containsKey('address_line1')) {
        // It's address data from address screen (with or without coordinates)
        _prefillForm(arguments);
      } else if (arguments.containsKey('latitude') &&
          arguments.containsKey('longitude')) {
        // It's location data from address screen
        _prefillFromLocation(arguments);
      }
    }
  }

  void _prefillForm(Map<String, dynamic> addressData) {
    addressLine1Controller.text = addressData['address_line1'] ?? '';
    addressLine2Controller.text = addressData['address_line2'] ?? '';
    landmarkController.text = addressData['landmark'] ?? '';
    cityController.text = addressData['city'] ?? '';
    stateController.text = addressData['state'] ?? '';
    pinCodeController.text = addressData['pin_code'] ?? '';
  }

  void _prefillFromLocation(Map<String, dynamic> locationData) {
    // Check if we have address data to prefill
    if (locationData.containsKey('address_line1')) {
      _prefillForm(locationData);
    }
    // Coordinates are handled in the submit method
  }

  // Fetch and store address data after successful save
  Future<void> _fetchAndStoreAddressData() async {
    try {
      // Import the home service to call get address API
      final homeService = HomeService();
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true) {
        // Store the updated address data in local storage
        myPref.setAddressData(addressResponse.toJson());
        Get.printInfo(
          info: '💾 Manual Address: Fetched and cached updated address data',
        );
      }
    } catch (e) {
      Get.printError(info: 'Error fetching address data: $e');
    }
  }

  @override
  void onClose() {
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    super.onClose();
  }

  // Submit location
  Future<void> submitLocation() async {
    // Validation
    if (addressLine1Controller.text.trim().isEmpty ||
        landmarkController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        pinCodeController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please fill all required fields');
      return;
    }

    // Validate pin code (should be 6 digits)
    if (pinCodeController.text.trim().length != 6) {
      SnackBars.errorSnackBar(content: 'Please enter a valid 6-digit pin code');
      return;
    }

    isLoading.value = true;

    try {
      final arguments = Get.arguments;
      double? latitude;
      double? longitude;
      if (arguments != null && arguments is Map<String, dynamic>) {
        latitude = arguments['latitude']?.toDouble();
        longitude = arguments['longitude']?.toDouble();
      }

      Map<String, dynamic> response;

      if (isEditing.value && existingAddressId != null) {
        // Update existing address
        response = await _addressService.updateAddress(
          addressId: existingAddressId!,
          addressLine1: addressLine1Controller.text.trim(),
          addressLine2: addressLine2Controller.text.trim(),
          landmark: landmarkController.text.trim(),
          city: cityController.text.trim(),
          state: stateController.text.trim(),
          pinCode: pinCodeController.text.trim(),
          latitude: latitude,
          longitude: longitude,
        );
      } else {
        // Create new address
        response = await _addressService.addAddressManually(
          addressLine1: addressLine1Controller.text.trim(),
          addressLine2: addressLine2Controller.text.trim(),
          landmark: landmarkController.text.trim(),
          city: cityController.text.trim(),
          state: stateController.text.trim(),
          pinCode: pinCodeController.text.trim(),
          latitude: latitude,
          longitude: longitude,
        );
      }

      if (response['success'] == true) {
        locationAdded.value = true;

        // Call get address API to fetch updated address data
        await _fetchAndStoreAddressData();

        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.MAIN);
      } else {
        locationAdded.value = false;
        SnackBars.errorSnackBar(
          content: response['message'] ?? 'Failed to save address',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error saving address: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
