import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/LoginModel.dart';

class MarketplaceService {
  ApiManager apiManager = ApiManager();

  Future<LoginModel> marketPlaceApi({
    required String marketPlace,
    required String marketPlaceRole,
  }) async {
    try {
      final response = await apiManager.putObject(
        url: APIConstants.marketplaceUpdate,
        body: {
          "marketPlace": marketPlace,
          "marketPlaceRole": marketPlaceRole,
        },
      );
      return LoginModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in login: $e , $st');
    }
  }
}
