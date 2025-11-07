import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/model/demo_requet_create_model.dart';

class RequestDemoService {
  static final ApiManager _apiManager = ApiManager();

  static Future<DemoRequestCreateModel?> addRequestDemo({
    required String phone,
    required String email,
    required String demoFor,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: myPref.role.val == "connector"
            ? APIConstants.connectorDemoRequestCreate
            : APIConstants.demoRequest,
        body: {"demo_for": demoFor, "phone_number": phone, "email": email},
      );

      return DemoRequestCreateModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }
}
