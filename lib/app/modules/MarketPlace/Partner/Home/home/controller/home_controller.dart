import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/services/ConstructionLineServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  // New
  RxBool isMarketPlace = true.obs;
  RxInt marketPlace = 0.obs;

  CommonController commonController = Get.find();

  final RxInt selectedIndex = 0.obs;

  HomeService homeService = HomeService();
  GetAllRoleService roleService = GetAllRoleService();

  final isLoading = false.obs;
  final hasAddress = false.obs;

  Rx<ProfileModel> profileData = ProfileModel().obs;

  // AddressModel addressData = AddressModel();
  RxList<TeamListData> teamList = <TeamListData>[].obs;
  Rx<CategoryModel> categoryHierarchyData = CategoryModel().obs;
  Rx<ServiceCategoryModel> categoryHierarchyDataCM = ServiceCategoryModel().obs;
  Rx<CategoryModel> categoryHierarchyData2 = CategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryHierarchy();
    fetchCategoryServiceHierarchy();
    _initializeHomeData();
  }

  Future<void> _initializeHomeData() async {
    // _loadCachedData();
    await fetchProfileData();
  }

  void _handleProfileDialogTap() {
    if ((profileData.value.data?.user?.roleName ?? "").toLowerCase() ==
        "House-Owner".toLowerCase()) {
      Get.toNamed(Routes.CONNECTOR_PROFILE);
    } else {
      Get.toNamed(Routes.PROFILE);
    }
  }

  // void _loadCachedData() {
  //   final cachedAddressData = myPref.getAddressData();
  //   if (cachedAddressData != null) {
  //     try {
  //       addressData = AddressModel.fromJson(cachedAddressData);
  //       hasAddress.value = addressData.data?.addresses?.isNotEmpty ?? false;
  //     } catch (e) {
  //       Get.printError(info: 'Error loading cached address data: $e');
  //     }
  //   }
  //
  //   final cachedProfileData = myPref.getProfileData();
  //   if (cachedProfileData != null) {
  //     try {
  //       profileData.value = ProfileModel.fromJson(cachedProfileData);
  //     } catch (e) {
  //       Get.printError(info: 'Error loading cached profile data: $e');
  //     }
  //   }
  // }

  RxString getCurrentAddress() {
    if (myPref.role.val == "partner") {
      if (profileData.value.data?.addresses?.isNotEmpty == true) {
        final int index =
            profileData.value.data?.addresses?.indexWhere((e) => e.isDefault == true) ?? 0;
        final address = profileData.value.data?.addresses?[index];

        return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
      }
      return 'No address found'.obs;
    } else {
      if (profileData.value.data?.siteLocations?.isNotEmpty == true) {
        final int index =
            profileData.value.data?.siteLocations?.indexWhere((e) => e.isDefault == true) ?? 0;
        final address = profileData.value.data?.siteLocations?[index];

        return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
      }
      return 'No address found'.obs;
    }
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfile();

      if (profileResponse.success == true && profileResponse.data?.user != null) {
        profileData.value = profileResponse;
        myPref.setProfileData(profileResponse.toJson());
        myPref.setUserModel(profileResponse.data!.user!);

        if ((profileData.value.data?.merchantProfile?.website ?? "").isNotEmpty) {
          Get.find<CommonController>().hasProfileComplete.value = true;
        } else {
          Get.find<CommonController>().hasProfileComplete.value = false;
        }
        _loadTeamFromStorage();
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTeamFromStorage() async {
    final cachedTeamModel = myPref.getTeamModelData();
    if (cachedTeamModel != null &&
        cachedTeamModel.data != null &&
        cachedTeamModel.data!.isNotEmpty) {
      teamList.assignAll(cachedTeamModel.data!);
      if (cachedTeamModel.statistics != null) {
        statistics.value = cachedTeamModel.statistics!;
      }
    } else {
      await fetchTeamList();
    }
  }

  Rx<Statistics> statistics = Statistics().obs;

  Future<void> fetchTeamList() async {
    try {
      isLoading.value = true;
      final TeamListModel result = await roleService.fetchAllTeam();
      teamList.clear();
      teamList.addAll(result.data ?? []);

      if (result.statistics != null) {
        statistics.value = result.statistics!;
      }
      myPref.setTeamModelData(result);
    } catch (e) {
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTeamList() async {
    await fetchTeamList();
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
      Get.printError(info: 'Error fetching category hierarchy: $e');
    } finally {
      isLoading(false);
    }
  }

  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;

  /// Fetch only current latitude & longitude
  Future<void> fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Permission Denied', 'Please enable location access');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Location Blocked', 'Please enable location access from app settings');
        return;
      }

      // Get current position
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;
    } catch (e) {
      Get.printError(info: 'Error fetching location: $e');
    }
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

  Future<void> notifyMeApi({int? mID, VoidCallback? onSuccess}) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().notifyMe(mID: mID);
      if (res.success == true) {
        SnackBars.successSnackBar(content: "You’ll be notified when it’s restocked!");
        if (onSuccess != null) onSuccess();
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToConnectApi({
    int? mID,
    int? pID,
    String? message,
    String? uom,
    String? quantity,
    String? radius,
    String? date,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().addToConnect(
        mID: mID,
        message: message,
        radius: radius,
        date: date,
        pID: pID,
        uom: uom,
        quantity: quantity,
      );
      if (res.success == true) {
        if (onSuccess != null) onSuccess();
        // SnackBars.successSnackBar(content: "Request sent successfully!");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Unable to send connection request.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addServiceToConnectApi({
    int? mID,
    int? sID,
    String? message,
    String? date,
    String? radius,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final res = await ConstructionLineServices().addServiceToConnect(
        mID: mID,
        sID: sID,
        message: message,
        radius: radius,
        date: date,
      );
      if (res.success == true) {
        if (onSuccess != null) onSuccess();
        SnackBars.successSnackBar(content: "Connection request sent successfully!");
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Unable to send connection request.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> wishListApi({
    required int mID,
    required String status,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final res = await WishListServices().wishList(mID: mID, status: status);
      if (res.success == true) {
        // final msg = status == "add"
        //     ? "Added to wishlist!"
        //     : "Removed from wishlist!";
        // SnackBars.successSnackBar(content: msg);
        if (onSuccess != null) onSuccess();
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Unable to update wishlist.");
    } finally {
      isLoading.value = false;
    }
  }

  void editAddress(String addressId) {
    final address = profileData.value.data?.siteLocations?.firstWhere(
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
      await fetchProfileData();
      Get.back();
    } catch (e) {
      log('Failed to delete address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultAddress(String addressId, {VoidCallback? onSuccess}) async {
    try {
      isLoading.value = true;

      await DeliveryAddressService.updateDeliveryAddress(addressId, {"is_default": true});

      await fetchProfileData();

      if (onSuccess != null) onSuccess();
    } catch (e) {
      log('Failed to update default address: $e');
    } finally {
      isLoading.value = false;
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
}
