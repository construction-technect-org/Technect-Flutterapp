import 'package:construction_technect/app/core/widgets/error_sheet.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/connector_product_detail_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/services/connector_home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailController extends GetxController {
  final ConnectorHomeService connectorHomeService = Get.put(ConnectorHomeService());

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<ConnectorProductDetail?> productDetails = Rx<ConnectorProductDetail?>(null);

  final RxString connectionStatus = 'Connect'.obs; // Can be 'Connect', 'Requested', 'Connected'
  final RxBool isConnecting = false.obs;

  late String inventoryId;
  late GetStorage _storage;

  @override
  void onInit() {
    super.onInit();

    // Attempt to get inventoryId from arguments
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic> && args.containsKey('inventoryId')) {
      inventoryId = args['inventoryId'];
      _storage = GetStorage();
      _checkLocalConnectionStatus();
      fetchProductDetails();
    } else {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = "Product ID not provided.";
    }
  }

  Future<void> fetchProductDetails() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final response = await connectorHomeService.getInventoryDetails(inventoryId);
      productDetails.value = response;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "An error occurred while fetching details.\n$e";
    } finally {
      isLoading.value = false;
    }
  }

  void _checkLocalConnectionStatus() {
    // Check if we have previously requested connection for this inventory item's merchant
    // Note: If merchantId isn't loaded yet, this gets double checked after fetch
    String? status = _storage.read('connection_status_$inventoryId');
    if (status != null) {
      connectionStatus.value = status;
    }
  }

  void _saveConnectionStatus(String status) {
    connectionStatus.value = status;
    _storage.write('connection_status_$inventoryId', status);
  }

  void showConnectConfirmationDialog() {
    final merchantId = productDetails.value?.merchantProfileId;
    if (merchantId == null) {
      Get.snackbar("Error", "Merchant information not found.");
      return;
    }

    if (connectionStatus.value == 'Requested') {
      Get.snackbar("Info", "Connection request already pending.");
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text("Request Connection"),
        content: const Text("Are you sure you want to connect with this supplier?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B2F62),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Get.back();
              _requestConnection(merchantId);
            },
            child: const Text("Yes, Connect", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _requestConnection(String merchantId) async {
    isConnecting.value = true;
    try {
      final response = await connectorHomeService.requestConnection(merchantId);

      if (response['success'] == true) {
        _saveConnectionStatus('Requested');
        Get.snackbar(
          "Success",
          "Connection request sent successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
        );
      } else {
        final msg = response['message'] ?? "Failed to request connection";
        if (msg.toString().toLowerCase().contains("already pending") ||
            msg.toString().toLowerCase().contains("requested")) {
          _saveConnectionStatus('Requested');
        }
        showErrorSheet(msg);
      }
    } catch (e) {
      final errorMsg = e.toString();
      if (errorMsg.toLowerCase().contains("already pending") ||
          errorMsg.toLowerCase().contains("already requested")) {
        _saveConnectionStatus('Requested');
        Get.snackbar("Info", "Connection request already pending.");
      } else {
        showErrorSheet("Failed to send connection request. Please try again.");
      }
    } finally {
      isConnecting.value = false;
    }
  }
}
