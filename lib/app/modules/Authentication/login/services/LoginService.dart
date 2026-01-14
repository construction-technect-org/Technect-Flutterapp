import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/LoginModel.dart';

class LoginService {
  ApiManager apiManager = ApiManager();

  Future<LoginModel> login({
    required String countryCode,
    required String mobileNumber,
    required String password,
    String? fcmToken,
    String? deviceType,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        "password": password,
      };

      // Add FCM token and device type if provided
      if (fcmToken != null && fcmToken.isNotEmpty) {
        body["fcmToken"] = fcmToken;
      }
      if (deviceType != null && deviceType.isNotEmpty) {
        body["deviceType"] = deviceType;
      }
      print("YEs done");
      final response = await apiManager.postObject(
        url: APIConstants.login,
        body: body,
      );
      print("Not  done");
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

  Future<LoginModel> teamLogin({
    required String mobileNumber,
    required String otp,
    String? fcmToken,
    String? deviceType,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "mobileNumber": mobileNumber,
        "otp": otp,
      };

      // Add FCM token and device type if provided
      if (fcmToken != null && fcmToken.isNotEmpty) {
        body["fcmToken"] = fcmToken;
      }
      if (deviceType != null && deviceType.isNotEmpty) {
        body["deviceType"] = deviceType;
      }

      final response = await apiManager.postObject(
        url: APIConstants.teamLogIn,
        body: body,
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
    String? fcmToken,
    String? deviceType,
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

      // Add FCM token and device type if provided
      if (fcmToken != null && fcmToken.isNotEmpty) {
        body['fcmToken'] = fcmToken;
      }
      if (deviceType != null && deviceType.isNotEmpty) {
        body['deviceType'] = deviceType;
      }

      final response = await apiManager.postObject(
        url: 'auth/social-login',
        body: body,
      );

      return LoginModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Social login failed: $e $st');
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
