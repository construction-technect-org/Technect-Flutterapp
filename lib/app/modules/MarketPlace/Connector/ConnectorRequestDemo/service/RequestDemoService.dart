import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';

class RequestDemoService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRolemodel?> addRequestDemo({
    required String phone,
    required String email,
    required String demoFor,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.demoRequest,
        body: {"demo_for": demoFor, "phone_number": phone, "email": email},
      );

      if (response != null) {
        return AddRolemodel.fromJson(response);
      } else {
        return AddRolemodel(
          success: false,
          data: null,
          message: "Null response from server",
        );
      }
    } catch (e) {
      log("❌ Error: $e");
      return AddRolemodel(success: false, data: null, message: e.toString());
    }
  }
}
