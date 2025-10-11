import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';

class NewsService {
  final ApiManager _apiManager = ApiManager();

  Future<NewsModel> getNews({required bool isConnector}) async {
    try {
      final response = await _apiManager.get(
        url: !isConnector
            ? APIConstants.newsMerchant
            : APIConstants.newsConnector,
      );
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
