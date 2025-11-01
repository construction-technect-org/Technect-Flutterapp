import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';

class SearchLineServices {
  final ApiManager _apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> searchProducts({
    required String query,
  }) async {
    try {
      const String url = APIConstants.searchProduct;
      final Map<String, dynamic> body = {'search_text': query};

      final response = await _apiManager.postObject(url: url, body: body);

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}
