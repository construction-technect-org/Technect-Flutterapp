import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';

class NewsService {
  final ApiManager _apiManager = ApiManager();

  Future<NewsModel> getNews() async {
    try {
      final response = await _apiManager.get(url: APIConstants.newsMerchant);
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
