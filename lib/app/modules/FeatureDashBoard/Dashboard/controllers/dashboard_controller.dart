import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

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

  void onFeatureTap(String featureName) {
    if (featureName == "Marketplace") {
      Get.toNamed(Routes.MARKET_PLACE);
    }
  }

  RxInt selectedIndex = (-1).obs;
  HomeService homeService = HomeService();

  Rx<ProfileModel> profileData = ProfileModel().obs;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfileData();
  }
}
