import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';

class GetAllRoleService {
  final ApiManager _apiManager = ApiManager();

  Future<GetAllRoleModel> fetchAllRoles() async {
    try {
      final response = await _apiManager.get(url: APIConstants.getAllRole);
      return GetAllRoleModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error fetching roles: $e , $st');
    }
  }

  Future<TeamListModel> fetchAllTeam() async {
    try {
      final response = await _apiManager.get(url: APIConstants.team);
      return TeamListModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error fetching teams: $e , $st');
    }
  }

  Future<void> deleteRole(int roleId) async {
    try {
      await _apiManager.delete(
        url: APIConstants.deleteRole + roleId.toString(),
      );
    } catch (e, st) {
      throw Exception('Error deleting role: $e , $st');
    }
  }
}
