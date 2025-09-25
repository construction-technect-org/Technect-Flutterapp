import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class HomeController extends GetxController {
  CommonController commonController = Get.find();

  final List<Map<String, dynamic>> items = [
    {"icon": Asset.inbox, "title": "Inbox"},
    {"icon": Asset.report, "title": "Report"},
    {"icon": Asset.report, "title": "Analysis"},
    {"icon": Asset.setting, "title": "Setting"},
    {"icon": Asset.insights, "title": "Insights"},
    {"icon": Asset.cart, "title": "Inventory"},
    {"icon": Asset.warning, "title": "News"},
    {"icon": Asset.thumbup, "title": "Refer& Earn"},
  ];

  RxInt selectedIndex = 0.obs;

  HomeService homeService = HomeService();
  GetAllRoleService roleService = GetAllRoleService();

  final isLoading = false.obs;
  final hasAddress = false.obs;

  Rx<ProfileModel> profileData = ProfileModel().obs;
  AddressModel addressData = AddressModel();
  RxList<TeamListData> teamList = <TeamListData>[].obs;

  bool _profileDialogShown = false;

  @override
  void onInit() {
    super.onInit();
    _initializeHomeData();
    _loadTeamFromStorage();
  }

  @override
  void onReady() {
    super.onReady();
    _refreshHomeData();

    Future.delayed(const Duration(milliseconds: 500), () {
      _checkAddressAndProfileCompletion();
    });
  }

  Future<void> _initializeHomeData() async {
    _loadCachedData();

    if (!_hasCachedAddressData()) {
      await _checkAddressAndNavigate();
    }

    await fetchProfileData();
  }

  bool _hasCachedAddressData() {
    final cachedData = myPref.getAddressData();
    return cachedData != null && cachedData.isNotEmpty;
  }

  void _checkAddressAndProfileCompletion() {
    // First check if address is available
    if (!_hasCachedAddressData()) {
      // No address available - navigate to address screen (no profile dialog)
      _checkAddressAndNavigate();
      return;
    }

    // Address is available - now check profile completion
    _checkProfileCompletion();
  }

  void _checkProfileCompletion() {
    // final bool isPartner=profileData.value.data?.user?.roleName=="Partner";
    final merchantProfile = profileData.value.data?.merchantProfile;
    final connectorProfile = profileData.value.data?.connectorProfile;

    final completionPercentage =
        merchantProfile?.profileCompletionPercentage ??
        connectorProfile?.profileCompletionPercentage ??
        0;

    if (merchantProfile != null || connectorProfile != null) {
      commonController.hasProfileComplete.value = completionPercentage >= 90;
    }

    if (!commonController.hasProfileComplete.value &&
        Get.isDialogOpen != true &&
        !_profileDialogShown) {
      _profileDialogShown = true;
      _showProfileCompletionDialog();
    }
  }

  void _showProfileCompletionDialog() {
    if (Get.isDialogOpen == true) {
      return;
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
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
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Profile Pending',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.warning,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _handleProfileDialogTap() {
    final role = profileData.value.data?.user?.roleName;

    final bool isPartner =
        role?.toLowerCase() == "merchant" ||
        role?.toLowerCase() == "civil engineer" ||
        role?.toLowerCase() == "architect" ||
        role?.toLowerCase() == "designer";
    if (isPartner == true) {
      Get.toNamed(Routes.PROFILE);
    } else {
      Get.toNamed(Routes.CONNECTOR_PROFILE);
    }
  }

  void resetProfileDialogFlag() {
    _profileDialogShown = false;
  }

  void checkProfileCompletionManually() {
    _profileDialogShown = false;
    _checkProfileCompletion();
  }

  void onReturnFromEditProfile() {
    if (!commonController.hasProfileComplete.value) {
      _profileDialogShown = false;
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      _checkProfileCompletionAfterEdit();
    });
  }

  void _checkProfileCompletionAfterEdit() {
    final completionPercentage =
        profileData.value.data?.merchantProfile?.profileCompletionPercentage ??
        0;

    if (profileData.value.data?.merchantProfile != null) {
      commonController.hasProfileComplete.value = completionPercentage >= 90;
    }

    if (commonController.hasProfileComplete.value) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      resetProfileDialogFlag();
    } else {
      _profileDialogShown = false;
    }
  }

  void _loadCachedData() {
    final cachedAddressData = myPref.getAddressData();
    if (cachedAddressData != null) {
      try {
        addressData = AddressModel.fromJson(cachedAddressData);
        hasAddress.value = addressData.data?.addresses?.isNotEmpty ?? false;
      } catch (e) {
        Get.printError(info: 'Error loading cached address data: $e');
      }
    }

    final cachedProfileData = myPref.getProfileData();
    if (cachedProfileData != null) {
      try {
        profileData.value = ProfileModel.fromJson(cachedProfileData);
      } catch (e) {
        Get.printError(info: 'Error loading cached profile data: $e');
      }
    }
  }

  Future<void> _checkAddressAndNavigate() async {
    try {
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true &&
          (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
        hasAddress.value = true;
        addressData = addressResponse;

        myPref.setAddressData(addressResponse.toJson());
      } else {
        hasAddress.value = false;
        myPref.clearAddressData();
        Get.toNamed(Routes.ADDRESS);
      }
    } catch (e) {
      hasAddress.value = false;
      Get.toNamed(Routes.ADDRESS);
    }
  }

  String getCurrentAddress() {
    if (hasAddress.value && addressData.data?.addresses?.isNotEmpty == true) {
      final currentAddress = addressData.data!.addresses!.first;
      return '${currentAddress.addressLine1 ?? ''}, ${currentAddress.city ?? ''}, ${currentAddress.state ?? ''}';
    }
    return 'No address found';
  }

  void navigateToEditAddress() {
    if (hasAddress.value && addressData.data?.addresses?.isNotEmpty == true) {
      final currentAddress = addressData.data!.addresses!.first;
      final addressDataMap = {
        'id': currentAddress.id,
        'address_line1': currentAddress.addressLine1,
        'address_line2': currentAddress.addressLine2,
        'landmark': currentAddress.landmark,
        'city': currentAddress.city,
        'state': currentAddress.state,
        'pin_code': currentAddress.pinCode,
        'latitude': currentAddress.latitude != null
            ? double.tryParse(currentAddress.latitude!)
            : null,
        'longitude': currentAddress.longitude != null
            ? double.tryParse(currentAddress.longitude!)
            : null,
        'address_type': currentAddress.addressType,
        'is_default': currentAddress.isDefault,
      };

      Get.toNamed(Routes.ADDRESS, arguments: addressDataMap);
    } else {
      Get.toNamed(Routes.ADDRESS);
    }
  }

  Future<void> _refreshHomeData() async {
    if (!_hasCachedAddressData()) {
      try {
        final addressResponse = await homeService.getAddress();
        if (addressResponse.success == true &&
            (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
          hasAddress.value = true;
          addressData = addressResponse;
          myPref.setAddressData(addressResponse.toJson());
        } else {
          hasAddress.value = false;
          myPref.clearAddressData();
        }
      } catch (e) {
        Get.printError(info: 'Error refreshing home data: $e');
      }
    }
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
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTeamFromStorage() async {
    final cachedTeam = myPref.getTeam();
    if (cachedTeam != null && cachedTeam.isNotEmpty) {
      teamList.assignAll(cachedTeam);
    } else {
      await fetchTeamList();
    }
  }

  Future<void> fetchTeamList() async {
    try {
      isLoading.value = true;
      final TeamListModel? result = await roleService.fetchAllTeam();
      if (result?.success == true) {
        teamList.clear();
        teamList.addAll(result?.data ?? []);
        await myPref.saveTeam(teamList.toList());
      }
    } catch (e) {
      Get.printError(info: 'Error fetching team list: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTeamList() async {
    await fetchTeamList();
  }

  Future<void> refreshAddressAndProfile() async {
    // Refresh address data
    await _refreshHomeData();

    // Refresh profile data
    await fetchProfileData();

    // Re-check both address and profile completion
    Future.delayed(const Duration(milliseconds: 300), () {
      _checkAddressAndProfileCompletion();
    });
  }
}
