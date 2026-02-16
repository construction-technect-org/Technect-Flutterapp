import 'dart:developer';

import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/Authentication/login/controllers/login_controller.dart';
import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/profile_model.dart';
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
  Rx<ProfileModelM> profileDataM = ProfileModelM().obs;
  RxBool isCrm = true.obs;
  UserMainModel? userMainModel;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxString selectedAddress = ''.obs;

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
          content:
              'Location services are disabled. Please enable location services.',
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
        SnackBars.errorSnackBar(
          content: 'Location permissions are permanently denied.',
        );
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
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
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
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
      if (profileData.value.data?.addresses?.isNotEmpty == true) {
        final int index =
            profileData.value.data?.addresses?.indexWhere(
              (e) => e.isDefault == true,
            ) ??
            0;
        final address = profileData.value.data?.addresses?[index];

        return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
      }
      return 'No address found'.obs;
    } else {
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
  }

  RxString getDeliveryLocation() {
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

  RxString getManufacturerAddress() {
    if (profileData.value.data?.addresses?.isNotEmpty == true) {
      final int index =
          profileData.value.data?.addresses?.indexWhere(
            (e) => e.isDefault == true,
          ) ??
          0;
      final address = profileData.value.data?.addresses?[index];

      return '${address?.fullAddress}, ${address?.landmark ?? ''}'.obs;
    }
    return 'No manufacturer address found'.obs;
  }

  final HomeService homeService = Get.find<HomeService>();

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfile();
      print("Fetching");
      if (profileResponse.success == true && profileResponse.data?.user != null) {
        profileData.value = profileResponse;
        Get.printInfo(info: '🌐profileData : ${profileData.value.data}');

        myPref.setProfileData(profileResponse.toJson());
        //myPref.setUserModel(profileResponse.data!.user!);
        if (profileData.value.data?.isTeamLogin == true) {
          myPref.setIsTeamLogin(true);
          final permissionsValue = extractPermissions(
            profileResponse.data?.teamMember,
          );
          myPref.setPermissions(permissionsValue);
        }
        if ((profileData.value.data?.merchantProfile?.website ?? "")
            .isNotEmpty) {
          Get.find<CommonController>().hasProfileComplete.value = true;
        } else {
          Get.find<CommonController>().hasProfileComplete.value = false;
        }
        print(profileData.value);
        // if(myPref.getIsTeamLogin()==false){
        loadTeamFromStorage();
        // }
      }
      else{
        const a=10;
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("Fetched");
    }
  }
  Future<void> fetchProfileDataM() async {
    try {
      isLoading.value = true;
      final profileResponse = await homeService.getProfileM();
      print("Fetching");
      if (profileResponse.success == true && profileResponse.user != null) {
        profileDataM.value = profileResponse;
        Get.printInfo(info: '🌐profileData : ${profileDataM.value.merchantProfile!=null}');

        // myPref.setProfileData(profileResponse.toJson());
        // //myPref.setUserModel(profileResponse.data!.user!);
        // if (profileData.value.data?.isTeamLogin == true) {
        //   myPref.setIsTeamLogin(true);
        //   final permissionsValue = extractPermissions(
        //     profileResponse.data?.teamMember,
        //   );
        //   myPref.setPermissions(permissionsValue);
        // }
        // if ((profileData.value.data?.merchantProfile?.website ?? "")
        //     .isNotEmpty) {
        //   Get.find<CommonController>().hasProfileComplete.value = true;
        // } else {
        //   Get.find<CommonController>().hasProfileComplete.value = false;
        // }
        print(profileData.value);
        // if(myPref.getIsTeamLogin()==false){
        loadTeamFromStorage();
        // }
      }
      else{
        const a=10;
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("Fetched");
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
      await fetchTeamList();
    }
  }

  GetAllRoleService roleService = GetAllRoleService();

  Future<void> fetchTeamList() async {
    try {
      print("Fetching Team");
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
      print("Fetching Team123");
    }
  }

  Future<void> refreshTeamList() async {
    await fetchTeamList();
  }

  Rx<Statistics> statistics = Statistics().obs;

  RxInt marketPlace = 0.obs;

  Future<void> notifyMeApi({int? mID, VoidCallback? onSuccess}) async {
    try {
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
    } finally {}
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
    int? mID,
    int? sID,
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
        SnackBars.successSnackBar(
          content: "Connection request sent successfully!",
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: "Unable to send connection request.");
    }
  }

  Future<void> wishListApi({
    required int mID,
    required String status,
    VoidCallback? onSuccess,
  }) async {
    try {
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
    }
  }

  void editAddress(String addressId) {
    final address = Get.find<CommonController>()
        .profileData
        .value
        .data
        ?.siteLocations
        ?.firstWhere((addr) => addr.id.toString() == addressId);

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
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
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

  Future<void> setDefaultAddress(
    String addressId, {
    VoidCallback? onSuccess,
  }) async {
    try {
      await DeliveryAddressService.updateDeliveryAddress(addressId, {
        "is_default": true,
      });

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
    print("Oninit");
    getCurrentLocation();
    final savedToken = _appHiveService.token;
    //myPref.getToken();
    final savedTokenType = _appHiveService.tokenType;
    //myPref.getTokenType();
    print("Saved $savedTokenType");
    if (savedTokenType == "ACCESS") {
      print("HeyToke");
      userMainModel = _appHiveService.user;
      //myPref.getUserModel();
      print("First Name ${userMainModel?.firstName}");

      if (savedToken.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () async {
         await  fetchProfileDataM();
          // fetchProfileData();
        });
        // if(myPref.getIsTeamLogin()==false){
        //loadTeamFromStorage();
        // }
      }
    }
  }
}
