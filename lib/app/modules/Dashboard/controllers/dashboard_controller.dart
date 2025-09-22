import 'package:construction_technect/app/core/utils/imports.dart';

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
}
