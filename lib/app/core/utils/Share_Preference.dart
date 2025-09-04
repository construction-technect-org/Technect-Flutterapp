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
}
