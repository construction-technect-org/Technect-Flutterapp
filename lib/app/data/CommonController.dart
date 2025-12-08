import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/bottom/controllers/bottom_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/services/ConnectorSelectedProductServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/services/WishListService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/services/ConstructionLineServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/vrm/bottom/controllers/bottom_controller.dart';

class CommonController extends GetxController {
  final hasProfileComplete = false.obs;
  final isLoading = false.obs;
  Rx<ProfileModel> profileData = ProfileModel().obs;
  RxBool isCrm = true.obs;

  void toggleIsCrm(bool inScreen) {
    isCrm.value = !isCrm.value;
    log('Switching to ${isCrm.value ? "CRM" : "VRM"}');
    switchToCrm(inScreen);
  }

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

  HomeService homeService = HomeService();

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
        loadTeamFromStorage();
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxList<TeamListData> teamList = <TeamListData>[].obs;

  Future<void> loadTeamFromStorage() async {
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

  Rx<Statistics> statistics = Statistics().obs;

  RxInt marketPlace = 0.obs;

  Future<void> notifyMeApi({int? mID, VoidCallback? onSuccess}) async {
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
        SnackBars.successSnackBar(content: "Connection request sent successfully!");
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

      await Get.find<CommonController>().fetchProfileData();

      if (onSuccess != null) onSuccess();
    } catch (e) {
      log('Failed to update default address: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final savedToken = myPref.getToken();
    if (savedToken.isNotEmpty) {
      fetchProfileData();
      loadTeamFromStorage();
    }
  }
}
