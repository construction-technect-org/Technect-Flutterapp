import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/UpdatedRoleModel.dart';

class RoleService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRolemodel> createRole({
    required String roleTitle,
    required String roleDescription,
    required String functionalities,
    required bool isActive,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.addRole,
        body: {
          "role_title": roleTitle,
          "role_description": roleDescription,
          "functionalities": functionalities,
          "is_active": isActive,
        },
      );

      return AddRolemodel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UpdatedRoleModel> updateRole({
    required int roleId,
    required String roleTitle,
    required String roleDescription,
    required String functionalities,
    required bool isActive,
  }) async {
    try {
      final response = await _apiManager.putObject(
        url: "${APIConstants.updateRole}/$roleId",
        body: {
          "role_title": roleTitle,
          "role_description": roleDescription,
          "functionalities": functionalities,
          "is_active": isActive,
        },
      );

      return UpdatedRoleModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error updating role: $e , $st');
    }
  }

  Future<void> deleteRole(String id) async {
    try {
      await _apiManager.delete(url: "${APIConstants.deleteRole}$id");
    } catch (e, st) {
      throw Exception('Error deleting role: $e , $st');
    }
  }
}
