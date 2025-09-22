import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  final features = [
    {"title": "Marketplace", "icon": Asset.marketplaceIcon},
    {"title": "CRM", "icon": Asset.crmIcon},
    {"title": "ERP", "icon": Asset.erpIcon},
    {"title": "Projects", "icon": Asset.projectManagementIcon},
    {"title": "HRMS", "icon": Asset.hrmsIcon},
    {"title": "Portfolio", "icon": Asset.portfolioManagementIcon},
    {"title": "OVP", "icon": Asset.ovpIcon},
    {"title": "Construction", "icon": Asset.constructionTaxi},
  ];

  void onFeatureTap(String featureName) {
    // Navigate based on feature
    if (featureName == "Marketplace") {
      Get.toNamed(Routes.MARKET_PLACE);
    }
  }

  // RxInt selectedIndex = 0.obs;
  // ignore: type_annotate_public_apis
  var selectedIndex = (-1).obs;

  //   Future<bool> firstPartValidation() async {
  //     bool isRequired = false;
  //     if (selectedIndex==null) {
  //       SnackBars.errorSnackBar(content: 'Service image is required');
  //       isRequired = false;
  //     } else {
  //       isRequired = true;
  //     }
  //     return isRequired;
  //   }
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

  //address
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
