import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';

import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppHiveService extends GetxService {
  late Box _box;

  Future<AppHiveService> init() async {
    _box = Hive.box('appBox');
    return this;
  }

  // ================= AUTH =================

  String get token => _box.get('token', defaultValue: '') as String;
  Future<void> setToken(String value) async {
    await _box.put('token', value);
    await _box.flush();
  }

  String get tokenType => _box.get('tokenType', defaultValue: '') as String;
  Future<void> setTokenType(String value) async {
    await _box.put('tokenType', value);
    await _box.flush();
  }

  String get role => _box.get('role', defaultValue: '') as String;
  Future<void> setRole(String value) async {
    await _box.put('role', value);
    await _box.flush();
  }

  bool get isTeamLogin => _box.get('isTeamLogin', defaultValue: false) as bool;
  Future<void> setTeamLogin(bool value) async =>
      await _box.put('isTeamLogin', value);

  bool get kycValid => _box.get('kyc', defaultValue: false) as bool;
  Future<void> setKyc(bool value) async => await _box.put('kyc', value);


  String get connectorProfileId => _box.get('isProfileId',defaultValue: '')as String;
  Future<void> setProfileId(String value)async {
    await _box.put('isProfile', value);
  }
  // ================= USER =================

  UserMainModel? get user {
    final data = _box.get('userModel');
    if (data == null) return null;
    return UserMainModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> setUser(UserMainModel? user) async {
    if (user == null) {
      await _box.delete('userModel');
    } else {
      await _box.put('userModel', user.toJson());
      await _box.flush();
    }
  }

  // ================= REMEMBER ME =================

  Future<void> saveCredentials(String mobile, String password) async {
    await _box.put('savedMobileNumber', mobile);
    await _box.put('savedPassword', password);
    await _box.put('rememberMe', true);
  }

  Future<void> clearCredentials() async {
    _box.delete('savedMobileNumber');
    _box.delete('savedPassword');
    await _box.put('rememberMe', false);
  }

  bool get rememberMe => _box.get('rememberMe', defaultValue: false) as bool;
  String get savedMobile =>
      _box.get('savedMobileNumber', defaultValue: '') as String;
  String get savedPassword =>
      _box.get('savedPassword', defaultValue: '') as String;

  // ================= CACHED API DATA =================

  Future<void> setCategories(List<SupportCategory> list) async {
    final json = list.map((e) => e.toJson()).toList();
    await _box.put('cachedCategories', jsonEncode(json));
  }

  List<SupportCategory>? getCategories() {
    try {
      final raw = _box.get('cachedCategories');
      if (raw == null) return null;
      final decoded = jsonDecode(raw) as List;
      return decoded.map((e) => SupportCategory.fromJson(e)).toList();
    } catch (e) {
      log('Category parse error: $e');
      return null;
    }
  }

  Future<void> setPriorities(List<SupportPriority> list) async {
    final json = list.map((e) => e.toJson()).toList();
    await _box.put('cachedPriorities', jsonEncode(json));
  }

  List<SupportPriority>? getPriorities() {
    try {
      final raw = _box.get('cachedPriorities');
      if (raw == null) return null;
      final decoded = jsonDecode(raw) as List;
      return decoded.map((e) => SupportPriority.fromJson(e)).toList();
    } catch (e) {
      log('Priority parse error: $e');
      return null;
    }
  }

  // ================= CLEAR =================

  Future<void> logout() async {
    await _box.deleteAll([
      'token',
      'tokenType',
      'role',
      'userModel',
      'isTeamLogin',
    ]);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
