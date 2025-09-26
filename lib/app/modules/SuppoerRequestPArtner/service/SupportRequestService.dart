import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/AddRole/models/AddRolemodel.dart';
import 'package:construction_technect/app/modules/AddRole/models/UpdatedRoleModel.dart';

class SupportRequestService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRolemodel?> addFeedback({
    required int rating,
    required String text,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.merchantFeedback,
        body: {
          "rating": rating,
          "feedback_text": text,
          "feedback_type": "general",
          "is_anonymous": false,
        },
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

  static Future<UpdatedRoleModel?> updateRole({
    required int roleId,
    required String roleTitle,
    required String roleDescription,
    required String functionalities,
    required bool isActive,
  }) async {
    try {
      final response = await _apiManager.putObject(
        url: "${APIConstants.updateRole}/$roleId", // ✅ pass role id in URL
        body: {
          "role_title": roleTitle,
          "role_description": roleDescription,
          "functionalities": functionalities, // ✅ backend expects string
          "is_active": isActive,
        },
      );

      log("⬅️ Update Response: $response");

      if (response != null) {
        return UpdatedRoleModel.fromJson(response);
      } else {
        return UpdatedRoleModel(
          success: false,
          data: null,
          message: "Null response from server",
        );
      }
    } catch (e) {
      log("❌ Update Error: $e");
      return UpdatedRoleModel(success: false, data: null, message: e.toString());
    }
  }
}
