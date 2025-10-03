import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/models/SavedAddressesModel.dart';
import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/services/address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:geocoding/geocoding.dart';

class AddLocationController extends GetxController {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  final isLoading = false.obs;
  final locationAdded = false.obs;
  final isEditing = false.obs;
  final isFromLogin = false.obs;
  int? existingAddressId;

  RxInt selectedIndex = 0.obs; // 0=Office, 1=Factory
  RxBool copyToOtherType = false.obs;
  RxBool showAddLocationOption = true.obs;
  final AddressService _addressService = AddressService();

  RxList<SavedAddresses> addresses = <SavedAddresses>[].obs;
  RxString from = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isFromLogin.value = Get.arguments['isFromLogin'] ?? false;
    }

    if (Get.arguments != null) {
      from.value = Get.arguments["from"] ?? "";
      if (from.value == "Home") {
        isEditing.value = true;
        if (Get.arguments["isCLocation"] != null) {
          if (Get.arguments["isOffice"] != null) {
            selectedIndex.value = Get.arguments["isOffice"];
          }
          existingAddressId = Get.arguments['id'];
          final Placemark place2 = Get.arguments["isCLocation"];
          addressLine1Controller.text = place2.name ?? "";
          addressLine2Controller.text = place2.street ?? "";
          cityController.text = place2.locality ?? "";
          landmarkController.text = place2.subAdministrativeArea ?? "";
          stateController.text = place2.administrativeArea ?? "";
          pinCodeController.text = place2.postalCode ?? "";
        }
      } else {
        if (Get.arguments["isCLocation"] != null) {
          final Placemark place2 = Get.arguments["isCLocation"];
          addressLine1Controller.text = place2.name ?? "";
          addressLine2Controller.text = place2.street ?? "";
          cityController.text = place2.locality ?? "";
          landmarkController.text = place2.subAdministrativeArea ?? "";
          stateController.text = place2.administrativeArea ?? "";
          pinCodeController.text = place2.postalCode ?? "";
        }
      }
    }
    // _handlePassedData();
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

  // void _handlePassedData() {
  //   final arguments = Get.arguments;
  //   if (arguments != null && arguments is Map<String, dynamic>) {
  //     if (arguments.containsKey('id')) {
  //       isEditing.value = true;
  //       existingAddressId = arguments['id'];
  //       _prefillForm(arguments);
  //       if (arguments['addressType']?.toLowerCase() == "office") {
  //         selectedIndex.value = 0;
  //       } else if (arguments['addressType']?.toLowerCase() == "factory") {
  //         selectedIndex.value = 1;
  //       }
  //     } else if (arguments.containsKey('address_line1')) {
  //       _prefillForm(arguments);
  //     } else if (arguments.containsKey('latitude') &&
  //         arguments.containsKey('longitude')) {
  //       _prefillFromLocation(arguments);
  //     }
  //   }
  // }

  // void _prefillForm(Map<String, dynamic> addressData) {
  //   addressLine1Controller.text = addressData['address_line1'] ?? '';
  //   addressLine2Controller.text = addressData['address_line2'] ?? '';
  //   landmarkController.text = addressData['landmark'] ?? '';
  //   cityController.text = addressData['city'] ?? '';
  //   stateController.text = addressData['state'] ?? '';
  //   pinCodeController.text = addressData['pin_code'] ?? '';
  // }
  //
  // void _prefillFromLocation(Map<String, dynamic> locationData) {
  //   if (locationData.containsKey('address_line1')) {
  //     _prefillForm(locationData);
  //   }
  // }

  Future<void> _fetchAndStoreAddressData() async {
    try {
      final homeService = HomeService();
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true) {
        myPref.setAddressData(addressResponse.toJson());
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

      if (isEditing.value) {
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
            isDefault: false,
          );
        }
        myPref.setDefaultAdd(true);
      }

      if (response['success'] == true) {
        await _fetchAndStoreAddressData();
        if (from.value == "register") {
          locationAdded.value = true;
          Get.offAllNamed(Routes.DASHBOARD);
        } else if (from.value == "Home") {
          final addressResponse = await HomeService().getAddress();
          if (addressResponse.success == true &&
              (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
            Get.find<HomeController>().hasAddress.value = true;
            Get.find<HomeController>().addressData = addressResponse;
            myPref.setAddressData(addressResponse.toJson());
            Get.back();
            SnackBars.successSnackBar(
              content: response['message'] ?? 'Address edited successfully',
            );
          }
        }
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
  //
  // Future<void> fetchAddresses() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await _addressService.getAddress();
  //     addresses.value = response.data.addresses;
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to load addresses: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
