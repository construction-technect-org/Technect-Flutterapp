import 'dart:developer';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';

class FAQService {
  final ApiManager _apiManager = ApiManager();



  Future<FAQModel?> fetchAllRoles() async {
    try {
      final response = await _apiManager.get(url: APIConstants.faq);
      if (response != null) {
        return FAQModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }
}
