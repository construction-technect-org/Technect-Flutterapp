import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/models/delivery_address_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';

class DeliveryLocationController extends GetxController {
  // Observable variables
  RxBool isLoading = false.obs;
  Rx<DeliveryAddressModel> savedAddresses = DeliveryAddressModel().obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedAddresses();
  }

  // Load saved addresses
  Future<void> loadSavedAddresses() async {
    try {
      isLoading.value = true;
      savedAddresses.value = await DeliveryAddressService.getDeliveryAddresses();
    } catch (e) {
      log('Error fetching delivery addresses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add new address
  void addAddress() {
    Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
  }

  // Edit address
  void editAddress(String addressId) {
    // Find the address to edit
    final address = savedAddresses.value.data?.firstWhere(
      (addr) => addr.id.toString() == addressId,
    );

    if (address != null) {
      Get.toNamed(
        Routes.ADD_DELIVERY_ADDRESS,
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
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF9D0CB)),
            color: const Color(0xFFFCECE9),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              'Delete Address',
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to delete this address? This action cannot be undone.',
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
                  onTap: () => deleteDeliveryAddress(addressId),
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

  Future<void> deleteDeliveryAddress(String addressId) async {
    try {
      isLoading.value = true;
      await DeliveryAddressService.deleteDeliveryAddress(addressId);
      Get.back();
      loadSavedAddresses();
    } catch (e) {
      log('Failed to update default address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      isLoading.value = true;

      await DeliveryAddressService.updateDeliveryAddress(addressId, {"is_default": true});
      loadSavedAddresses();
    } catch (e) {
      log('Failed to update default address: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
