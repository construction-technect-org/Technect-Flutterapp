import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/services/connector_home_service.dart';
import 'package:get/get.dart';

class SubCategoryItemController extends GetxController {
  ConnectorHomeService connectorHomeService = ConnectorHomeService();

  final RxList<SubCategoryItem> subCategoryItemList = <SubCategoryItem>[].obs;
  final RxInt selectedIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final selectedCategoryItemName = ''.obs;
  Future<void> loadSubCategoryItem({
    required String subCategoryId,
    required int index,
    required String subCategoryName,
  }) async {
    selectedIndex.value = index; // 👈 LEFT SELECT
    selectedCategoryItemName.value = subCategoryName;
    isLoading.value = true;
    subCategoryItemList.clear();

    try {
      final response =
      await connectorHomeService.getSubCategoryItem(subCategoryId);
      subCategoryItemList.value = response.data ?? [];
    } catch (e) {
      subCategoryItemList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}

