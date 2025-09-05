// lib/app/modules/AddRole/services/add_role_service.dart

import 'dart:developer';
import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/AddRole/models/AddRoleModel.dart';
import 'package:construction_technect/app/modules/AddRole/models/UpdatedRoleModel.dart';

class AddRoleService {
  static final ApiManager _apiManager = ApiManager();





   // AddRolemodel
  static Future<AddRolemodel?> createRole({
    required int merchantProfileId,
    required String roleTitle,
    required String roleDescription,
    required List<String> functionalities,
    required bool isActive,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.addRole, // ✅ should not be login
       body:  {
        "merchant_profile_id": merchantProfileId,
        "role_title": roleTitle,
        "role_description": roleDescription,
        "functionalities": functionalities.join(","), // ✅ backend expects string
        "is_active": isActive,
      }
      );

      log("⬅️ Response: $response");

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
      return AddRolemodel(
        success: false,
        data: null,
        message: e.toString(),
      );
    }
  }
}

// UpdateRoleService Api 

class UpdateRoleService {
  static final ApiManager _apiManager = ApiManager();

  static Future<UpdatedRoleModel?> updateRole({
    required int roleId,
    required int merchantProfileId,
    required String roleTitle,
    required String roleDescription,
    required List<String> functionalities,
    required bool isActive,
  }) async {
    try {
      final response = await _apiManager.putObject(
        url: "${APIConstants.updateRole}/$roleId", // ✅ pass role id in URL
        body: {
          "merchant_profile_id": merchantProfileId,
          "role_title": roleTitle,
          "role_description": roleDescription,
          "functionalities": functionalities.join(","), // ✅ backend expects string
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
      return UpdatedRoleModel(
        success: false,
        data: null,
        message: e.toString(),
      );
    }
  }


}




