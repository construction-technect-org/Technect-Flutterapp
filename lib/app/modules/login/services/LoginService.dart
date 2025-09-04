import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/login/models/LoginModel.dart';

class LoginService {
  ApiManager apiManager = ApiManager();

  Future<LoginModel> login({
    required String countryCode,
    required String mobileNumber,
    required String password,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.login,
        body: {
          "countryCode": countryCode,
          "mobileNumber": mobileNumber,
          "password": password,
        },
      );
      return LoginModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in login: $e , $st');
    }
  }
}
