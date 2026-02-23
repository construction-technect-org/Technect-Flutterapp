import "dart:developer";

import 'package:construction_technect/app/core/apiManager/endpoints.dart';
import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/profile_model.dart'
    as connector;
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/DashboardModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/category_product_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/dynamic_filter_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/main_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_projects.model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchat_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/module_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/subcategory_model.dart';

class HomeService extends GetxService {
  final ApiManager _apiManager = ApiManager();
  final ManageApi _manageApi = Get.find<ManageApi>();

  Future<MainCategoryModel> getMainCategories({required String moduleID}) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.mainCatApi}$moduleID&includeInactive=false',
      );
      return MainCategoryModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Main Categories: $e , $st');
    }
  }

  Future<FullCategoryModel> getCategories({required String mainCatID}) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.catApi}$mainCatID&includeInactive=false',
      );
      return FullCategoryModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Main Categories: $e , $st');
    }
  }

  Future<FullSubCategoryModel> getSubCategories({required String catID}) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.subCatApi}$catID&includeInactive=false',
      );
      return FullSubCategoryModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Sub Categories: $e , $st');
    }
  }

  Future<CategoryProductModel> getCategoriesProduct({
    required String subCatID,
    String? sort,
    double? radius,
  }) async {
    try {
      String url = '${Endpoints.catProdApi}$subCatID&includeInactive=true';
      if (sort != null) url += '&sort=$sort';
      if (radius != null) url += '&radius=$radius';

      final response = await _manageApi.get(url: url);
      return CategoryProductModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Categories Product: $e , $st');
    }
  }

  Future<DynamicFilterModel> getDynamicFilters({required String categoryProductId}) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.dynamicFilterApi}$categoryProductId&includeInactive=true',
      );
      return DynamicFilterModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Dynamic Filters: $e , $st');
    }
  }

  Future<ModuleModel> getAllModules({required String mFor}) async {
    try {
      final response = await _manageApi.get(
        url: '${Endpoints.moduleApi}$mFor&includeInactive=false',
      );
      return ModuleModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Modules: $e , $st');
    }
  }

  Future<ProjectResponse> getMerchantProjects() async {
    try {
      final response = await _manageApi.get(url: Endpoints.merchantProjects);
      return ProjectResponse.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Modules: $e , $st');
    }
  }

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiManager.get(
        url: myPref.isTeamLogin.val == true ? APIConstants.teamProfile : APIConstants.profile,
      );

      return ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<connector.ProfileModel> getProfileM() async {
    try {
      final response = await _apiManager.get(
        url: myPref.isTeamLogin.val == true ? APIConstants.teamProfile : APIConstants.profile,
      );
      return connector.ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<PersonaProfileModel> getPersona() async {
    try {
      final response = await _manageApi.get(url: Endpoints.personaApi);
      return PersonaProfileModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Persona: $e , $st');
    }
  }

  Future<MerchantProfileModel> getMerchantProfile(String profileID) async {
    try {
      final response = await _manageApi.get(url: Endpoints.merchantProfileApi);

      return MerchantProfileModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in getting Merchant Profile: $e , $st');
    }
  }

  Future<AddressModel> getAddress() async {
    try {
      final response = await _apiManager.get(url: APIConstants.address);

      return AddressModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DashboardModel> getDashboard() async {
    try {
      final response = await _apiManager.get(url: APIConstants.merchantDashboard);
      return DashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AllMerchantStoreModel> getMerchantStore() async {
    try {
      final response = await _apiManager.get(url: APIConstants.connectorMerchantStore);
      return AllMerchantStoreModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel> getCategoryHierarchy() async {
    try {
      final response = await _apiManager.get(url: '/v1/api/business/merchant/hierarchy');
      return CategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceCategoryModel> getCategoryServiceHierarchy() async {
    try {
      final response = await _apiManager.get(url: '/v1/api/business/service-categories/hierarchy');
      return ServiceCategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateBusinessHours(String profileID, Map<String, dynamic> bizHours) async {
    try {
      final json = {"businessHours": bizHours};
      log('$json');
      final response = await _manageApi.patch(url: Endpoints.bizHoursApi, body: json);
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in updating Business Hours: $e , $st');
    }
  }

  Future<bool> updateUserInfo({
    required String businessEmail,
    required String businessPhone,
    required String alternateBusinessPhone,
  }) async {
    try {
      final json = {
        "businessEmail": businessEmail,
        "businessPhone": businessPhone,
        "alternateBusinessPhone": alternateBusinessPhone,
      };
      final response = await _manageApi.patch(url: Endpoints.userInfoApi, body: json);
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in updating User Info: $e , $st');
    }
  }

  Future<bool> updatePOCDetails({
    required String profileID,
    required String pocName,
    required String pocDesignation,
    required String pocPhone,
    required String pocAlternatePhone,
    required String pocEmail,
  }) async {
    try {
      final json = {
        "pocName": pocName,
        "pocDesignation": pocDesignation,
        "pocPhone": pocPhone,
        "pocAlternatePhone": pocAlternatePhone,
        "pocEmail": pocEmail,
      };
      final response = await _manageApi.patch(url: Endpoints.pocApi, body: json);
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in updating POC Details: $e , $st');
    }
  }

  Future<bool> updateCertificates({
    required String fileName,
    required String title,
    required String profileID,
  }) async {
    try {
      final fileJson = {"file": fileName};
      final json = {"title": title};
      final response = await _manageApi.postMultipart(
        url: Endpoints.certApi,
        fields: json,
        files: fileJson,
      );
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in updating Uploading Certificates: $e , $st');
    }
  }

  Future<bool> updateBizMetrics({
    required String profileID,
    required String bizName,
    required String bizType,
    required String bizEmail,
    required String bizPhone,
    String? businessWebsite,
    String? alternateBizPhone,
    required String yearOfEstablish,
    required String fileName,
  }) async {
    try {
      final fileJson = {"file": fileName};
      final json = <String, String>{
        "businessName": bizName,
        "businessType": bizType,
        "businessEmail": bizEmail,
        "businessPhone": bizPhone,
        "yearOfEstablish": yearOfEstablish,
        if ((businessWebsite ?? "").isNotEmpty) "businessWebsite": businessWebsite!,
        if ((alternateBizPhone ?? "").isNotEmpty) "alternateBusinessPhone": alternateBizPhone!,
      };
      final response = await _manageApi.patchMultipart(
        url: Endpoints.bizDetailsApi,
        fields: json,
        files: fileJson,
      );
      log("Response from merchant profile: $response");
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in updating Updating Metrics: $e , $st');
    }
  }

  Future<bool> deleteCertificate({
    required String profileType,
    required String profileID,
    required String certKey,
  }) async {
    try {
      final json = {"profileType": profileType, "profileId": profileID, "certificateKey": certKey};
      final response = await _manageApi.deleteObject(url: Endpoints.delCertAPi, body: json);
      if (response["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw Exception('Error in deleting: $e , $st');
    }
  }
}
