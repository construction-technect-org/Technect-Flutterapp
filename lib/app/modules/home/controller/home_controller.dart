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
    // Refresh data when returning to home screen
    _refreshHomeData();
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
