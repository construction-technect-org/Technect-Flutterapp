import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class HomeController extends GetxController {
  final List<Map<String, String>> items = [
    {"icon": Asset.marketplaceIcon, "label": "Marketplace"},
    {"icon": Asset.erpIcon, "label": "ERP"},
    {"icon": Asset.crmIcon, "label": "CRM"},
    {"icon": Asset.ovpIcon, "label": "OVP"},
    {"icon": Asset.hrmsIcon, "label": "HRMS"},
    {"icon": Asset.projectManagementIcon, "label": "Project\nManagement"},
    {"icon": Asset.portfolioManagementIcon, "label": "Portfolio\nManagement"},
  ];

  // Services
  HomeService homeService = HomeService();

  // State management
  final isLoading = false.obs;
  final hasAddress = false.obs;
  final hasProfileComplete = false.obs;

  // Data
  Rx<ProfileModel> profileData = ProfileModel().obs;
  AddressModel addressData = AddressModel();

  @override
  void onInit() {
    super.onInit();
    _initializeHomeData();
  }

  @override
  void onReady() {
    super.onReady();
    _refreshHomeData();

    // Check profile completion after UI is ready
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkProfileCompletion();
    });
  }

  Future<void> _initializeHomeData() async {
    // Load from cache first
    _loadCachedData();

    // Only call API if no cached data exists
    if (!_hasCachedAddressData()) {
      await _checkAddressAndNavigate();
    }

    if (!_hasCachedProfileData()) {
      await _fetchProfileData();
    }
  }

  // Check if cached address data exists
  bool _hasCachedAddressData() {
    final cachedData = myPref.getAddressData();
    return cachedData != null && cachedData.isNotEmpty;
  }

  // Check if cached profile data exists
  bool _hasCachedProfileData() {
    final cachedData = myPref.getProfileData();
    return cachedData != null && cachedData.isNotEmpty;
  }

  // Check profile completion percentage
  void _checkProfileCompletion() {
    Get.printInfo(info: '🔍 Checking profile completion...');
    Get.printInfo(info: '📊 Profile data: ${profileData.value.toJson()}');

    final completionPercentage =
        profileData.value.data?.merchantProfile?.profileCompletionPercentage ?? 0;
    hasProfileComplete.value = completionPercentage >= 90;
    Get.printInfo(
      info:
          '📊 Profile completion: $completionPercentage%, Complete: ${hasProfileComplete.value}',
    );

    if (!hasProfileComplete.value) {
      Get.printInfo(info: '🚨 Profile incomplete, showing dialog...');
      _showProfileCompletionDialog();
    } else {
      Get.printInfo(info: '✅ Profile complete, no dialog needed');
    }
  }

  // Show profile completion dialog
  void _showProfileCompletionDialog() {
    Get.printInfo(info: '🎯 Showing profile completion dialog...');

    // Check if dialog is already open
    if (Get.isDialogOpen == true) {
      Get.printInfo(info: '⚠️ Dialog already open, skipping...');
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
                  color: Colors.black.withOpacity(0.1),
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
                    style: MyTexts.medium18.copyWith(color: MyColors.textFieldBackground),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Profile Pending',
                    style: MyTexts.medium16.copyWith(color: MyColors.warning),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false, // Non-closable dialog
    );

    Get.printInfo(info: '✅ Profile completion dialog displayed');
  }

  // Handle profile dialog tap based on completion percentage
  void _handleProfileDialogTap() {
    final completionPercentage =
        profileData.value.data?.merchantProfile?.profileCompletionPercentage ?? 0;

    Get.printInfo(info: '🎯 Profile dialog tapped - Completion: $completionPercentage%');

    if (completionPercentage == 0) {
      // If percentage is 0, navigate to EDIT_PROFILE
      Get.printInfo(info: '📝 Navigating to EDIT_PROFILE (0% completion)');
      Get.toNamed(Routes.EDIT_PROFILE);
    } else {
      // If percentage is more than 0, navigate to PROFILE
      Get.printInfo(info: '👤 Navigating to PROFILE ($completionPercentage% completion)');
      Get.toNamed(Routes.PROFILE);
    }
  }

  // Load cached data for instant display on home screen
  void _loadCachedData() {
    // Load cached address data
    final cachedAddressData = myPref.getAddressData();
    if (cachedAddressData != null) {
      try {
        addressData = AddressModel.fromJson(cachedAddressData);
        hasAddress.value = addressData.data?.addresses?.isNotEmpty ?? false;
        Get.printInfo(info: '📱 Home: Loaded cached address data');
      } catch (e) {
        Get.printError(info: 'Error loading cached address data: $e');
      }
    }

    // Load cached profile data
    final cachedProfileData = myPref.getProfileData();
    if (cachedProfileData != null) {
      try {
        profileData.value = ProfileModel.fromJson(cachedProfileData);
        Get.printInfo(info: '📱 Home: Loaded cached profile data');
      } catch (e) {
        Get.printError(info: 'Error loading cached profile data: $e');
      }
    }
  }

  // Check address first, if not found navigate to location view
  Future<void> _checkAddressAndNavigate() async {
    try {
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true &&
          (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
        hasAddress.value = true;
        addressData = addressResponse;

        // Cache address data for home screen only
        myPref.setAddressData(addressResponse.toJson());
        Get.printInfo(info: '💾 Home: Cached address data');
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

  // Fetch and save profile data
  Future<void> _fetchProfileData() async {
    try {
      final profileResponse = await homeService.getProfile();

      if (profileResponse.success == true && profileResponse.data?.user != null) {
        profileData.value = profileResponse;

        // Cache profile data for home screen only
        myPref.setProfileData(profileResponse.toJson());
        Get.printInfo(info: '💾 Home: Cached profile data');

        // Update user data in shared preferences
        myPref.setUserModel(profileResponse.data!.user!);
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    }
  }

  // Get current address for display
  String getCurrentAddress() {
    if (hasAddress.value && addressData.data?.addresses?.isNotEmpty == true) {
      final currentAddress = addressData.data!.addresses!.first;
      return '${currentAddress.addressLine1 ?? ''}, ${currentAddress.city ?? ''}, ${currentAddress.state ?? ''}';
    }
    return 'No address found';
  }

  // Navigate to address view with existing data
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

      // Navigate to address view with existing address data
      Get.toNamed(Routes.ADDRESS, arguments: addressDataMap);
    } else {
      Get.toNamed(Routes.ADDRESS);
    }
  }

  // Refresh home data when returning to home screen
  Future<void> _refreshHomeData() async {
    // Only refresh if no cached data exists
    if (!_hasCachedAddressData()) {
      try {
        // Refresh address data
        final addressResponse = await homeService.getAddress();
        if (addressResponse.success == true &&
            (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
          hasAddress.value = true;
          addressData = addressResponse;
          myPref.setAddressData(addressResponse.toJson());
          Get.printInfo(info: '🔄 Home: Refreshed address data');
        } else {
          hasAddress.value = false;
          myPref.clearAddressData();
        }
      } catch (e) {
        Get.printError(info: 'Error refreshing home data: $e');
      }
    } else {
      Get.printInfo(info: '📱 Home: Using cached address data, no API call needed');
    }
  }

  // Public method to refresh data (only if no cached data exists)
  Future<void> refreshData() async {
    isLoading.value = true;

    try {
      // Only call API if no cached data exists
      if (!_hasCachedAddressData()) {
        await _checkAddressAndNavigate();
      }

      if (!_hasCachedProfileData()) {
        await _fetchProfileData();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
