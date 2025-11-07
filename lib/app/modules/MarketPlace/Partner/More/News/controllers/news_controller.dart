import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();

  RxBool isLoading = false.obs;
  RxBool isConnector = false.obs;
  Rx<NewsModel> newsModel = NewsModel().obs;

  @override
  void onInit() {
    super.onInit();
    isConnector.value = myPref.getRole() == "connector";
    fetchNews();
  }

  Future<void> _loadNewsFromStorage() async {
    final cachedNewsModel = myPref.getNewsModel();
    if (cachedNewsModel != null) {
      newsModel.value = cachedNewsModel;
    } else {
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      final result = await _newsService.getNews(isConnector: isConnector.value);
      if (result.success == true) {
        newsModel.value = result;
        myPref.setNewsModel(result);
      } else {
        await _loadNewsFromStorage();
      }
    } catch (e) {
      await _loadNewsFromStorage();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    await fetchNews();
  }
}
