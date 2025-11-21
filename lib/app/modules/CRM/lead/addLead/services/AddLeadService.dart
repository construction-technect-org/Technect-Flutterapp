import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead/addLead/model/user_info_model.dart';

class AddLeadServices {
  final ApiManager _apiManager = ApiManager();

  Future<UserInfoModel> getIndoByNumber({String? number, String? countryCode}) async {
    try {
      final data = {"mobile_number": number, "country_code": countryCode};
      const String url = APIConstants.autoFill;
      debugPrint('Calling API: $url');
      final response = await _apiManager.get(url: url, params: data);
      debugPrint('Response: $response');

      return UserInfoModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }


  Future<UserInfoModel> addManualLead({required Map<String, dynamic> data}) async {
    try {
      const String url = APIConstants.addLead;
      final Map<String, dynamic> body = data;

      final response = await _apiManager.postObject(url: url, body: body);

      return UserInfoModel.fromJson(response);
    } catch (e) {
      throw Exception('Error searching services: $e');
    }
  }
}
