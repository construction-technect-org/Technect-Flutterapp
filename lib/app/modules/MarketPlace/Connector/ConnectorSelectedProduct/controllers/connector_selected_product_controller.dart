import 'dart:async';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/models/site_location_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/services/site_location_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorSelectedProductController extends GetxController {
  /// Loading & Search
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isFilterApply = false.obs;
  final TextEditingController searchController = TextEditingController();
  RxInt selectedRadius = 5.obs;

  /// Page Controller
  late PageController pageController;
  RxInt currentPage = 0.obs;

  /// Map & Location
  late GoogleMapController mapController;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxDouble mapZoom = 14.0.obs;
  Rx<MapType> mapType = MapType.normal.obs;
  final markers = <String, Marker>{}.obs;

  // Site address list
  RxList<Datum> siteAddressList = <Datum>[].obs;
  RxBool isLoadingAddresses = false.obs;
  RxInt selectedSiteIndex = 0.obs;

  RxList<Product> products = <Product>[].obs;

  RxInt selectedMainCategoryIndex = (-1).obs;
  RxInt selectedSubCategoryIndex = (-1).obs;
  RxInt selectedProductIndex = (-1).obs;

  /// Services
  final ConnectorSelectedProductServices services =
      ConnectorSelectedProductServices();

  @override
  void onInit() {
    super.onInit();
    fetchMainCategories();
    getSiteAddresses();
  }

  /// MAP HANDLERS
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    currentPosition.value = position.target;
  }

  void onCameraIdle() {}

  /// SEARCH HANDLER
  Future<void> onSearchChanged(String query) async {
    if (query.isEmpty) return;
    isSearching.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSearching.value = false;
  }

  /// SITE SELECTION
  void selectSite(int index) {
    selectedSiteIndex.value = index;
  }

  void searchProduct(String value) {
    searchQuery.value = value;

    if (value.isEmpty) {
      filteredProducts.assignAll(dummyFilteredProducts);
      filteredProducts.refresh();
    } else {
      final lower = value.toLowerCase();
      final results = dummyFilteredProducts.where((product) {
        return (product.categoryProductName ?? '').toLowerCase().contains(lower) ||
            (product.address ?? '').toLowerCase().contains(lower) ||
            (product.brand ?? '').toLowerCase().contains(lower) ||
            (product.price ?? '').toLowerCase().contains(lower);
      }).toList();

      filteredProducts.assignAll(results);
    }
  }

  /// PAGE NAVIGATION
  void goToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  RxList<ConnectorCategory> categoryProducts = <ConnectorCategory>[].obs;

  /// OPTIONAL: RESET SELECTIONS
  void resetSelections() {
    selectedMainCategoryIndex.value = -1;
    selectedSubCategoryIndex.value = -1;
    selectedProductIndex.value = -1;
    subCategories.clear();
    productsList.clear();
    selectedAddress.value = Datum();
  }

  //////////////

  RxList<CategoryProduct> productsList = <CategoryProduct>[].obs;
  Rxn<String> selectedMainCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedProduct = Rxn<String>();
  Rxn<String> selectedMainCategoryId = Rxn<String>();
  Rxn<String> selectedSubCategoryId = Rxn<String>();
  Rxn<String> selectedProductId = Rxn<String>();
  RxList<String> mainCategoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> productNames = <String>[].obs;
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  Rx<Datum> selectedAddress = Datum().obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Product> dummyFilteredProducts = <Product>[].obs;

  RxString searchQuery = ''.obs;

  Future<void> getAllProducts({
    Map<String, dynamic>? filtersData,
    int? radius,
    String? latitude,
    String? longitude,
    bool? filter = false,
  }) async {
    try {
      isLoading.value = true;

      final res = await services.connectorProduct(
        mainCategoryId: selectedMainCategoryId.value ?? '',
        subCategoryId: selectedSubCategoryId.value ?? '',
        categoryProductId: selectedProductId.value ?? '',
        filters: filtersData ?? {},
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      if (filter == true) {
        isFilterApply.value = true;
      } else {
        isFilterApply.value = false;
      }
      filteredProducts.clear();
      dummyFilteredProducts.clear();
      filteredProducts.value = res.data?.products ?? [];
      dummyFilteredProducts.value = res.data?.products ?? [];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> notifyMeApi({int? mID}) async {
    try {
      isLoading.value = true;
      final res = await services.notifyMe(mID: mID);
      if (res.success == true) {
        await getAllProducts(
          radius: selectedRadius.value,
          longitude: selectedAddress.value.longitude,
          latitude: selectedAddress.value.latitude,
        );
        SnackBars.successSnackBar(content: res.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToConnectApi({int? mID, int? pID, String? message}) async {
    try {
      isLoading.value = true;
      final res = await services.addToConnect(
        mID: mID,
        message: message,
        pID: pID,
      );
      if (res.success == true) {
        await getAllProducts(
          radius: selectedRadius.value,
          longitude: selectedAddress.value.longitude,
          latitude: selectedAddress.value.latitude,
        );
        SnackBars.successSnackBar(content: res.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMainCategories() async {
    try {
      isLoading(true);
      final result = await AddProductService().mainCategory();
      if ((result.success) == true) {
        mainCategories.value = result.data ?? [];
        mainCategoryNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
      } else {
        mainCategories.clear();
        mainCategoryNames.clear();
      }
    } catch (e) {
      mainCategories.clear();
      mainCategoryNames.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubCategories(int mainCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().subCategory(mainCategoryId);
      if ((result.success) == true) {
        subCategories.value = result.data ?? [];
        subCategoryNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
      } else {
        subCategories.clear();
        subCategoryNames.clear();
      }

      selectedSubCategory.value = null;
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } catch (e) {
      subCategories.clear();
      subCategoryNames.clear();
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProducts(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().productsBySubCategory(
        subCategoryId,
      );

      if ((result.success) == true) {
        productsList.value = result.data ?? [];
        productNames.value =
            result.data
                ?.map((e) => e.name)
                .where((name) => name != null)
                .cast<String>()
                .toList() ??
            [];
        selectedProduct.value = null;
      } else {
        productsList.clear();
        productNames.clear();
        selectedProduct.value = null;
      }
    } catch (e) {
      productsList.clear();
      productNames.clear();
      selectedProduct.value = null;
    } finally {
      isLoading(false);
    }
  }

  RxList<FilterData> filters = <FilterData>[].obs;

  Future<void> getFilter(String subCategoryId) async {
    try {
      isLoading(true);
      final result = await AddProductService().getFilter(
        int.parse(subCategoryId),
      );

      if (result.success == true) {
        filters.value = (result.data as List<FilterData>)
            .map((e) => e)
            .toList();
        // for (final FilterData filter in filters) {
        //   if (filter.filterType == 'dropdown') {
        //     dropdownValues[filter.filterName ?? ''] = Rxn<String>();
        //   }
        //   else if (filter.filterType == 'dropdown_multiple') {
        //     multiDropdownValues[filter.filterName ?? ''] = <String>[].obs;
        //   }
        //   else {
        //     dynamicControllers[filter.filterName ?? ''] =
        //         TextEditingController();
        //   }
        // }
        //
        // if (isEdit &&
        //     _storedFilterValues != null &&
        //     _storedFilterValues!.isNotEmpty) {
        //   _populateFilterControllers();
        // }
      } else {
        filters.clear();
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      filters.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSiteAddresses() async {
    try {
      isLoadingAddresses.value = true;
      final response = await SiteLocationService.getSiteLocations();
      if (response.success == true && response.data != null) {
        siteAddressList.value = response.data!;
      }
    } catch (e) {
      // Handle error silently
    } finally {
      isLoadingAddresses.value = false;
    }
  }

  Future<void> deleteSiteAddress(int siteId) async {
    try {
      isLoading.value = true;
      final response = await SiteLocationService.deleteSiteLocation(
        siteId.toString(),
      );
      if (response.success == true) {
        await getSiteAddresses();
        siteAddressList.removeWhere((address) => address.id == siteId);
        selectedAddress.value = Datum();
        SnackBars.successSnackBar(content: 'Site address deleted successfully');
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error deleting site address');
    } finally {
      isLoading.value = false;
    }
  }
}
