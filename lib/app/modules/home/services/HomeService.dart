import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';

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
}
