import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/services/connector_home_service.dart';
import 'package:get/get.dart';


class SubCategoryController extends GetxController {
  final ConnectorHomeService connectorHomeService =
  ConnectorHomeService();

  /// 🔥 COMMON LOADING
  final RxBool isLoading = false.obs;

  /// 🔥 SUB CATEGORY
  final RxList<SubCategory> subCategoryList =
      <SubCategory>[].obs;
  final RxInt selectedSubCategoryIndex = 0.obs;
  final RxString selectedCategoryName = ''.obs;

  /// 🔥 PRODUCT CATEGORY
  final RxList<SubCategoryItem> productList =
      <SubCategoryItem>[].obs;
  final RxInt selectedProductIndex = 0.obs;

  final RxBool isGridView = false.obs;

  // ===============================
  // ✅ LOAD SUB CATEGORY
  // ===============================
  Future<void> loadSubCategory({
    required String categoryId,
    required int index,
    required String categoryName,
  }) async {
    selectedSubCategoryIndex.value = index;
    selectedCategoryName.value = categoryName;

    isLoading.value = true;
    subCategoryList.clear();
    productList.clear();

    try {
      final response =
      await connectorHomeService.getSubCategory(categoryId);

      subCategoryList.assignAll(response.data ?? []);

      /// 🔥 AUTO CALL FIRST PRODUCT
      if (subCategoryList.isNotEmpty) {
        await loadProductCategory(
          subCategoryId: subCategoryList.first.id,
          index: selectedSubCategoryIndex.value,
        );
      }

    } catch (e) {
      subCategoryList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // ===============================
  // ✅ LOAD PRODUCT CATEGORY
  // ===============================
  Future<void> loadProductCategory({
    required String subCategoryId,
    required int index,
  }) async {
    selectedProductIndex.value = index;

    productList.clear();

    try {
      final response =
      await connectorHomeService.getSubCategoryItem(subCategoryId);

      productList.assignAll(response.data ?? []);

    } catch (e) {
      productList.clear();
    }
  }
}