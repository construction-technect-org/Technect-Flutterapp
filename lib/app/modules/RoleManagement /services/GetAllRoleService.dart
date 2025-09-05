// lib/app/modules/role/services/get_all_role_service.dart

import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/RoleManagement%20/models/GetAllRoleModel.dart';

class GetAllRoleService {
  final ApiManager _apiManager = ApiManager();

  Future<GetAllRoleModel?> fetchAllRoles() async {
    try {
            final response = await _apiManager.get(url: APIConstants.getAllRole);


      log("Roles API Response: $response");

      if (response != null) {
        return GetAllRoleModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }
}
