import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
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
      print('Error saving roles: $e');
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
      print('Error getting roles: $e');
    }
    return null;
  }
}
