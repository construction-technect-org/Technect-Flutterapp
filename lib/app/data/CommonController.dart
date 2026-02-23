import 'dart:developer';

import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/Authentication/login/controllers/login_controller.dart';
import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/profile_model.dart'
    as connector;
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/services/ConstructionLineServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommonController extends GetxController {
  final AppHiveService _appHiveService = Get.find<AppHiveService>();
  final hasProfileComplete = false.obs;
  final isLoading = false.obs;
  Rx<ProfileModel> profileData = ProfileModel().obs;
  Rx<connector.ProfileModel> profileDataM = connector.ProfileModel().obs;
  RxBool isCrm = true.obs;
  UserMainModel? userMainModel;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxString selectedAddress = ''.obs;
  RxSet<String> wishlistedProductIds = <String>{}.obs;

  void switchToCrm(bool inScreen) {
    if (isCrm.value) {
      Get.offAllNamed(Routes.CRM_MAIN);
      if (inScreen) {
        Get.lazyPut(() => CRMBottomController());
        Get.find<CRMBottomController>().changeTab(1);
      }
      log('Navigated to CRM Main');
    } else {
      Get.offAllNamed(Routes.VRM_MAIN);

      if (inScreen) {
        Get.lazyPut(() => VRMBottomController());
        Get.find<VRMBottomController>().changeTab(1);
      }
      log('Navigated to VRM Main');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        SnackBars.errorSnackBar(
          content: 'Location services are disabled. Please enable location services.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SnackBars.errorSnackBar(content: 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        SnackBars.errorSnackBar(content: 'Location permissions are permanently denied.');
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error getting current location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        final String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        selectedAddress.value = address;
      }
    } catch (e) {
      selectedAddress.value = 'Address not found';
    }
  }

  void switchToCrmMain() {
    if (isCrm.value) {
      Get.lazyPut(() => CRMBottomController());

      Get.find<CRMBottomController>().changeTab(1);
      log('Navigated to CRM Screen');
    } else {
      Get.lazyPut(() => VRMBottomController());
      Get.find<VRMBottomController>().changeTab(1);
      log('Navigated to VRM Screen');
    }
  }

  RxString getCurrentAddress() {
    if (myPref.role.val == "partner") {
      final addresses = profileData.value.data?.addresses;
      if (addresses != null && addresses.isNotEmpty) {
        final int index = addresses.indexWhere((e) => e.isDefault == true);
        final address = index != -1 ? addresses[index] : addresses[0];

        return '${address.fullAddress}, ${address.landmark ?? ''}'.obs;
      }
    } else {
      final siteLocations = profileData.value.data?.siteLocations;
      if (siteLocations != null && siteLocations.isNotEmpty) {
        final int index = siteLocations.indexWhere((e) => e.isDefault == true);
        final address = index != -1 ? siteLocations[index] : siteLocations[0];

        return '${address.fullAddress}, ${address.landmark ?? ''}'.obs;
      }
    }

    // Fallback to locally selected address if profile addresses are missing
    if (selectedAddress.value.isNotEmpty) {
      return selectedAddress.value.obs;
    }

    return 'No address found'.obs;
  }

  RxString getDeliveryLocation() {
    final siteLocations = profileData.value.data?.siteLocations;
    if (siteLocations != null && siteLocations.isNotEmpty) {
      final int index = siteLocations.indexWhere((e) => e.isDefault == true);
      final address = index != -1 ? siteLocations[index] : siteLocations[0];

      return '${address.fullAddress}, ${address.landmark ?? ''}'.obs;
    }
    return 'No address found'.obs;
  }

  RxString getManufacturerAddress() {
    final addresses = profileData.value.data?.addresses;
    if (addresses != null && addresses.isNotEmpty) {
      final int index = addresses.indexWhere((e) => e.isDefault == true);
      final address = index != -1 ? addresses[index] : addresses[0];

      return '${address.fullAddress}, ${address.landmark ?? ''}'.obs;
    }
    return 'No manufacturer address found'.obs;
  }

  final HomeService homeService = Get.find<HomeService>();

  Future<void> fetchProfileData() async {
    if (myPref.getToken().isEmpty) {
      log("Skipping fetchProfileData: No token");
      return;
    }
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfile();
      log("Fetching");
      if (profileResponse.success == true && profileResponse.data?.user != null) {
        profileData.value = profileResponse;
        log('🌐profileData : ${profileData.value.data}');

        myPref.setProfileData(profileResponse.toJson());
        //myPref.setUserModel(profileResponse.data!.user!);
        log("profileData.value.data?.isTeamLogin: ${profileData.value.data?.isTeamLogin}");
        if (profileData.value.data?.isTeamLogin == true) {
          myPref.setIsTeamLogin(true);
          final permissionsValue = extractPermissions(profileResponse.data?.teamMember);
          myPref.setPermissions(permissionsValue);
        }
        final isComplete = profileData.value.data?.connectorProfile?.isProfileComplete ?? false;
        hasProfileComplete.value = isComplete;
        log("Profile Status: ${isComplete ? "Complete" : "Incomplete"}");
        log(profileData.value.toString());
        // if(myPref.getIsTeamLogin()==false){
        loadTeamFromStorage();
        // }
      }
    } catch (e) {
      log('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      log("Fetched");
    }
  }

  Future<void> fetchProfileDataM() async {
    if (myPref.getToken().isEmpty) {
      log("Skipping fetchProfileDataM: No token");
      return;
    }
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfileM();
      log("Fetching");
      if (profileResponse.success == true && profileResponse.user != null) {
        profileDataM.value = profileResponse;
        log('🌐profileData : ${profileDataM.value.merchantProfile != null}');

        myPref.setProfileData(profileResponse.toJson());

        // Ensure we check the current profileData (which is of type ProfileModel) or
        // the connector profileResponse for team login logic if applicable.
        // If profileData.value.data is null, we can't check isTeamLogin this way safely.
        final isTeamLogin = profileData.value.data?.isTeamLogin ?? false;
        if (isTeamLogin) {
          myPref.setIsTeamLogin(true);
          final permissionsValue = extractPermissions(profileData.value.data?.teamMember);
          myPref.setPermissions(permissionsValue);
        }
        log("isTeamLogin: $isTeamLogin");
        log("merchantProfile: ${profileResponse.merchantProfile}");
        log("businessWebsite: ${profileResponse.merchantProfile?.businessWebsite}");

        final isComplete = profileResponse.merchantProfile?.profileStatus == "completed";
        hasProfileComplete.value = isComplete;
        log("Profile Status (M): ${isComplete ? "Complete" : "Incomplete"}");
        loadTeamFromStorage();
      }
    } catch (e) {
      log('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      log("Fetched");
    }
  }

  RxList<TeamListData> teamList = <TeamListData>[].obs;

  Future<void> loadTeamFromStorage() async {
    // await fetchTeamList();

    final cachedTeamModel = myPref.getTeamModelData();
    if (cachedTeamModel != null &&
        cachedTeamModel.data != null &&
        cachedTeamModel.data!.isNotEmpty) {
      teamList.assignAll(cachedTeamModel.data!);
      if (cachedTeamModel.statistics != null) {
        statistics.value = cachedTeamModel.statistics!;
      }
    } else {
      // await fetchTeamList();   //Important!
    }
  }

  GetAllRoleService roleService = GetAllRoleService();

  Future<void> fetchTeamList() async {
    try {
      log("Fetching Team");
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
      log("Fetching Team123");
    }
  }

  Future<void> refreshTeamList() async {
    await fetchTeamList();
  }

  Rx<Statistics> statistics = Statistics().obs;

  void loadCachedProfile() {
    final cachedData = myPref.getProfileData();
    if (cachedData != null) {
      try {
        final role = myPref.role.val;
        if (role == "partner") {
          final profile = ProfileModel.fromJson(cachedData);
          profileData.value = profile;
          hasProfileComplete.value = profile.data?.merchantProfile?.isProfileComplete ?? false;
        } else if (role == "connector") {
          final profile = connector.ProfileModel.fromJson(cachedData);
          profileDataM.value = profile;
          hasProfileComplete.value = profile.connectorProfile?.isProfileComplete ?? false;
        }
        log("Loaded profile from cache. hasProfileComplete: ${hasProfileComplete.value}");
      } catch (e) {
        log("Error loading cached profile: $e");
      }
    }
  }

  RxInt marketPlace = 0.obs;

  Future<void> notifyMeApi({dynamic mID, VoidCallback? onSuccess}) async {
    try {
      final res = await ConnectorSelectedProductServices().notifyMe(mID: mID);
      if (res.success == true) {
        SnackBars.successSnackBar(content: "You’ll be notified when it’s restocked!");
        if (onSuccess != null) onSuccess();
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Something went wrong. Please try again.");
    } finally {}
  }

  Future<void> addToConnectApi({
    dynamic mID,
    dynamic pID,
    String? message,
    String? uom,
    String? quantity,
    String? radius,
    String? date,
    VoidCallback? onSuccess,
  }) async {
    try {
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
    }
  }

  Future<void> addServiceToConnectApi({
    dynamic mID,
    dynamic sID,
    String? message,
    String? date,
    String? radius,
    VoidCallback? onSuccess,
  }) async {
    try {
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
    }
  }

  Future<void> wishListApi({
    required dynamic mID,
    required String status,
    String? moduleType,
    VoidCallback? onSuccess,
  }) async {
    try {
      final role = myPref.role.val;
      if (role == "connector") {
        final connectorProfileId = profileDataM.value.connectorProfile?.id?.toString();
        if (connectorProfileId == null) {
          SnackBars.errorSnackBar(content: "Connector profile not found.");
          return;
        }
        final res = await WishListServices().wishList(
          wishlistItemId: mID.toString(),
          connectorProfileId: connectorProfileId,
          moduleType: moduleType ?? "product",
          isAdd: status == "add",
        );
        // Treat as success if res.success is true OR if it's a valid response object (backend sometimes omits success flag)
        if (res.success == true || (res.message == "" && status == "add")) {
          if (status == "add") {
            wishlistedProductIds.add(mID.toString());
            SnackBars.successSnackBar(content: "Added to Wishlist");
          } else {
            wishlistedProductIds.remove(mID.toString());
            SnackBars.successSnackBar(content: "Removed from Wishlist");
          }
          if (onSuccess != null) onSuccess();
        } else {
          SnackBars.errorSnackBar(
            content: res.message.isNotEmpty ? res.message : "Unable to update wishlist.",
          );
        }
      } else {
        debugPrint("Wishlist for role $role not implemented.");
      }
    } catch (e) {
      debugPrint("Error in wishListApi: $e");
      String errorMessage = e.toString();
      if (errorMessage.startsWith("Exception: ")) {
        errorMessage = errorMessage.replaceFirst("Exception: ", "");
      }
      // Strip common AppException prefixes for a cleaner UI
      errorMessage = errorMessage.replaceFirst("Invalid Request: ", "");
      errorMessage = errorMessage.replaceFirst("Error During Communication: ", "");
      errorMessage = errorMessage.replaceFirst("Unauthorised: ", "");

      SnackBars.errorSnackBar(
        content: errorMessage.isNotEmpty ? errorMessage : "Unable to update wishlist.",
      );
    }
  }

  Future<void> syncWishlistIds() async {
    try {
      if (myPref.getToken().isEmpty) return;

      if (profileDataM.value.connectorProfile?.id == null) {
        debugPrint("🔍 [WishlistSync] Profile missing, fetching fresh profile data...");
        await fetchProfileDataM();
      }

      int retries = 0;
      while (profileDataM.value.connectorProfile?.id == null && retries < 3) {
        debugPrint(
          "🔍 [WishlistSync] Connector profile ID not found, waiting... (try ${retries + 1})",
        );
        await Future.delayed(const Duration(milliseconds: 500));
        retries++;
      }

      final connectorProfileId = profileDataM.value.connectorProfile?.id?.toString();
      debugPrint("🔍 [WishlistSync] Syncing for connectorProfileId: $connectorProfileId");
      if (connectorProfileId == null) {
        debugPrint("🔍 [WishlistSync] Connector profile ID still not found, skipping sync.");
        return;
      }

      final res = await WishListServices().allWishList(connectorProfileId: connectorProfileId);
      debugPrint(
        "🔍 [WishlistSync] API Response - Success: ${res.success}, Data Count: ${res.data?.length}",
      );

      if (res.success == true) {
        final Set<String> collectedIds = {};
        for (final p in (res.data ?? [])) {
          final pid = p.id?.toString();
          if (pid != null) collectedIds.add(pid);
        }
        if (res.wishlistItemIds != null) {
          collectedIds.addAll(res.wishlistItemIds!);
        }

        wishlistedProductIds.assignAll(collectedIds);
        debugPrint("🔍 [WishlistSync] Updated wishlistedProductIds: $wishlistedProductIds");
      }
    } catch (e) {
      debugPrint("🔍 [WishlistSync] Error during sync: $e");
    }
  }

  void editAddress(String addressId) {
    final address = Get.find<CommonController>().profileData.value.data?.siteLocations?.firstWhere(
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
      await DeliveryAddressService.deleteDeliveryAddress(addressId);
      await Get.find<CommonController>().fetchProfileData();
      Get.back();
    } catch (e) {
      log('Failed to delete address: $e');
    }
  }

  Future<void> setDefaultAddress(String addressId, {VoidCallback? onSuccess}) async {
    try {
      await DeliveryAddressService.updateDeliveryAddress(addressId, {"is_default": true});

      //await Get.find<CommonController>().fetchProfileData();

      if (onSuccess != null) onSuccess();
    } catch (e) {
      log('Failed to update default address: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log("Oninit");

    loadCachedProfile();

    // Fetch profile immediately so hasProfileComplete and addresses
    // are ready before any screen checks them (e.g. + button tap).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (myPref.role.val == "partner") {
        await fetchProfileData();
      } else {
        await fetchProfileDataM();
      }
    });

    getCurrentLocation();
    final savedToken = _appHiveService.token;
    //myPref.getToken();
    final savedTokenType = _appHiveService.tokenType;
    //myPref.getTokenType();
    log("Saved $savedTokenType");
    if (savedTokenType == "ACCESS") {
      log("HeyToke");
      userMainModel = _appHiveService.user;
      //myPref.getUserModel();
      log("First Name ${userMainModel?.firstName}");

      if (savedToken.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () async {
          if (_appHiveService.token.isNotEmpty && myPref.role.val == "connector") {
            await fetchProfileDataM();
            await syncWishlistIds();
          }
          // fetchProfileData();
        });
        // if(myPref.getIsTeamLogin()==false){
        //loadTeamFromStorage();
        // }
      }
    }
  }
}
