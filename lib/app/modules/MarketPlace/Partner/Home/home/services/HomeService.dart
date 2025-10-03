import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/DashboardModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class HomeService {
  final ApiManager _apiManager = ApiManager();

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiManager.get(url: APIConstants.profile);

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
}
