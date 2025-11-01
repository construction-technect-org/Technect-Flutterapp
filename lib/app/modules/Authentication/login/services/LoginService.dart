import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/LoginModel.dart';

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

      final result = LoginModel.fromJson(response);

      if (result.success == true) {
        return result;
      } else {
        // Return generic error message for all login failures
        return LoginModel(
          success: false,
          message: "Invalid mobile number or password",
          code: result.code,
        );
      }
    } catch (e, st) {
      throw Exception('Error in login: $e , $st');
    }
  }

  Future<LoginModel> socialLogin({
    required String provider,
    required String providerId,
    required String firstName,
    required String lastName,
    required String email,
    required String profileImage,
    required String roleName,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'provider': provider,
        'providerId': providerId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'profileImage': profileImage,
        'roleName': roleName,
      };

      final response = await apiManager.postObject(
        url: 'auth/social-login',
        body: body,
      );

      return LoginModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Social login failed: $e');
    }
  }

  // Helper method to extract name parts from display name
  Map<String, String> extractNameParts(String displayName) {
    final nameParts = displayName.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {'firstName': firstName, 'lastName': lastName};
  }
}
