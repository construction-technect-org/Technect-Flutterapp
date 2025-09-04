import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/forgotPassword/models/ForgotPasswordOtpModel.dart';
import 'package:construction_technect/app/modules/forgotPassword/models/ForgotPasswordResetModel.dart';

class ForgotPasswordService {
  final ApiManager _apiManager = ApiManager();

  Future<ForgotPasswordOtpModel> sendOtp({
    required String countryCode,
    required String mobileNumber,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.forgotPasswordSendOtp,
        body: {"countryCode": countryCode, "mobileNumber": mobileNumber},
      );

      return ForgotPasswordOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordOtpModel> verifyOtp({
    required String countryCode,
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.forgotPasswordVerifyOtp,
        body: {"countryCode": countryCode, "mobileNumber": mobileNumber, "otp": otp},
      );

      return ForgotPasswordOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResetModel> resetPassword({
    required String countryCode,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.forgotPasswordReset,
        body: {
          "countryCode": countryCode,
          "mobileNumber": mobileNumber,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      return ForgotPasswordResetModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
