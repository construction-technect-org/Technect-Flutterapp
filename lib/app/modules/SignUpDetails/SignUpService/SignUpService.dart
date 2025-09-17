import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/SignUpDetails/model/OtpModel.dart';
import 'package:construction_technect/app/modules/SignUpPassword/model/SignUpModel.dart';

class SignUpService {
  ApiManager apiManager = ApiManager();

  Future<OtpModel> sendOtp({required String mobileNumber}) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.sendOtp,
        body: {"countryCode": "+91", "mobileNumber": mobileNumber},
      );
      return OtpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in sendOtp: $e , $st');
    }
  }

  Future<OtpModel> resendOtp({required String mobileNumber,String? code}) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.resendOtp,
        body: {"countryCode": code, "mobileNumber": mobileNumber},
      );
      return OtpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in resendOtp: $e , $st');
    }
  }

  Future<OtpModel> verifyOtp({required String mobileNumber, required String otp}) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.verifyOtp,
        body: {"countryCode": "+91", "mobileNumber": mobileNumber, "otp": otp},
      );
      return OtpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in verifyOtp: $e , $st');
    }
  }

  Future<SignUpModel> signup({
    required int roleId,
    required String firstName,
    required String lastName,
    required String countryCode,
    required String mobileNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.signup,
        body: {
          "roleId": roleId,
          "firstName": firstName,
          "lastName": lastName,
          "countryCode": countryCode,
          "mobileNumber": mobileNumber,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      return SignUpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in signup: $e , $st');
    }
  }
}
