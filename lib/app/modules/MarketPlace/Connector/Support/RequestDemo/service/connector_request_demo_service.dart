import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/RequestDemo/model/demo_requet_create_model.dart';

class ConnectorRequestDemoService {
  static final ApiManager _apiManager = ApiManager();

  static Future<DemoRequestCreateModel?> addRequestDemo({
    required String phone,
    required String email,
    required String demoFor,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.connectorDemoRequestCreate,
        body: {"demo_for": demoFor, "phone_number": phone, "email": email},
      );
      return DemoRequestCreateModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }
}
