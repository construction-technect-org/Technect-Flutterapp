import 'dart:async';

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/models/site_location_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSiteLocation/services/site_location_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FeedBack/service/FeedBackService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/MainCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/ProductModelForCategory.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/service/AddProductService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConnectorSelectedProductController extends GetxController {
  /// Loading & Search
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isFilterApply = false.obs;
  final TextEditingController searchController = TextEditingController();
  RxInt selectedRadius = 5.obs;
  final TextEditingController radiusController = TextEditingController(
    text: "5",
  );

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

  Rx<ConnectorSelectedProductModel> productListModel =
      ConnectorSelectedProductModel(success: false, message: '').obs;

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
    searchQuery.value = value.trim();
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(productListModel.value.data?.products ?? []);
      return;
    }
    final query = searchQuery.value.toLowerCase();
    final results = (productListModel.value.data?.products ?? []).where((
      product,
    ) {
      final name = (product.categoryProductName ?? '').toLowerCase();
      final address = (product.address ?? '').toLowerCase();
      final brand = (product.brand ?? '').toLowerCase();
      final price = (product.price ?? '').toLowerCase();
      return name.contains(query) ||
          address.contains(query) ||
          brand.contains(query) ||
          price.contains(query);
    }).toList();
    filteredProducts.assignAll(results);
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
      productListModel.value = res;
      filteredProducts.clear();
      filteredProducts.value = res.data?.products ?? [];
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

  Future<void> wishListApi({required int mID, required String status}) async {
    try {
      isLoading.value = true;
      final res = await WishListServices().wishList(mID: mID, status: status);
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
        Get.bottomSheet(
          FeedbackBottomSheetView(),
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        );
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

class FeedbackBottomSheetView extends StatelessWidget {
  FeedbackBottomSheetView({super.key});

  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;

  Future<void> addFeedBack() async {
    if (rating.value == 0) {
      SnackBars.errorSnackBar(content: "Please give rate");
      return;
    } else if (suggestionController.text.isEmpty) {
      SnackBars.errorSnackBar(content: "Please add feedback/suggection");
      return;
    }
    isLoading.value = true;

    try {
      final result = await FeedbackService.addConnectorFeedback(
        text: suggestionController.text,
        rating: rating.value,
      );

      if (result != null && result.success) {
        suggestionController.text = "";
        rating.value = 0;
        Get.back();
        SnackBars.successSnackBar(content: result.message);
      } else {
        Get.snackbar("Failed", result?.message ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Padding(
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              Text(
                "REVIEW/FEEDBACK",
                style: MyTexts.bold18.copyWith(color: MyColors.primary),
              ),
              const Gap(16),
              Center(
                child: Obx(() {
                  return Text(
                    rating.value.toString(),
                    style: MyTexts.bold20.copyWith(
                      color: MyColors.primary,
                      fontSize: 24.sp,
                    ),
                  );
                }),
              ),

              Obx(
                () => Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.star,
                          color: index < rating.value
                              ? Colors.orangeAccent
                              : Colors.grey,
                          size: 32,
                        ),
                        onPressed: () {
                          rating.value = index + 1;
                        },
                      );
                    }),
                  ),
                ),
              ),

              const Gap(20),

              CommonTextField(
                controller: suggestionController,
                hintText: "Write your feedback",
                headerText: "Feedback",
                maxLine: 5,
              ),
              const Gap(24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        suggestionController.text = "";
                        rating.value = 0;
                        Get.back();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        addFeedBack();
                        // SnackBars.successSnackBar(content: "Feedback sent successfully");
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(color: MyColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
