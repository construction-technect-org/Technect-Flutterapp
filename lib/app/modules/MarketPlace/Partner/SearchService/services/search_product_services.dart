import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/models/ConnectorServiceModel.dart';

class SearchServiceServices {
  final ApiManager _apiManager = ApiManager();

  Future<ConnectorServiceModel> searchServices({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      const String url = APIConstants.searchService;
      final Map<String, dynamic> body = {
        'search_text': query,
        'page': page,
        'limit': limit,
      };

      final response = await _apiManager.postObject(url: url, body: body);

      return ConnectorServiceModel.fromJson(response);
    } catch (e) {
      throw Exception('Error searching services: $e');
    }
  }
}
