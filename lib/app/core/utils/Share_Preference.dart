import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/ConnectionInbox/model/connectionModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/models/notification_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart'
    as ProductModel;
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart'
    hide Statistics;
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPreference {
  GetStorage? getStorage;

  Future<AppSharedPreference> initializeStorage() async {
    getStorage = GetStorage();
    await GetStorage.init();
    return this;
  }

  final token = ''.val('token');
  final isOffice = true.val('isOffice');
  final role = ''.val('role');
  final userModel = <String, dynamic>{}.val('userModel');
  final savedMobileNumber = ''.val('savedMobileNumber');
  final savedPassword = ''.val('savedPassword');
  final rememberMe = false.val('rememberMe');
  final addressData = <String, dynamic>{}.val('addressData');
  final profileData = <String, dynamic>{}.val('profileData');
  final addressDataTimestamp = 0.val('addressDataTimestamp');
  final profileDataTimestamp = 0.val('profileDataTimestamp');
  final rolesData = <String, dynamic>{}.val('rolesData');
  final teamData = <String, dynamic>{}.val('teamData');
  final teamStatsData = <String, dynamic>{}.val('teamStatsData');
  final faqData = <String, dynamic>{}.val('faqData');
  final cachedCategories = ''.val('cachedCategories');
  final cachedPriorities = ''.val('cachedPriorities');
  final cachedConnectorCategories = ''.val('cachedConnectorCategories');
  final cachedConnectorPriorities = ''.val('cachedConnectorPriorities');
  final productsData = <String, dynamic>{}.val('productsData');
  final supportTicketsData = <String, dynamic>{}.val('supportTicketsData');
  final connectorSupportTicketsData = <String, dynamic>{}.val(
    'connectorSupportTicketsData',
  );
  final newsData = <String, dynamic>{}.val('newsData');
  final notificationData = <String, dynamic>{}.val('notificationData');

  void setToken(String authToken) {
    token.val = authToken;
  }

  String getToken() {
    return token.val;
  }

  void setRole(String newRole) {
    role.val = newRole;
  }

  String getRole() {
    return role.val;
  }

  void setDefaultAdd(bool isDefaultOffice) {
    isOffice.val = isDefaultOffice;
  }

  bool getDefaultAdd() {
    return isOffice.val;
  }

  void setUserModel(UserModel user) {
    userModel.val = user.toJson();
  }

  UserModel? getUserModel() {
    final userData = userModel.val;
    return UserModel.fromJson(userData);
  }

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
    role.val = '';
    isOffice.val = false;
    userModel.val = {};
    addressData.val = {};
    profileData.val = {};
    rolesData.val = {};
    teamData.val = {};
    teamStatsData.val = {};
  }

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

  void setRolesData(Map<String, dynamic> roles) {
    rolesData.val = roles;
  }

  Map<String, dynamic>? getRolesData() {
    final data = rolesData.val;
    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  void clearRolesData() {
    rolesData.val = {};
  }

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

  void setCategoriesData(List<SupportCategory> categories) {
    try {
      final categoriesJson = categories.map((category) => category.toJson()).toList();
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
        return categoriesJson.map((json) => SupportCategory.fromJson(json)).toList();
      }
    } catch (e) {
      log('Error getting categories: $e');
    }
    return null;
  }

  void setPrioritiesData(List<SupportPriority> priorities) {
    try {
      final prioritiesJson = priorities.map((priority) => priority.toJson()).toList();
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
        return prioritiesJson.map((json) => SupportPriority.fromJson(json)).toList();
      }
    } catch (e) {
      log('Error getting priorities: $e');
    }
    return null;
  }

  void setRoleModelData(GetAllRoleModel roleModel) {
    try {
      rolesData.val = roleModel.toJson();
    } catch (e) {
      log('Error saving role model: $e');
    }
  }

  GetAllRoleModel? getRoleModelData() {
    try {
      final data = rolesData.val;
      if (data.isNotEmpty) {
        return GetAllRoleModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting role model: $e');
    }
    return null;
  }

  void setTeamModelData(TeamListModel teamModel) {
    try {
      teamData.val = teamModel.toJson();
    } catch (e) {
      log('Error saving team model: $e');
    }
  }

  TeamListModel? getTeamModelData() {
    try {
      final data = teamData.val;
      if (data.isNotEmpty) {
        return TeamListModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting team model: $e');
    }
    return null;
  }

  void setProductListModel(ProductModel.ProductListModel productListModel) {
    try {
      productsData.val = productListModel.toJson();
    } catch (e) {
      log('Error saving product list model: $e');
    }
  }

  ProductModel.ProductListModel? getProductListModel() {
    try {
      final data = productsData.val;
      if (data.isNotEmpty) {
        return ProductModel.ProductListModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting product list model: $e');
    }
    return null;
  }

  void setSupportTicketsModel(SupportMyTicketsModel supportTicketsModel) {
    try {
      supportTicketsData.val = supportTicketsModel.toJson();
    } catch (e) {
      log('Error saving support tickets model: $e');
    }
  }

  SupportMyTicketsModel? getSupportTicketsModel() {
    try {
      final data = supportTicketsData.val;
      if (data.isNotEmpty) {
        return SupportMyTicketsModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting support tickets model: $e');
    }
    return null;
  }

  // Connector Support Methods
  void setConnectorCategoriesData(List<SupportCategory> categories) {
    try {
      final categoriesJson = categories.map((category) => category.toJson()).toList();
      cachedConnectorCategories.val = jsonEncode(categoriesJson);
    } catch (e) {
      log('Error saving connector categories: $e');
    }
  }

  List<SupportCategory>? getConnectorCategoriesData() {
    try {
      final cachedData = cachedConnectorCategories.val;
      if (cachedData.isNotEmpty) {
        final List<dynamic> categoriesJson = jsonDecode(cachedData);
        return categoriesJson.map((json) => SupportCategory.fromJson(json)).toList();
      }
    } catch (e) {
      log('Error getting connector categories: $e');
    }
    return null;
  }

  void setConnectorPrioritiesData(List<SupportPriority> priorities) {
    try {
      final prioritiesJson = priorities.map((priority) => priority.toJson()).toList();
      cachedConnectorPriorities.val = jsonEncode(prioritiesJson);
    } catch (e) {
      log('Error saving connector priorities: $e');
    }
  }

  List<SupportPriority>? getConnectorPrioritiesData() {
    try {
      final cachedData = cachedConnectorPriorities.val;
      if (cachedData.isNotEmpty) {
        final List<dynamic> prioritiesJson = jsonDecode(cachedData);
        return prioritiesJson.map((json) => SupportPriority.fromJson(json)).toList();
      }
    } catch (e) {
      log('Error getting connector priorities: $e');
    }
    return null;
  }

  void setConnectorSupportTicketsModel(SupportMyTicketsModel supportTicketsModel) {
    try {
      connectorSupportTicketsData.val = supportTicketsModel.toJson();
    } catch (e) {
      log('Error saving connector support tickets model: $e');
    }
  }

  SupportMyTicketsModel? getConnectorSupportTicketsModel() {
    try {
      final data = connectorSupportTicketsData.val;
      if (data.isNotEmpty) {
        return SupportMyTicketsModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting connector support tickets model: $e');
    }
    return null;
  }

  void setNewsModel(NewsModel newsModel) {
    try {
      newsData.val = newsModel.toJson();
    } catch (e) {
      log('Error saving news model: $e');
    }
  }

  NewsModel? getNewsModel() {
    try {
      final data = newsData.val;
      if (data.isNotEmpty) {
        return NewsModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting news model: $e');
    }
    return null;
  }

  void setNotificationModel(NotificationModel notificationModel) {
    notificationData.val = notificationModel.toJson();
  }

  NotificationModel? getNotificationModel() {
    try {
      final data = notificationData.val;
      if (data.isNotEmpty) {
        return NotificationModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting notification model: $e');
    }
    return null;
  }
}
