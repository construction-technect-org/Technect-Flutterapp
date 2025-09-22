import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddLocationManually/models/SavedAddressesModel.dart';
import 'package:construction_technect/app/modules/AddLocationManually/services/address_service.dart';
import 'package:construction_technect/app/modules/Address/controller/address_controller.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class AddLocationController extends GetxController {
  // Form controllers
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // State
  final isLoading = false.obs;
  final locationAdded = false.obs;
  final isEditing = false.obs;
  final isFromLogin = false.obs;
  int? existingAddressId;

  RxInt selectedIndex = 0.obs; // 0=Office, 1=Factory
  RxBool copyToOtherType = false.obs;
  RxBool showAddLocationOption = true.obs;

  // Service
  final AddressService _addressService = AddressService();

  RxList<SavedAddresses> addresses = <SavedAddresses>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isFromLogin.value = Get.arguments['isFromLogin'] ?? false;
      addressLine1Controller.text=Get.find<AddressController>().place.value?.name??"";
      addressLine2Controller.text=Get.find<AddressController>().place.value?.street??"";
      cityController.text=Get.find<AddressController>().place.value?.locality??"";
      landmarkController.text=Get.find<AddressController>().place.value?.subAdministrativeArea??"";
      stateController.text=Get.find<AddressController>().place.value?.administrativeArea??"";
      pinCodeController.text=Get.find<AddressController>().place.value?.postalCode??"";
    }

    _handlePassedData();
    fetchAddresses();
  }

  // void _handlePassedData() {
  //   final arguments = Get.arguments;
  //   if (arguments != null && arguments is Map<String, dynamic>) {
  //     if (arguments.containsKey('id')) {
  //       isEditing.value = true;
  //       existingAddressId = arguments['id'];
  //       _prefillForm(arguments);
  //     } else if (arguments.containsKey('address_line1')) {
  //       _prefillForm(arguments);
  //     } else if (arguments.containsKey('latitude') &&
  //         arguments.containsKey('longitude')) {
  //       _prefillFromLocation(arguments);
  //     }
  //   }
  // }
  //

  void _handlePassedData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('id')) {
        isEditing.value = true;
        existingAddressId = arguments['id'];

        // pre-fill form
        _prefillForm(arguments);

        // set type (office / factory)
        if (arguments['addressType']?.toLowerCase() == "office") {
          selectedIndex.value = 0;
        } else if (arguments['addressType']?.toLowerCase() == "factory") {
          selectedIndex.value = 1;
        }
      } else if (arguments.containsKey('address_line1')) {
        _prefillForm(arguments);
      } else if (arguments.containsKey('latitude') &&
          arguments.containsKey('longitude')) {
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
    if (locationData.containsKey('address_line1')) {
      _prefillForm(locationData);
    }
  }

  Future<void> _fetchAndStoreAddressData() async {
    try {
      final homeService = HomeService();
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true) {
        myPref.setAddressData(addressResponse.toJson());
        Get.printInfo(info: '💾 Manual Address: Updated address data cached');
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

  Future<void> submitLocation() async {
    if (addressLine1Controller.text.trim().isEmpty ||
        landmarkController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        pinCodeController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please fill all required fields');
      return;
    }

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

      final addressType = selectedIndex.value == 0 ? "office" : "factory";
      final otherType = addressType == "office" ? "factory" : "office";

      if (isEditing.value && existingAddressId != null) {
        // Update only selected one
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
          addressType: addressType,
        );
      } else {
        // Always add selected one
        response = await _addressService.addAddressManually(
          addressLine1: addressLine1Controller.text.trim(),
          addressLine2: addressLine2Controller.text.trim(),
          landmark: landmarkController.text.trim(),
          city: cityController.text.trim(),
          state: stateController.text.trim(),
          pinCode: pinCodeController.text.trim(),
          latitude: latitude,
          longitude: longitude,
          addressType: addressType,
        );

        //  Always add the other type as well (compulsory both)
        if (response['success'] == true) {
          await _addressService.addAddressManually(
            addressLine1: addressLine1Controller.text.trim(),
            addressLine2: addressLine2Controller.text.trim(),
            landmark: landmarkController.text.trim(),
            city: cityController.text.trim(),
            state: stateController.text.trim(),
            pinCode: pinCodeController.text.trim(),
            latitude: latitude,
            longitude: longitude,
            addressType: otherType,
          );
        }
      }

      if (response['success'] == true) {
        locationAdded.value = true;
        await _fetchAndStoreAddressData();
        await Future.delayed(const Duration(seconds: 2));

        Get.offAllNamed(Routes.DASHBOARD);
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

  // Future<void> submitLocation() async {
  //   if (addressLine1Controller.text.trim().isEmpty ||
  //       landmarkController.text.trim().isEmpty ||
  //       cityController.text.trim().isEmpty ||
  //       stateController.text.trim().isEmpty ||
  //       pinCodeController.text.trim().isEmpty) {
  //     SnackBars.errorSnackBar(content: 'Please fill all required fields');
  //     return;
  //   }

  //   if (pinCodeController.text.trim().length != 6) {
  //     SnackBars.errorSnackBar(content: 'Please enter a valid 6-digit pin code');
  //     return;
  //   }

  //   isLoading.value = true;

  //   try {
  //     final arguments = Get.arguments;
  //     double? latitude;
  //     double? longitude;
  //     if (arguments != null && arguments is Map<String, dynamic>) {
  //       latitude = arguments['latitude']?.toDouble();
  //       longitude = arguments['longitude']?.toDouble();
  //     }

  //     Map<String, dynamic> response;

  //     final addressType = selectedIndex.value == 0 ? "office" : "factory";

  //     if (isEditing.value && existingAddressId != null) {
  //       response = await _addressService.updateAddress(
  //         addressId: existingAddressId!,
  //         addressLine1: addressLine1Controller.text.trim(),
  //         addressLine2: addressLine2Controller.text.trim(),
  //         landmark: landmarkController.text.trim(),
  //         city: cityController.text.trim(),
  //         state: stateController.text.trim(),
  //         pinCode: pinCodeController.text.trim(),
  //         latitude: latitude,
  //         longitude: longitude,
  //         addressType: addressType,
  //       );
  //     } else {
  //       response = await _addressService.addAddressManually(
  //         addressLine1: addressLine1Controller.text.trim(),
  //         addressLine2: addressLine2Controller.text.trim(),
  //         landmark: landmarkController.text.trim(),
  //         city: cityController.text.trim(),
  //         state: stateController.text.trim(),
  //         pinCode: pinCodeController.text.trim(),
  //         latitude: latitude,
  //         longitude: longitude,
  //         addressType: addressType,
  //       );

  //       if (copyToOtherType.value) {
  //         final otherType = addressType == "office" ? "factory" : "office";
  //         await _addressService.addAddressManually(
  //           addressLine1: addressLine1Controller.text.trim(),
  //           addressLine2: addressLine2Controller.text.trim(),
  //           landmark: landmarkController.text.trim(),
  //           city: cityController.text.trim(),
  //           state: stateController.text.trim(),
  //           pinCode: pinCodeController.text.trim(),
  //           latitude: latitude,
  //           longitude: longitude,
  //           addressType: otherType,
  //         );
  //       }
  //     }

  //     if (response['success'] == true) {
  //       locationAdded.value = true;
  //       await _fetchAndStoreAddressData();
  //       await Future.delayed(const Duration(seconds: 2));

  //        Get.offAllNamed(Routes.MAIN);
  //     } else {
  //       locationAdded.value = false;
  //       SnackBars.errorSnackBar(content: response['message'] ?? 'Failed to save address');
  //     }
  //   } catch (e) {
  //     SnackBars.errorSnackBar(content: 'Error saving address: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final response = await _addressService.getProfile();
      addresses.value = response.data.addresses;
    } catch (e) {
      Get.snackbar("Error", "Failed to load addresses: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
