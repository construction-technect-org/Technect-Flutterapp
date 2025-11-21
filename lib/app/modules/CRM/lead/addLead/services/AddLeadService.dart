import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead/addLead/model/user_info_model.dart';

class AddLeadServices {
  ApiManager apiManager = ApiManager();

  Future<UserInfoModel> getIndoByNumber({String? number, String? countryCode}) async {
    try {
      final data = {"mobile_number": number, "country_code": countryCode};
      const String url = APIConstants.autoFill;
      debugPrint('Calling API: $url');
      final response = await apiManager.get(url: url, params: data);
      debugPrint('Response: $response');

      return UserInfoModel.fromJson(response);
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      throw Exception('Error fetching products: $e');
    }
  }
}
