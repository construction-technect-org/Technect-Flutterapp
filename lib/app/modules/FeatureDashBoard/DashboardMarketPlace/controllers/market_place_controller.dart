import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/FeatureDashBoard/DashboardMarketPlace/services/MarketPlaceService.dart';

class DashboardMarketPlaceController extends GetxController {
  RxBool isLoading = false.obs;

  RxString selectedMarketplace = "".obs;
  RxString selectedRole = "".obs;

  final marketplaces = [
    {"title": "Material Marketplacee", "icon": Asset.materialMarketplace},
    {
      "title": "Construction-Line Marketplacee",
      "icon": Asset.constructionCinemarketPlace,
    },
    {"title": "Logistic Marketplacee", "icon": Asset.logisticMarketPlace},
  ];

  final roles = [
    {"title": "Partner", "icon": Asset.partnerSvg},
    {"title": "Connector", "icon": Asset.connectorSvg},
  ];

  void selectMarketplace(String title) {
    selectedMarketplace.value = title;
  }

  void selectRole(String title) {
    selectedRole.value = title;
  }

  bool get canProceed =>
      selectedMarketplace.isNotEmpty && selectedRole.isNotEmpty;

  MarketplaceService marketplaceService = MarketplaceService();

  Future<void> marketPlace() async {
    isLoading.value = true;

    try {
      final loginResponse = await marketplaceService.marketPlaceApi(
        marketPlace: selectedMarketplace.value,
        marketPlaceRole: selectedRole.value,
      );

      if (loginResponse.success == true) {
        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }
        isLoading.value = false;

        if (selectedRole.value.trim().toLowerCase() == "partner") {
          Get.offAllNamed(Routes.MAIN);
        } else {
          Get.offAllNamed(Routes.CONNECTOR_MAIN_TAB);
        }
      } else {
        SnackBars.errorSnackBar(
          content: loginResponse.message ?? 'Update failed',
        );
      }
    } catch (e) {
      isLoading.value = false;

      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }
}
