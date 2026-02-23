import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/AddRolemodel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/models/UpdatedRoleModel.dart';
import 'package:construction_technect/main.dart';

class RoleService {
  static final ApiManager _apiManager = ApiManager();

  static Future<AddRoleModel> createRole({
    required String roleName,
    required String description,
    required List<String> permissions,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.addRole,
        body: {
          "profileId": myPref.profileId.val,
          "profileType": myPref.getRole() == "partner" ? "merchant" : myPref.getRole(),
          "roleName": roleName,           // ✅ API field
          "description": description,     // ✅ API field
          "permissions": permissions,     // ✅ API field — codes list
        },
      );
      return AddRoleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UpdatedRoleModel> updateRole({
    required String roleId,
    required String roleName,
    required String description,
    required List<String> permissions,
  }) async {
    try {
      final response = await _apiManager.putObject(
        url: "${APIConstants.updateRole}/$roleId",
        body: {
          "roleName": roleName,           // ✅ updated field
          "description": description,     // ✅ updated field
          "permissions": permissions,     // ✅ updated field
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
