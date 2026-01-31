import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  // New

  HomeService homeService = HomeService();

  final isLoading = false.obs;

  Rx<CategoryModel> categoryHierarchyData = CategoryModel().obs;
  Rx<ServiceCategoryModel> categoryHierarchyDataCM = ServiceCategoryModel().obs;
  Rx<CategoryModel> categoryHierarchyData2 = CategoryModel().obs;
  RxBool isGridView = true.obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryHierarchy();
    fetchCategoryServiceHierarchy();
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
      Get.printError(info: 'Error fetching category hierarchy: $e');
    } finally {
      isLoading(false);
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
      final apiCategoryHierarchy = await homeService
          .getCategoryServiceHierarchy();
      categoryHierarchyDataCM.value = apiCategoryHierarchy;

      // Store in local storage
      myPref.setServiceCategoryHierarchyModel(apiCategoryHierarchy);
    } catch (e) {
      // Fallback to cached data if API fails
      final cachedCategoryHierarchy = myPref.getServiceCategoryHierarchyModel();
      if (cachedCategoryHierarchy != null) {
        categoryHierarchyDataCM.value = cachedCategoryHierarchy;
      }
      Get.printError(info: 'Error fetching category hierarchy: $e');
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

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
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
      Get.printError(info: 'Error fetching location: $e');
    }
  }

  void _showMandatoryLocationDialog() {
    isLocationDialogShowing.value = true;

    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
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
                  Get.printError(info: 'Error opening settings: $e');
                }
                const int maxAttempts = 6;
                const Duration interval = Duration(seconds: 1);

                for (int attempt = 0; attempt < maxAttempts; attempt++) {
                  await Future.delayed(interval);
                  final LocationPermission after =
                      await Geolocator.checkPermission();

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
                  if (!isLocationDialogShowing.value)
                    _showMandatoryLocationDialog();
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
    {
      "title": "Portfolio Management",
      "icon": Asset.portfolio,
      "available": false,
    },
    {"title": "OVP", "icon": Asset.ovp, "available": false},
    {"title": "Construction Taxi", "icon": Asset.taxi, "available": false},
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await fetchCurrentLocation();
    });
  }
}
