import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:construction_technect/app/modules/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
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
  final faqData = <String, dynamic>{}.val('faqData');
  final cachedCategories = ''.val('cachedCategories');
  final cachedPriorities = ''.val('cachedPriorities');

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
      setTeamData({
        'data': teamJson,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
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
  Future<void> saveTeamStats(Statistics stats) async {
    try {
      setTeamStatsData({
        'data': stats.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      log('Error saving team stats: $e');
    }
  }

  Future<void> saveStatistics(Statistics stats) async {
    try {
      setTeamStatsData({
        'data': stats.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      log('Error saving statistics: $e');
    }
  }

  Statistics? getStatistics() {
    try {
      final data = getTeamStatsData();
      if (data != null && data['data'] != null) {
        return Statistics.fromJson(data['data']);
      }
    } catch (e) {
      log('Error getting statistics: $e');
    }
    return null;
  }

  Statistics? getTeamStats() {
    try {
      final data = getTeamStatsData();
      if (data != null && data['data'] != null) {
        return Statistics.fromJson(data['data']);
      }
    } catch (e) {
      log('Error getting team stats: $e');
    }
    return null;
  }

  // Role stats data storage
  final roleStatsData = <String, dynamic>{}.val('roleStatsData');

  void setRoleStatsData(Map<String, dynamic> stats) {
    roleStatsData.val = stats;
  }

  Map<String, dynamic>? getRoleStatsData() {
    final data = roleStatsData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  void clearRoleStatsData() {
    roleStatsData.val = {};
  }

  // Helper methods for role stats
  Future<void> saveRoleStats(Statistics stats) async {
    try {
      setRoleStatsData({
        'data': stats.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      log('Error saving role stats: $e');
    }
  }

  Statistics? getRoleStats() {
    try {
      final data = getRoleStatsData();
      if (data != null && data['data'] != null) {
        return Statistics.fromJson(data['data']);
      }
    } catch (e) {
      log('Error getting role stats: $e');
    }
    return null;
  }

  void setFAQData(FAQModel faq) {
    faqData.val = faq.toJson();
  }

  FAQModel? getFAQData() {
    final data = faqData.val;
    if (data.isNotEmpty) {
      return FAQModel.fromJson(data);
    }
    return null;
  }

  // Categories data storage
  void setCategoriesData(List<SupportCategory> categories) {
    try {
      final categoriesJson = categories
          .map((category) => category.toJson())
          .toList();
      cachedCategories.val = jsonEncode(categoriesJson);
    } catch (e) {
      log('Error saving categories: $e');
    }
  }

  List<SupportCategory>? getCategoriesData() {
    try {
      final cachedData = cachedCategories.val;
      if (cachedData.isNotEmpty) {
        final List<dynamic> categoriesJson = jsonDecode(cachedData);
        return categoriesJson
            .map((json) => SupportCategory.fromJson(json))
            .toList();
      }
    } catch (e) {
      log('Error getting categories: $e');
    }
    return null;
  }

  // Priorities data storage
  void setPrioritiesData(List<SupportPriority> priorities) {
    try {
      final prioritiesJson = priorities
          .map((priority) => priority.toJson())
          .toList();
      cachedPriorities.val = jsonEncode(prioritiesJson);
    } catch (e) {
      log('Error saving priorities: $e');
    }
  }

  List<SupportPriority>? getPrioritiesData() {
    try {
      final cachedData = cachedPriorities.val;
      if (cachedData.isNotEmpty) {
        final List<dynamic> prioritiesJson = jsonDecode(cachedData);
        return prioritiesJson
            .map((json) => SupportPriority.fromJson(json))
            .toList();
      }
    } catch (e) {
      log('Error getting priorities: $e');
    }
    return null;
  }
}
