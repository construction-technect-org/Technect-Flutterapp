// lib/app/modules/Connector/SelectMainCategory/controllers/select_main_category_controller.dart

import 'package:construction_technect/app/core/utils/imports.dart';

class SelectMainCategoryController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt selectedCategory = (-1).obs;      // No category selected initially
  RxInt selectedSubCategory = (-1).obs;   // No sub-category selected initially
  RxInt selectedProduct = (-1).obs;       // No product selected initially

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Construction Material',
      'image': Asset.Product,
    },
    {
      'title': 'Interior Material',
      'image': Asset.Product,
    },
  ];
}
