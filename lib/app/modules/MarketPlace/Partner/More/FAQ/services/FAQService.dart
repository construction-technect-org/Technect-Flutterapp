import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';

class FAQService {
  final ApiManager _apiManager = ApiManager();

  Future<FAQModel> fetchAllFAQs() async {
    try {
      final response = await _apiManager.get(url: APIConstants.faq);
      return FAQModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching FAQs: $e');
    }
  }
}
