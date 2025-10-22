import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/models/ConnectorSelectedProductModel.dart';

class NewProductServices {
  ApiManager apiManager = ApiManager();

  Future<ConnectorSelectedProductModel> recentlyProduct({
    int? days = 7,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      const String url = APIConstants.recentlyProduct;
      final Map<String, dynamic> body = {
        // "page": page,
        // "limit": limit,
        "days": 100,
      };

      debugPrint('Calling API: $url');
      // ✅ Send POST request via your apiManager
      final response = await apiManager.get(url: url, params: body);
      debugPrint('Response: $response');

      return ConnectorSelectedProductModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}
