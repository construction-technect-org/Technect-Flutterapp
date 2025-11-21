import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/model/lead_model.dart';

class MarketingServices {
  final ApiManager _apiManager = ApiManager();

  Future<AllLeadModel> getAllLead({String? status,}) async {
    try {
      // final data = {"status": status,};
      const String url = APIConstants.addLead;
      debugPrint('Calling API: $url');
      // final response = await _apiManager.get(url: url, params: data);
      final response = await _apiManager.get(url: url,);
      debugPrint('Response: $response');
      return AllLeadModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }


}
