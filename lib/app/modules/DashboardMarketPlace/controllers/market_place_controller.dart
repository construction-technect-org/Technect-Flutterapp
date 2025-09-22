import 'package:construction_technect/app/core/utils/imports.dart';

// class DashboardMarketPlaceController extends GetxController {
//   RxBool isLoading = false.obs;

//   RxString selectedMarketplace = "Material Marketplace".obs;
//   RxString selectedRole = "Partner".obs;

//   final marketplaces = [
//     {"title": "Material Marketplace", "icon": Asset.materialMarketplace},
//     {
//       "title": "Construction-Line Marketplace",
//       "icon": Asset.constructionCinemarketPlace,
//     },
//     {"title": "Logistic Marketplace", "icon": Asset.logisticMarketPlace},
//   ];

//   final roles = [
//     {"title": "Partner", "icon": Asset.partnerSvg},
//     {"title": "Connector", "icon": Asset.connectorSvg},
//   ];

//   void selectMarketplace(String title) {
//     selectedMarketplace.value = title;
//   }

//   void selectRole(String title) {
//     selectedRole.value = title;
//   }

//   bool get canProceed =>
//       selectedMarketplace.isNotEmpty && selectedRole.isNotEmpty;
// }

class DashboardMarketPlaceController extends GetxController {
  RxBool isLoading = false.obs;

  RxString selectedMarketplace = "".obs;
  RxString selectedRole = "".obs;

  final marketplaces = [
    {"title": "Material Marketplace", "icon": Asset.materialMarketplace},
    {
      "title": "Construction-Line Marketplace",
      "icon": Asset.constructionCinemarketPlace,
    },
    {"title": "Logistic Marketplace", "icon": Asset.logisticMarketPlace},
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
}
