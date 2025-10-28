import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/services/manufacturer_address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';

class ManufacturerAddressController extends GetxController {
  HomeController homeController = Get.find();
  // Observable variables
  RxBool isLoading = false.obs;

  // Add new address
  void addAddress() {
    Get.toNamed(Routes.ADD_MANUFACTURER_ADDRESS);
  }

  // Edit address
  void editAddress(String addressId) {
    // Find the address to edit
    final address = homeController.profileData.value.data?.siteLocations
        ?.firstWhere((addr) => addr.id.toString() == addressId);

    if (address != null) {
      Get.toNamed(
        Routes.ADD_MANUFACTURER_ADDRESS,
        arguments: {
          'isEdit': true,
          'addressId': addressId,
          'addressName': address.siteName,
          'landmark': address.landmark,
          'fullAddress': address.fullAddress,
          'latitude': address.latitude,
          'longitude': address.longitude,
        },
      );
    }
  }

  // Delete address
  void deleteAddress(String addressId) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF9D0CB)),
            color: const Color(0xFFFCECE9),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              'Delete Manufacturer Address',
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this manufacturer address? This action cannot be undone.',
          style: MyTexts.medium14.copyWith(color: MyColors.gray54),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: RoundedButton(
                  onTap: () => Get.back(),
                  buttonName: 'Cancel',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: MyColors.grayCD,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: RoundedButton(
                  onTap: () => deleteManufacturerAddress(addressId),
                  buttonName: 'Delete',
                  borderRadius: 12,
                  verticalPadding: 0,
                  height: 45,
                  color: const Color(0xFFE53D26),
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> deleteManufacturerAddress(String addressId) async {
    try {
      isLoading.value = true;
      await ManufacturerAddressService.deleteManufacturerAddress(addressId);
      await homeController.fetchProfileData();
      Get.back();
    } catch (e) {
      log('Failed to delete manufacturer address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      isLoading.value = true;

      await ManufacturerAddressService.updateManufacturerAddress(addressId, {
        "is_default": true,
      });
      await homeController.fetchProfileData();
    } catch (e) {
      log('Failed to update default manufacturer address: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
