import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
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

  RxInt selectedIndex = 0.obs;

  HomeService homeService = HomeService();
  GetAllRoleService roleService = GetAllRoleService();

  final isLoading = false.obs;
  final hasAddress = false.obs;

  Rx<ProfileModel> profileData = ProfileModel().obs;

  // AddressModel addressData = AddressModel();
  RxList<TeamListData> teamList = <TeamListData>[].obs;
  Rx<CategoryModel> categoryHierarchyData = CategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryHierarchy();
    _initializeHomeData();
    commonController.hasProfileComplete.value =
        (profileData.value.data?.merchantProfile?.businessEmail ?? "")
            .isNotEmpty;
  }

  Future<void> _initializeHomeData() async {
    // _loadCachedData();

    await fetchProfileData();
  }

  void _showProfileCompletionDialog() {
    if (Get.isDialogOpen == true) {
      return;
    }

    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: GestureDetector(
            onTap: () {
              _handleProfileDialogTap();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Asset.pendingIcon, height: 80),
                    const SizedBox(height: 12),
                    Text(
                      'Complete your Profile',
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.textFieldBackground,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Profile Pending',
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.warning,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
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
    if (profileData.value.data?.siteLocations?.isNotEmpty == true) {
      final int index =
          profileData.value.data?.siteLocations?.indexWhere(
            (e) => e.isDefault == true,
          ) ??
          0;
      final address = profileData.value.data?.siteLocations?[index];

      return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
    }
    return 'No address found'.obs;
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfile();

      if (profileResponse.success == true &&
          profileResponse.data?.user != null) {
        profileData.value = profileResponse;
        myPref.setProfileData(profileResponse.toJson());
        myPref.setUserModel(profileResponse.data!.user!);
        if ((profileData
                    .value
                    .data
                    ?.merchantProfile
                    ?.profileCompletionPercentage ??
                0) >=
            90) {
          _loadTeamFromStorage();
        }
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
      final TeamListModel? result = await roleService.fetchAllTeam();
      if (result?.success == true) {
        teamList.clear();
        teamList.addAll(result?.data ?? []);

        if (result?.statistics != null) {
          statistics.value = result!.statistics!;
        }
        // Store the complete model
        myPref.setTeamModelData(result!);
      }
    } catch (e) {
      // Fallback to cached data if API fails
      final cachedTeamModel = myPref.getTeamModelData();
      if (cachedTeamModel != null && cachedTeamModel.data != null) {
        teamList.assignAll(cachedTeamModel.data!);
        if (cachedTeamModel.statistics != null) {
          statistics.value = cachedTeamModel.statistics!;
        }
      }
      Get.printError(info: 'Error fetching team list: $e');
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
        Get.snackbar(
          'Location Blocked',
          'Please enable location access from app settings',
        );
        return;
      }

      // Get current position
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;
    } catch (e) {
      Get.printError(info: 'Error fetching location: $e');
    }
  }

  final features = [
    {"title": "Marketplace", "icon": Asset.role1, "available": true},
    {"title": "CRM", "icon": Asset.crm, "available": true},
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

  Future<void> notifyMeApi({int? mID, VoidCallback? onSuccess}) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().notifyMe(mID: mID);
      if (res.success == true) {
        SnackBars.successSnackBar(
          content: "You’ll be notified when it’s restocked!",
        );
        if (onSuccess != null) onSuccess();
      }
    } catch (e) {
      SnackBars.errorSnackBar(
        content: "Something went wrong. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToConnectApi({
    int? mID,
    int? pID,
    String? message,
    VoidCallback? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final res = await ConnectorSelectedProductServices().addToConnect(
        mID: mID,
        message: message,
        pID: pID,
      );
      if (res.success == true) {
        SnackBars.successSnackBar(content: "Request sent successfully!");
        if (onSuccess != null) onSuccess();
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
        final msg = status == "add"
            ? "Added to wishlist!"
            : "Removed from wishlist!";
        SnackBars.successSnackBar(content: msg);
        if (onSuccess != null) onSuccess();
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Unable to update wishlist.");
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
