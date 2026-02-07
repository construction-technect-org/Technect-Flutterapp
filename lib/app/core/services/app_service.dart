import 'dart:convert';
import 'dart:developer';

import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/main_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/module_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/subcategory_model.dart';

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

  String get merchantID => _box.get('merchantID', defaultValue: '') as String;
  Future<void> setMerchantID(String value) async {
    await _box.put('merchantID', value);
    await _box.flush();
  }

  String get getNumber => _box.get('gst', defaultValue: '') as String;
  Future<void> setGstNumber(String value) async {
    await _box.put('gst', value);
    await _box.flush();
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

  // ================= PERSONA =================
  PersonaProfileModel? get personaDetail {
    try {
      final data = _box.get('persona');
      if (data == null) return null;
      print("Persona 123");
      print("Personal $data");
      return PersonaProfileModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing PersonaProfileModel: $e");
      return null;
    }
  }

  Future<void> setPersonaDetail(PersonaProfileModel? persona) async {
    if (persona == null) {
      await _box.delete('persona');
    } else {
      print("PEr 123");
      await _box.put('persona', persona.toJson());
      await _box.flush();
    }
  }

  // ================= Biz Hours =================

  MerchantBusninessHours? get merchnatBizHours {
    try {
      final data = _box.get('bizhours');
      if (data == null) return null;
      return MerchantBusninessHours.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing Merchant Biz Hours: $e");
      return null;
    }
  }

  Future<void> setMerchantBizHours(MerchantBusninessHours? bizHours) async {
    try {
      if (bizHours == null) {
        await _box.delete('bizhours');
      } else {
        await _box.put('bizhours', bizHours.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in housrs, $e");
    }
  }

  // ================= POC =================
  POC? get pocDetails {
    try {
      final data = _box.get('poc');
      if (data == null) return null;
      return POC.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setPOC(POC? pocDetails) async {
    try {
      if (pocDetails == null) {
        await _box.delete('poc');
      } else {
        await _box.put('poc', pocDetails.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in POC, $e");
    }
  }

  // ================= Biz Details =================

  Map? get bizMetrics {
    try {
      final data = _box.get('bm') as Map?;
      if (data == null) return null;
      return data;
    } catch (e) {
      print("Error parsing Business Metrics: $e");
      return null;
    }
  }

  Future<void> setBM(Merchant mpm) async {
    try {
      if (mpm == null) {
        await _box.delete('bm');
      } else {
        await _box.put('bm', {
          "businessName": mpm.businessName,
          "businessType": mpm.businessType,
          "businessEmail": mpm.businessEmail,
          "businessWebsite": mpm.businessWebsite,
          "businessPhone": mpm.businessPhone,
          "alternateBusinessPhone": mpm.alternateBusinessPhone,
          "yearOfEstablish": mpm.yearOfEstablish,
          "image": mpm.logoKey?.url,
        });
        await _box.flush();
      }
    } catch (e) {
      print("Error in POC, $e");
    }
  }

  // ================= Modules =================
  ModuleModel? get moduleDetails {
    try {
      final data = _box.get('module');
      if (data == null) return null;
      return ModuleModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setModuleDetails(ModuleModel? mm) async {
    try {
      if (mm == null) {
        await _box.delete('module');
      } else {
        await _box.put('module', mm.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in Module, $e");
    }
  }

  // ================= Main Category =================

  MainCategoryModel? get mainCategoryDetails {
    try {
      final data = _box.get('mCat');
      if (data == null) return null;
      return MainCategoryModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setMainCategory(MainCategoryModel? mm) async {
    try {
      if (mm == null) {
        await _box.delete('mCat');
      } else {
        await _box.put('mCat', mm.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in Module, $e");
    }
  }

  // =================  Category =================

  FullCategoryModel? get categoryDetails {
    try {
      final data = _box.get('cat');
      if (data == null) return null;
      return FullCategoryModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setCategory(FullCategoryModel? mm) async {
    try {
      if (mm == null) {
        await _box.delete('cat');
      } else {
        await _box.put('cat', mm.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in Module, $e");
    }
  }

  // =================  Sub Category =================

  FullSubCategoryModel? get subCategoryDetails {
    try {
      final data = _box.get('subCat');
      if (data == null) return null;
      return FullSubCategoryModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setSubCategory(FullSubCategoryModel? mm) async {
    try {
      if (mm == null) {
        await _box.delete('subCat');
      } else {
        await _box.put('subCat', mm.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in Module, $e");
    }
  }

  // =================  Sub Category =================

  CategoryProductModel? get categoryProdDetails {
    try {
      final data = _box.get('catProd');
      if (data == null) return null;
      return CategoryProductModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      print("Error parsing POC: $e");
      return null;
    }
  }

  Future<void> setCategoryProd(CategoryProductModel? mm) async {
    try {
      if (mm == null) {
        await _box.delete('catProd');
      } else {
        await _box.put('catProd', mm.toJson());
        await _box.flush();
      }
    } catch (e) {
      print("Error in Module, $e");
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
