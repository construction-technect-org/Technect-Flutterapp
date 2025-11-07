import 'dart:async';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/SearchProduct/services/search_product_services.dart';

class SearchProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
  RxBool hasSearched = false.obs;

  Rx<ConnectorSelectedProductModel?> productListModel =
      Rx<ConnectorSelectedProductModel?>(null);

  Timer? _debounceTimer;
  final TextEditingController searchController = TextEditingController();

  void onSearchChanged(String query) {
    final trimmed = query.trim();
    searchQuery.value = trimmed;

    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      hasSearched.value = false;
      productListModel.value = null;
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      performSearch(trimmed);
    });
  }

  Future<void> performSearch(String query, {bool? isLoad}) async {
    try {
      hasSearched.value = true;
      isLoading.value = isLoad ?? false;
      productListModel.value = await SearchProductServices().searchProducts(
        query: query,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to search products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    searchController.clear();
    searchQuery.value = '';
    hasSearched.value = false;
    productListModel.value = null;
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
