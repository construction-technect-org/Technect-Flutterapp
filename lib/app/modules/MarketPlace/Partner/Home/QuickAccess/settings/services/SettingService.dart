import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/models/ForgotPasswordOtpModel.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/models/ForgotPasswordResetModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/model/setting_model.dart';

class SettingService {
  final ApiManager _apiManager = ApiManager();

  Future<dynamic> deactivateAccount() async {
    return await _apiManager.delete(
      url: APIConstants.softDeleteAccount, // ✅ apna endpoint add karo
    );
  }
  Future<SendOtpModel> sendOtp({
    required bool isDeactivate,
    required String countryCode,
    required String mobileNumber,
    required String password,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url:isDeactivate? APIConstants.deactivateSendOtp: APIConstants.deleteSendOtp,
        body: {"countryCode": countryCode, "mobileNumber": mobileNumber,
          "password": password,
        },
      );

      return SendOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordOtpModel> verifyOtp({
    required bool isDeactivate,
    required String countryCode,
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url:isDeactivate? APIConstants.deactivateVerifyOtp: APIConstants.deleteVerifyOtp,
        body: {
          "countryCode": countryCode,
          "mobileNumber": mobileNumber,
          "otp": otp,
        },
      );

      return ForgotPasswordOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResetModel> notificationToggle({
    required bool isNotificationSend,
  }) async {
    try {
      final response = await _apiManager.postObject(
        url: APIConstants.notificationToggle,
        body: {
          "isNotificationSend": isNotificationSend,
        },
      );

      return ForgotPasswordResetModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
