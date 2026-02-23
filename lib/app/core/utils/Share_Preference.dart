import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/services/fcm_service.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/get_service_requirement_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/models/notification_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/models/news_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/SubCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart'
    as product_model;
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:get/get.dart';

class HiveValue<T> {
  final String key;
  final T defaultValue;

  HiveValue(this.key, this.defaultValue);

  T get val {
    try {
      final storage = Get.find<AppHiveService>();
      return storage.read<T>(key, defaultValue: defaultValue) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  set val(T newValue) {
    try {
      final storage = Get.find<AppHiveService>();
      storage.write<T>(key, newValue);
    } catch (e) {
      log('Error writing to Hive for key $key: $e');
    }
  }
}

class AppSharedPreference {
  Future<AppSharedPreference> initializeStorage() async {
    return this;
  }

  UserMainModel? _cachedUser;
  final token = HiveValue<String>('token', '');
  final tokenType = HiveValue<String>('tokenType', '');
  final phone = HiveValue<String>('phone', '');
  final email = HiveValue<String>('emailID', '');
  final cc = HiveValue<String>('cc', '');
  final kycValid = HiveValue<bool>('kyc', false);
  final dashboard = HiveValue<String>('dashboard', '');
  final isOffice = HiveValue<bool>('isOffice', true);
  final isTeamLogin = HiveValue<bool>('isTeamLogin', false);
  final role = HiveValue<String>('role', '');
  final permissions = HiveValue<String>('permissions', '');
  final userModel = HiveValue<Map<String, dynamic>>('userModel', {});
  final savedMobileNumber = HiveValue<String>('savedMobileNumber', '');
  final savedPassword = HiveValue<String>('savedPassword', '');
  final rememberMe = HiveValue<bool>('rememberMe', false);
  final addressData = HiveValue<Map<String, dynamic>>('addressData', {});
  final profileData = HiveValue<Map<String, dynamic>>('profileData', {});
  final addressDataTimestamp = HiveValue<int>('addressDataTimestamp', 0);
  final profileDataTimestamp = HiveValue<int>('profileDataTimestamp', 0);
  final rolesData = HiveValue<Map<String, dynamic>>('rolesData', {});
  final teamData = HiveValue<Map<String, dynamic>>('teamData', {});
  final teamStatsData = HiveValue<Map<String, dynamic>>('teamStatsData', {});
  final faqData = HiveValue<Map<String, dynamic>>('faqData', {});
  final cachedCategories = HiveValue<String>('cachedCategories', '');
  final cachedPriorities = HiveValue<String>('cachedPriorities', '');
  final cachedConnectorCategories = HiveValue<String>('cachedConnectorCategories', '');
  final cachedConnectorPriorities = HiveValue<String>('cachedConnectorPriorities', '');
  final productsData = HiveValue<Map<String, dynamic>>('productsData', {});
  final supportTicketsData = HiveValue<Map<String, dynamic>>('supportTicketsData', {});
  final connectorSupportTicketsData = HiveValue<Map<String, dynamic>>(
    'connectorSupportTicketsData',
    {},
  );
  final newsData = HiveValue<Map<String, dynamic>>('newsData', {});
  final notificationData = HiveValue<Map<String, dynamic>>('notificationData', {});
  final subCategoryData = HiveValue<Map<String, dynamic>>('subCategoryData', {});
  final categoryHierarchyData = HiveValue<Map<String, dynamic>>('categoryHierarchyData', {});

  final categoryServiceHierarchyData = HiveValue<Map<String, dynamic>>(
    'categoryServiceHierarchyData',
    {},
  );

  final requirementListData = HiveValue<Map<String, dynamic>>('requirementListData', {});
  final serviceRequirementListData = HiveValue<Map<String, dynamic>>(
    'serviceRequirementListData',
    {},
  );
  final profileId = HiveValue<String>('profileId', '');
  final mainCategoriesConstructionId = HiveValue<String>('mainCategoriesConstructionId', '');
  final mainCategoriesInteriorId = HiveValue<String>('mainCategoriesInteriorId', '');
  final roleStatsData = HiveValue<Map<String, dynamic>>('roleStatsData', {});


  void setToken(String authToken) {
    log("Token: $authToken");
    token.val = authToken;
  }

  void setPhone(String phoneNumber) {
    phone.val = phoneNumber;
  }

  void setCC(String countryCode) {
    cc.val = countryCode;
  }

  void setEmail(String emailID1) {
    email.val = emailID1;
  }

  void setKYC(bool kycValid1) {
    kycValid.val = kycValid1;
  }

  bool getKYC() {
    return kycValid.val;
  }

  String getPhone() {
    return phone.val;
  }

  String getEmail() {
    return email.val;
  }

  String getCC() {
    return cc.val;
  }

  void setTokenType(String tokenType1) {
    tokenType.val = tokenType1;
  }

  String getToken() {
    return token.val;
  }

  String getTokenType() {
    return tokenType.val;
  }

  void setDashboard(String dashValue) {
    dashboard.val = dashValue;
  }

  String getDashboard() {
    return dashboard.val;
  }

  void setRole(String newRole) {
    role.val = newRole;
  }

  String getRole() {
    return role.val;
  }

  void setPermissions(String value) {
    permissions.val = value;
  }

  String getPermissions() {
    return permissions.val;
  }

  List<String> getPermissionList() {
    if (permissions.val.isEmpty) return [];
    return permissions.val.split(',').map((e) => e.trim()).toList();
  }

  void setIsTeamLogin(bool isTeamLogined) {
    isTeamLogin.val = isTeamLogined;
  }

  bool getIsTeamLogin() {
    return isTeamLogin.val;
  }

  void setDefaultAdd(bool isDefaultOffice) {
    isOffice.val = isDefaultOffice;
  }

  bool getDefaultAdd() {
    return isOffice.val;
  }

  void setUserModel(UserMainModel user) {
    _cachedUser = user;
    userModel.val = user.toJson();
  }

  UserMainModel? getUserModel() {
    if (_cachedUser != null) return _cachedUser;
    final userData = userModel.val;
    if (userData.isEmpty) return null;
    return UserMainModel.fromJson(Map<String, dynamic>.from(userData));
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
    final AppHiveService storage = Get.find<AppHiveService>();
    storage.clearAll();
  }

  Future<void> logout() async {
    try {
      final AppHiveService appHiveService = Get.find<AppHiveService>();
      await appHiveService.logout();
      // Ensure FCM Token is deleted on logout
      await FCMService.deleteToken();
    } catch (e) {
      log("Error Deleting all data $e");
    }
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
      setRolesData({'data': rolesJson, 'timestamp': DateTime.now().millisecondsSinceEpoch});
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

  void setProductListModel(product_model.ProductListModel productListModel) {
    try {
      productsData.val = productListModel.toJson();
    } catch (e) {
      log('Error saving product list model: $e');
    }
  }

  product_model.ProductListModel? getProductListModel() {
    try {
      final data = productsData.val;
      if (data.isNotEmpty) {
        return product_model.ProductListModel.fromJson(data);
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

  // Sub Category Storage Methods
  void setSubCategoryModel(SubCategoryModel subCategoryModel) {
    try {
      subCategoryData.val = subCategoryModel.toJson();
    } catch (e) {
      log('Error saving sub category model: $e');
    }
  }

  SubCategoryModel? getSubCategoryModel() {
    try {
      final data = subCategoryData.val;
      if (data.isNotEmpty) {
        return SubCategoryModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting sub category model: $e');
    }
    return null;
  }

  void clearSubCategoryData() {
    subCategoryData.val = {};
  }

  // Category Hierarchy Storage Methods
  void setCategoryHierarchyModel(CategoryModel categoryModel) {
    try {
      categoryHierarchyData.val = categoryModel.toJson();
    } catch (e) {
      log('Error saving category hierarchy model: $e');
    }
  }

  CategoryModel? getCategoryHierarchyModel() {
    try {
      final data = categoryHierarchyData.val;
      if (data.isNotEmpty) {
        return CategoryModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting category hierarchy model: $e');
    }
    return null;
  }

  void clearCategoryHierarchyData() {
    categoryHierarchyData.val = {};
  }

  void setServiceCategoryHierarchyModel(ServiceCategoryModel categoryModel) {
    try {
      categoryServiceHierarchyData.val = categoryModel.toJson();
    } catch (e) {
      log('Error saving category hierarchy model: $e');
    }
  }

  ServiceCategoryModel? getServiceCategoryHierarchyModel() {
    try {
      final data = categoryServiceHierarchyData.val;
      if (data.isNotEmpty) {
        return ServiceCategoryModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting category hierarchy model: $e');
    }
    return null;
  }

  void clearServiceCategoryHierarchyData() {
    categoryServiceHierarchyData.val = {};
  }

  // Requirement List Storage Methods
  void setRequirementListModel(GetRequirementListModel requirementListModel) {
    try {
      requirementListData.val = requirementListModel.toJson();
    } catch (e) {
      log('Error saving requirement list model: $e');
    }
  }

  GetRequirementListModel? getRequirementListModel() {
    try {
      final data = requirementListData.val;
      if (data.isNotEmpty) {
        return GetRequirementListModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting requirement list model: $e');
    }
    return null;
  }

  void clearRequirementListData() {
    requirementListData.val = {};
  }

  // Service Requirement List Storage Methods
  void setServiceRequirementListModel(GetServiceRequirementListModel serviceRequirementListModel) {
    try {
      serviceRequirementListData.val = serviceRequirementListModel.toJson();
    } catch (e) {
      log('Error saving service requirement list model: $e');
    }
  }

  GetServiceRequirementListModel? getServiceRequirementListModel() {
    try {
      final data = serviceRequirementListData.val;
      if (data.isNotEmpty) {
        return GetServiceRequirementListModel.fromJson(data);
      }
    } catch (e) {
      log('Error getting service requirement list model: $e');
    }
    return null;
  }

  void clearServiceRequirementListData() {
    serviceRequirementListData.val = {};
  }

  void setProfileId(String id) {
    profileId.val = id;
  }

  void setMainCategoriesConstructionId(String? id) {
    mainCategoriesConstructionId.val = id ?? "";
  }

  void setMainCategoriesInteriorId(String? id) {
    mainCategoriesInteriorId.val = id ?? "";
  }
}
