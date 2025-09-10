import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductManagement/model/product_model.dart';

class ProductManagementService {
  ApiManager apiManager = ApiManager();

  Future<ProductListModel> getProductList() async {
    try {
      final response = await apiManager.get(url: APIConstants.getProductList);
      return ProductListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in productsBySubCategory: $e , $st');
    }
  }
}
