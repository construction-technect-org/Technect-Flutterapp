import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';

class GetAllRoleService {
  final ApiManager _apiManager = ApiManager();

  Future<GetAllRoleModel?> fetchAllRoles() async {
    try {
      final response = await _apiManager.get(url: APIConstants.getAllRole);
      if (response != null) {
        return GetAllRoleModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching roles: $e");
    }
    return null;
  }
}
