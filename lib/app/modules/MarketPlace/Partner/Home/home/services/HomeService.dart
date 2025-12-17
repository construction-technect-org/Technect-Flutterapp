import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/CategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/DashboardModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/SerciveCategoryModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchat_model.dart';

class HomeService {
  final ApiManager _apiManager = ApiManager();

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiManager.get(url: myPref.isTeamLogin.val==true ?APIConstants.teamProfile : APIConstants.profile);

      return ProfileModel.fromJson(response);
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

  Future<ServiceCategoryModel> getCategoryServiceHierarchy() async {
    try {
      final response = await _apiManager.get(url: 'service-categories/hierarchy');
      return ServiceCategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
