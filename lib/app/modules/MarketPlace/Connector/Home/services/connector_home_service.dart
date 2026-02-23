import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/main_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/module_models.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_item_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Home/models/sub_category_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/models/connector_Project_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/DashboardModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchat_model.dart';

class ConnectorHomeService extends GetxService {
  final ApiManager _apiManager = ApiManager();
  final ManageApi _manageApi = Get.find<ManageApi>();

  Future<dynamic> createProject({
    required Map<String, dynamic> fields,
    required Map<String, String> files,
  }) async {
    return await _apiManager.postMultipart(
      url: APIConstants.projectAdd,
      fields: fields,
      files: files,
    );
  }

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiManager.get(
        url: myPref.isTeamLogin.val == true
            ? APIConstants.teamProfile
            : APIConstants.profile,
      );

      return ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProjectListModel> getProjects() async {
    try {
      final response = await _apiManager.get(
        url:APIConstants.projectGet,
      );
      return ProjectListModel.fromJson(response);
    } catch (e) {
      rethrow;
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
      final response = await _apiManager.get(
        url: APIConstants.merchantDashboard,
      );
      return DashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AllMerchantStoreModel> getMerchantStore() async {
    try {
      final response = await _apiManager.get(
        url: APIConstants.connectorMerchantStore,
      );
      return AllMerchantStoreModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel> getCategoryHierarchy() async {
    try {
      final response = await _apiManager.get(url: 'merchant/hierarchy');
      return CategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  //Connector

  Future<ModulesResponse> getConnectorModule() async {
    try {
      String moduleFor =myPref.getRole();
      if(moduleFor=="partner") {
        moduleFor="merchant";
      }
      final response = await _apiManager.get(url: '/${APIConstants.getConnectorModule}?moduleFor=$moduleFor&includeInactive=false');
      return ModulesResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<MainCategoryResponse> getMainCategory(String? moduleId) async {
    try {
      final response = await _apiManager.get(url: '/${APIConstants.getMainCategory}?moduleId=$moduleId&includeInactive=false');
      return MainCategoryResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<CategoryResponse> getCategory(String? mainCategoryId) async {
    try {
      final response = await _apiManager.get(url: '/${APIConstants.getCategory}?mainCategoryId=$mainCategoryId&includeInactive=false');
      return CategoryResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<SubCategoryResponse> getSubCategory(String? categoryId) async {
    try {
      final response = await _apiManager.get(url: '/${APIConstants.getSubCategory}?categoryId=$categoryId&includeInactive=false');
      return SubCategoryResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<SubCategoryItemResponse> getSubCategoryItem(String? subCategoryId) async {
    try {
      final response = await _apiManager.get(url: '/${APIConstants.getSubCategoryItem}?subCategoryId=$subCategoryId&includeInactive=false');
      return SubCategoryItemResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ServiceCategoryModel> getCategoryServiceHierarchy() async {
    try {
      final response = await _apiManager.get(
        url: 'service-categories/hierarchy',
      );
      return ServiceCategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
