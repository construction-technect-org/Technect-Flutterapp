import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/services/connector_home_service.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  ConnectorHomeService connectorHomeService = ConnectorHomeService();

  final RxList<SubCategory> subCategoryList = <SubCategory>[].obs;
  final RxInt selectedIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final selectedCategoryName = ''.obs;
  Future<void> loadSubCategory({
    required String categoryId,
    required int index,
    required String categoryName,
  }) async {
    selectedIndex.value = index; // 👈 LEFT SELECT
    selectedCategoryName.value = categoryName;
    isLoading.value = true;
    subCategoryList.clear();

    try {
      final response =
      await connectorHomeService.getSubCategory(categoryId);
      subCategoryList.value = response.data ?? [];
    } catch (e) {
      subCategoryList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}

