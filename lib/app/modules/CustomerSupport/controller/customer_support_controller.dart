import 'package:construction_technect/app/core/utils/imports.dart';

class CustomerSupportController extends GetxController {
  // Static list of categories
  final List<String> mainCategories = [
    "Construction",
    "Electrical",
    "Plumbing",
    "Interior",
    "Painting",
  ];

  // Selected category
  RxString selectedMainCategory = "".obs;

  bool isEdit = false;

  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }
}
