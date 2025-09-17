import 'package:construction_technect/app/core/utils/imports.dart';

class SelectMainCategoryController extends GetxController {
  RxInt selectedCategory = 0.obs;
  RxInt selectedSubCategory = 0.obs;
  RxInt selectedProduct = 0.obs;

  final List<Map<String, dynamic>> categories = [
    {'title': 'Construction Material', 'image': Asset.Product},
    {'title': 'Interior Material', 'image': Asset.Product},
  ];

  /// Subcategories and products for each main category
  final Map<int, List<Map<String, dynamic>>> allSubCategories = {
    0: [
      {'name': 'Sand', 'image': Asset.Product},
      {'name': 'Gravel', 'image': Asset.Product},
    ],
    1: [
      {'name': 'Tiles', 'image': Asset.Product},
      {'name': 'Wallpaper', 'image': Asset.Product},
    ],
  };

  final Map<int, List<Map<String, dynamic>>> allProducts = {
    0: [
      {'name': 'Manufactured Sand', 'image': Asset.Product},
      {'name': 'Concrete Sand', 'image': Asset.Product},
      {'name': 'Plastering Sand', 'image': Asset.Product},
      {'name': 'River Sand', 'image': Asset.Product},
      {'name': 'Dust', 'image': Asset.Product},
    ],
    1: [
      {'name': 'Wall Tiles', 'image': Asset.Product},
      {'name': 'Floor Tiles', 'image': Asset.Product},
      {'name': 'Vinyl Wallpaper', 'image': Asset.Product},
      {'name': 'Textured Wallpaper', 'image': Asset.Product},
    ],
  };

  RxList<Map<String, dynamic>> subCategories = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSubCategoriesAndProducts(0);
  }

  void selectCategory(int index) {
    selectedCategory.value = index;
    selectedSubCategory.value = 0;
    selectedProduct.value = 0;
    loadSubCategoriesAndProducts(index);
  }

  void selectSubCategory(int index) {
    selectedSubCategory.value = index;
    // You can also load different products based on subcategory if needed
  }

  void selectProduct(int index) {
    selectedProduct.value = index;

    // Navigate to ListOfMerchantView automatically
    Get.toNamed(Routes.LIST_OF_MERCHANT);
  }

  void loadSubCategoriesAndProducts(int categoryIndex) {
    subCategories.value = allSubCategories[categoryIndex] ?? [];
    products.value = allProducts[categoryIndex] ?? [];
  }
}
