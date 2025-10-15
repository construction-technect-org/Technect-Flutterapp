import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

  final features = [
    {"title": "Marketplace", "icon": Asset.role1},
    {"title": "CRM", "icon": Asset.role1},
    {"title": "ERP", "icon": Asset.role1},
    {"title": "Project Management", "icon": Asset.role1},
    {"title": "HRMS", "icon": Asset.role1},
    {"title": "Portfolio Management", "icon": Asset.role1},
    {"title": "OVP", "icon": Asset.role1},
    {"title": "Construction Taxi", "icon": Asset.role1},
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
  Rx<AddressModel> addressData = AddressModel().obs;

  RxString address = "".obs;

  void getCurrentAddress() {
    if (addressData.value.data?.addresses?.isNotEmpty == true) {
      final currentAddress = addressData.value.data!.addresses!.first;
      address.value =
          '${currentAddress.addressLine1 ?? ''}, ${currentAddress.city ?? ''}, ${currentAddress.state ?? ''}';
    }
  }

  Future<void> _checkAddressAndNavigate() async {
    try {
      final addressResponse = await homeService.getAddress();

      if (addressResponse.success == true &&
          (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
        addressData.value = addressResponse;

        myPref.setAddressData(addressResponse.toJson());
      } else {
        myPref.clearAddressData();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      getCurrentAddress();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfileData();
    _checkAddressAndNavigate();
  }
}
