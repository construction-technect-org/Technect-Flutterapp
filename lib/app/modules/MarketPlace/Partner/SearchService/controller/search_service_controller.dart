import 'dart:async';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/models/ConnectorServiceModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/SearchService/services/search_product_services.dart';

class SearchServiceController extends GetxController {
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
  RxBool hasSearched = false.obs;

  Rx<ConnectorServiceModel?> serviceListModel = Rx<ConnectorServiceModel?>(
    null,
  );

  Timer? _debounceTimer;
  final TextEditingController searchController = TextEditingController();

  void onSearchChanged(String query) {
    final trimmed = query.trim();
    searchQuery.value = trimmed;

    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      hasSearched.value = false;
      serviceListModel.value = null;
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
      serviceListModel.value = await SearchServiceServices().searchServices(
        query: query,
      );
    } catch (e) {
      // No Error Show
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    searchController.clear();
    searchQuery.value = '';
    hasSearched.value = false;
    serviceListModel.value = null;
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
