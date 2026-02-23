import "dart:developer";

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/dynamic_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_projects.model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/module_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/subcategory_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  // New

  HomeService homeService = HomeService();

  final HomeService _homeService = Get.find<HomeService>();

  final isLoading = false.obs;

  Rx<CategoryModel> categoryHierarchyData = CategoryModel().obs;
  Rx<ServiceCategoryModel> categoryHierarchyDataCM = ServiceCategoryModel().obs;
  Rx<CategoryModel> categoryHierarchyData2 = CategoryModel().obs;
  RxBool isGridView = true.obs;
  RxInt selectedIndex = 0.obs;
  RxList<Modules?> modules = <Modules?>[].obs;
  Rx<ProjectResponse> projectResponseData = ProjectResponse().obs;
  Rx<FullSubCategoryModel> subCategoryData = FullSubCategoryModel().obs;
  Rx<CategoryProductModel> categoryProductData = CategoryProductModel().obs;
  Rx<DynamicFilterModel> dynamicFilterData = DynamicFilterModel().obs;

  RxString selectedSort = "Newest First".obs;
  RxDouble selectedRadius = 50.0.obs; // Default 50km
  RxList<String> activeFilters = <String>[].obs;

  RxString selectedCategoryId = "".obs;
  RxString selectedSubCategoryId = "".obs;
  RxString selectedCategoryName = "".obs;
  RxString selectedSubCategoryName = "".obs;

  final ApiManager _apiManager = ApiManager();

  @override
  void onInit() {
    super.onInit();
    if (myPref.getToken().isNotEmpty) {
      fetchSideBarList();
      // fetchCategoryHierarchy();
      // fetchCategoryServiceHierarchy();
      fetchRightSideList();
      // Test Marketplace APIs
      // testMarketplaceAPIs();
    }
  }

  Future<void> fetchSideBarList() async {
    try {
      isLoading(true);
      final response = await _homeService.getAllModules(mFor: "merchant");
      if (response.success == true) {
        if (response.data?.modules != null) {
          modules.addAll(response.data!.modules!);
          log("Modules $modules");
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRightSideList() async {
    try {
      isLoading(true);
      final response = await _homeService.getMerchantProjects();
      if (response.success == true) {
        projectResponseData.value = response;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadSubCategories({required String categoryId, String? categoryName}) async {
    try {
      isLoading(true);
      selectedCategoryId.value = categoryId;
      if (categoryName != null) selectedCategoryName.value = categoryName;

      final response = await _homeService.getSubCategories(catID: categoryId);
      if (response.success == true) {
        subCategoryData.value = response;
        // Automatically load products for the first sub-category if available
        if ((response.data ?? []).isNotEmpty) {
          loadCategoryProducts(
            subCategoryId: response.data!.first.id ?? "",
            subCategoryName: response.data!.first.name,
          );
        } else {
          categoryProductData.value = CategoryProductModel(success: true, data: []);
        }
      }
    } catch (e) {
      log("Error loading sub-categories: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadCategoryProducts({
    required String subCategoryId,
    String? subCategoryName,
  }) async {
    try {
      isLoading(true);
      selectedSubCategoryId.value = subCategoryId;
      if (subCategoryName != null) selectedSubCategoryName.value = subCategoryName;

      final response = await _homeService.getCategoriesProduct(
        subCatID: subCategoryId,
        sort: selectedSort.value,
        radius: selectedRadius.value,
      );
      if (response.success == true) {
        categoryProductData.value = response;
      }
    } catch (e) {
      log("Error loading category products: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateSort(String sort) async {
    selectedSort.value = sort;
    await loadCategoryProducts(subCategoryId: selectedSubCategoryId.value);
  }

  Future<void> updateRadius(double radius) async {
    selectedRadius.value = radius;
    await loadCategoryProducts(subCategoryId: selectedSubCategoryId.value);
  }

  Future<void> loadDynamicFilters({required String categoryProductId}) async {
    try {
      isLoading(true);
      final response = await _homeService.getDynamicFilters(categoryProductId: categoryProductId);
      if (response.success == true) {
        dynamicFilterData.value = response;
      }
    } catch (e) {
      log("Error loading dynamic filters: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategoryHierarchy() async {
    try {
      isLoading(true);
      // Load cached data first
      final cachedCategoryHierarchy = myPref.getCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyData.value = cachedCategoryHierarchy;
      }

      // Fetch fresh data from API
      final apiCategoryHierarchy = await homeService.getCategoryHierarchy();
      categoryHierarchyData.value = apiCategoryHierarchy;

      // Store in local storage
      myPref.setCategoryHierarchyModel(apiCategoryHierarchy);
    } catch (e) {
      // Fallback to cached data if API fails
      final cachedCategoryHierarchy = myPref.getCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyData.value = cachedCategoryHierarchy;
      }
      log('Error fetching category hierarchy: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> requestConnection({required String targetProfileId}) async {
    try {
      isLoading.value = true;

      final body = {"targetProfileId": targetProfileId};

      final response = await _apiManager.postObject(
        url: APIConstants.connectionRequest,
        body: body,
      );

      /// Directly check success from response map
      if (response["success"] == true) {
        Get.snackbar(
          "Success",
          response["message"] ?? "Connection request sent successfully",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Error",
          response["message"] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryServiceHierarchy() async {
    try {
      isLoading(true);
      // Load cached data first
      final cachedCategoryHierarchy = myPref.getServiceCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyDataCM.value = cachedCategoryHierarchy;
      }

      // Fetch fresh data from API
      final apiCategoryHierarchy = await homeService.getCategoryServiceHierarchy();
      categoryHierarchyDataCM.value = apiCategoryHierarchy;

      // Store in local storage
      myPref.setServiceCategoryHierarchyModel(apiCategoryHierarchy);
    } catch (e) {
      // Fallback to cached data if API fails
      final cachedCategoryHierarchy = myPref.getServiceCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyDataCM.value = cachedCategoryHierarchy;
      }
      log('Error fetching category hierarchy: $e');
    } finally {
      isLoading(false);
    }
  }

  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;
  final RxBool isLocationDialogShowing = false.obs;

  Future<void> fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        if (!isLocationDialogShowing.value) {
          _showMandatoryLocationDialog();
        }
        return;
      }

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        final Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );

        currentLatitude.value = position.latitude;
        currentLongitude.value = position.longitude;
        return;
      }

      if (permission == LocationPermission.unableToDetermine ||
          permission == LocationPermission.denied) {
        _showMandatoryLocationDialog();
      }
    } catch (e) {
      log('Error fetching location: $e');
    }
  }

  void _showMandatoryLocationDialog() {
    isLocationDialogShowing.value = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF9D0CB)),
              color: const Color(0xFFFCECE9),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: Text(
                'Enable Location',
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          content: Text(
            'Location permission is required to continue. Please enable location access in settings.',
            style: MyTexts.medium14.copyWith(color: MyColors.gray54),
            textAlign: TextAlign.center,
          ),
          actions: [
            RoundedButton(
              onTap: () async {
                try {
                  final openedApp = await Geolocator.openAppSettings();
                  if (!openedApp) {
                    await Geolocator.openLocationSettings();
                  }
                } catch (e) {
                  log('Error opening settings: $e');
                }
                const int maxAttempts = 6;
                const Duration interval = Duration(seconds: 1);

                for (int attempt = 0; attempt < maxAttempts; attempt++) {
                  await Future.delayed(interval);
                  final LocationPermission after = await Geolocator.checkPermission();

                  if (after == LocationPermission.always ||
                      after == LocationPermission.whileInUse) {
                    if (Get.isDialogOpen ?? false) Get.back();
                    isLocationDialogShowing.value = false;
                    await fetchCurrentLocation();
                    return;
                  }

                  if (after == LocationPermission.denied) {
                    final requested = await Geolocator.requestPermission();
                    if (requested == LocationPermission.always ||
                        requested == LocationPermission.whileInUse) {
                      if (Get.isDialogOpen ?? false) Get.back();
                      isLocationDialogShowing.value = false;
                      await fetchCurrentLocation();
                      return;
                    }
                  }
                }
                if (Get.isDialogOpen ?? false) Get.back();
                isLocationDialogShowing.value = false;
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (!isLocationDialogShowing.value) _showMandatoryLocationDialog();
                });
              },
              buttonName: 'Continue',
              borderRadius: 12,
              verticalPadding: 0,
              height: 45,
              color: const Color(0xFFE53D26),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    ).then((_) {
      isLocationDialogShowing.value = false;
    });
  }

  final features = [
    {"title": "Marketplace", "icon": Asset.role1, "available": true},
    {"title": "CRM", "icon": Asset.crm, "available": false},
    {"title": "ERP", "icon": Asset.erp, "available": false},
    {"title": "Project Management", "icon": Asset.project, "available": false},
    {"title": "HRMS", "icon": Asset.hrms, "available": false},
    {"title": "Portfolio Management", "icon": Asset.portfolio, "available": false},
    {"title": "OVP", "icon": Asset.ovp, "available": false},
    {"title": "Construction Taxi", "icon": Asset.taxi, "available": false},
  ];

  Future<void> testMarketplaceAPIs() async {
    try {
      log("Testing Marketplace APIs...");

      // 1. Get Sub-categories (Sample Category ID)
      const String sampleCategoryId = "a202a36e-2e39-4843-90b3-59c47afc9074";
      final subCats = await homeService.getSubCategories(catID: sampleCategoryId);
      log("Sub-categories Success: ${subCats.success}, Count: ${subCats.data?.length}");

      if ((subCats.data ?? []).isNotEmpty) {
        // 2. Get Category Products (Sample Sub-category ID from first result)
        final String sampleSubCategoryId = subCats.data!.first.id!;
        final catProds = await homeService.getCategoriesProduct(subCatID: sampleSubCategoryId);
        log("Category Products Success: ${catProds.success}, Count: ${catProds.data?.length}");

        if ((catProds.data ?? []).isNotEmpty) {
          // 3. Get Dynamic Filters (Sample Category Product ID from first result)
          final String sampleCatProductId = catProds.data!.first.id!;
          final filters = await homeService.getDynamicFilters(
            categoryProductId: sampleCatProductId,
          );
          log("Dynamic Filters Success: ${filters.success}, Count: ${filters.data?.length}");
        }
      }
    } catch (e) {
      log("Error testing Marketplace APIs: $e");
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchCurrentLocation();
    });
  }

  void showSortBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sort By", style: MyTexts.bold18),
            const Gap(20),
            ...["Newest First", "Price: Low to High", "Price: High to Low"].map((sort) {
              return Obx(
                () => ListTile(
                  title: Text(sort, style: MyTexts.medium14),
                  trailing: selectedSort.value == sort
                      ? const Icon(Icons.check, color: MyColors.primary)
                      : null,
                  onTap: () {
                    updateSort(sort);
                    Get.back();
                  },
                ),
              );
            }),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  void showRadiusBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search Radius", style: MyTexts.bold18),
            const Gap(20),
            Obx(
              () => Column(
                children: [
                  Slider(
                    value: selectedRadius.value,
                    min: 5,
                    max: 500,
                    divisions: 99,
                    label: "${selectedRadius.value.round()} km",
                    activeColor: MyColors.primary,
                    onChanged: (val) => selectedRadius.value = val,
                    onChangeEnd: (val) => updateRadius(val),
                  ),
                  Text("${selectedRadius.value.round()} km", style: MyTexts.medium16),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filters", style: MyTexts.bold18),
            const Gap(20),
            const Center(child: Text("Dynamic filters will appear here based on category")),
            const Gap(40),
            RoundedButton(buttonName: "Apply Filters", onTap: () => Get.back()),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
