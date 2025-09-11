import 'dart:developer';

import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/TeamStatsModel.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPreference {
  GetStorage? getStorage;

  Future<AppSharedPreference> initializeStorage() async {
    getStorage = GetStorage();
    await GetStorage.init();
    return this;
  }

  final token = ''.val('token');
  final userModel = <String, dynamic>{}.val('userModel');
  final savedMobileNumber = ''.val('savedMobileNumber');
  final savedPassword = ''.val('savedPassword');
  final rememberMe = false.val('rememberMe');
  final addressData = <String, dynamic>{}.val('addressData');
  final profileData = <String, dynamic>{}.val('profileData');
  final addressDataTimestamp = 0.val('addressDataTimestamp');
  final profileDataTimestamp = 0.val('profileDataTimestamp');
  final rolesData = <String, dynamic>{}.val('rolesData');
  final rolesDataTimestamp = 0.val('rolesDataTimestamp');
  final teamData = <String, dynamic>{}.val('teamData');
  final teamStatsData = <String, dynamic>{}.val('teamStatsData');

  void setToken(String authToken) {
    token.val = authToken;
  }

  String getToken() {
    return token.val;
  }

  void setUserModel(UserModel user) {
    userModel.val = user.toJson();
  }

  UserModel? getUserModel() {
    final userData = userModel.val;
    return UserModel.fromJson(userData);
  }

  // Remember Me functionality
  void saveCredentials(String mobileNumber, String password) {
    savedMobileNumber.val = mobileNumber;
    savedPassword.val = password;
    rememberMe.val = true;
  }

  void clearCredentials() {
    savedMobileNumber.val = '';
    savedPassword.val = '';
    rememberMe.val = false;
  }

  String getSavedMobileNumber() {
    return savedMobileNumber.val;
  }

  String getSavedPassword() {
    return savedPassword.val;
  }

  bool isRememberMeEnabled() {
    return rememberMe.val;
  }

  void clear() {
    final GetStorage storage = GetStorage();
    storage.erase();
  }

  void logout() {
    token.val = '';
    userModel.val = {};
    addressData.val = {};
    profileData.val = {};
    rolesData.val = {};
    teamData.val = {};
    teamStatsData.val = {};
  }

  // Address data storage
  void setAddressData(Map<String, dynamic> address) {
    addressData.val = address;
    addressDataTimestamp.val = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic>? getAddressData() {
    final data = addressData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  int getAddressDataTimestamp() {
    return addressDataTimestamp.val;
  }

  void clearAddressData() {
    addressData.val = {};
    addressDataTimestamp.val = 0;
  }

  // Profile data storage
  void setProfileData(Map<String, dynamic> profile) {
    profileData.val = profile;
  }

  Map<String, dynamic>? getProfileData() {
    final data = profileData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  void clearProfileData() {
    profileData.val = {};
  }

  // Roles data storage
  void setRolesData(Map<String, dynamic> roles) {
    rolesData.val = roles;
    rolesDataTimestamp.val = DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic>? getRolesData() {
    final data = rolesData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  int getRolesDataTimestamp() {
    return rolesDataTimestamp.val;
  }

  void clearRolesData() {
    rolesData.val = {};
    rolesDataTimestamp.val = 0;
  }

  // Helper methods for roles
  Future<void> saveRoles(List<GetAllRole> roles) async {
    try {
      final rolesJson = roles.map((role) => role.toJson()).toList();
      setRolesData({
        'data': rolesJson,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      log('Error saving roles: $e');
    }
  }

  List<GetAllRole>? getRoles() {
    try {
      final data = getRolesData();
      if (data != null && data['data'] != null) {
        final rolesList = (data['data'] as List)
            .map((roleJson) => GetAllRole.fromJson(roleJson))
            .toList();
        return rolesList;
      }
    } catch (e) {
      log('Error getting roles: $e');
    }
    return null;
  }

  // Team data storage
  void setTeamData(Map<String, dynamic> team) {
    teamData.val = team;
  }

  Map<String, dynamic>? getTeamData() {
    final data = teamData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  void clearTeamData() {
    teamData.val = {};
  }

  // Helper methods for team
  Future<void> saveTeam(List<TeamListData> team) async {
    try {
      final teamJson = team.map((member) => member.toJson()).toList();
      setTeamData({'data': teamJson, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    } catch (e) {
      log('Error saving team: $e');
    }
  }

  List<TeamListData>? getTeam() {
    try {
      final data = getTeamData();
      if (data != null && data['data'] != null) {
        final teamList = (data['data'] as List)
            .map((memberJson) => TeamListData.fromJson(memberJson))
            .toList();
        return teamList;
      }
    } catch (e) {
      log('Error getting team: $e');
    }
    return null;
  }

  // Team stats data storage
  void setTeamStatsData(Map<String, dynamic> stats) {
    teamStatsData.val = stats;
  }

  Map<String, dynamic>? getTeamStatsData() {
    final data = teamStatsData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  void clearTeamStatsData() {
    teamStatsData.val = {};
  }

  // Helper methods for team stats
  Future<void> saveTeamStats(TeamStatsModel stats) async {
    try {
      setTeamStatsData({
        'data': stats.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      log('Error saving team stats: $e');
    }
  }

  TeamStatsModel? getTeamStats() {
    try {
      final data = getTeamStatsData();
      if (data != null && data['data'] != null) {
        return TeamStatsModel.fromJson(data['data']);
      }
    } catch (e) {
      log('Error getting team stats: $e');
    }
    return null;
  }
}
