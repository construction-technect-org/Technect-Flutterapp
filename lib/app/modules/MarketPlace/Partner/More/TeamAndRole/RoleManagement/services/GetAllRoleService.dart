import 'dart:developer';

import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/TeamStatsModel.dart';

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

  Future<TeamListModel?> fetchAllTeam() async {
    try {
      final response = await _apiManager.get(url: APIConstants.team);
      if (response != null) {
        return TeamListModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching teams: $e");
    }
    return null;
  }

  Future<TeamStatsModel?> fetchTeamStatsOverview() async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.teamStatsOverview,
      );
      if (response != null) {
        return TeamStatsModel.fromJson(response);
      }
    } catch (e) {
      log("Error fetching team stats: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> deleteRole(int roleId) async {
    try {
      final response = await _apiManager.delete(
        url: APIConstants.deleteRole + roleId.toString(),
      );
      if (response != null) {
        return response as Map<String, dynamic>;
      }
    } catch (e) {
      log("Error deleting role: $e");
    }
    return null;
  }
}
