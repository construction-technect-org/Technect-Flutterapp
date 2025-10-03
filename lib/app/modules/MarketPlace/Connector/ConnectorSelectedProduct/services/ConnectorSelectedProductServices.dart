import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';

class ConnectorSelectedProductServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> connectorProduct({
    int? mainCategoryId,
    int? subCategoryId,
    int? categoryProductId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      String url = "${APIConstants.connectorProdcut}?";
      if (mainCategoryId != null) url += 'main_category_id=$mainCategoryId&';
      if (subCategoryId != null) url += 'sub_category_id=$subCategoryId&';
      if (categoryProductId != null) url += 'category_product_id=$categoryProductId&';
      url += 'page=$page&limit=$limit';

      debugPrint('Calling API: $url');

      final response = await apiManager.get(url: url);

      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}




 