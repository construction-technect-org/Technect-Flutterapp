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

  // Logout method - clears token and user data but keeps credentials if remember me is enabled
  void logout() {
    token.val = '';
    userModel.val = {};
    // Don't clear credentials if remember me is enabled
  }

  // Complete logout - clears everything including credentials
  void completeLogout() {
    token.val = '';
    userModel.val = {};
    clearCredentials();
  }
}
