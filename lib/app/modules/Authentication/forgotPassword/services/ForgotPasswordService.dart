import 'package:construction_technect/app/core/apiManager/api_constants.dart';
import 'package:construction_technect/app/core/apiManager/api_manager.dart';
import 'package:construction_technect/app/core/apiManager/endpoints.dart';
import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/models/ForgotPasswordOtpModel.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/models/ForgotPasswordResetModel.dart';
import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:get/get.dart';

class ForgotPasswordService extends GetxService {
  final ApiManager _apiManager = ApiManager();
  final ManageApi _manageAPI = Get.find<ManageApi>();

  Future<ForgotPasswordOtpModel> sendOtp({
    required String countryCode,
    required String mobileNumber,
    required String email,
  }) async {
    try {
      final response = await _manageAPI.postObject(
        url: Endpoints.forgotPwdApi,
        body: {
          "countryCode": countryCode,
          "phone": mobileNumber,
          "email": email,
        },
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
      final response = await _manageAPI.postObject(
        url: Endpoints.verifyPwdApi,
        body: {"countryCode": countryCode, "phone": mobileNumber, "otp": otp},
      );
      print("Verified OTP");
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
      final response = await _manageAPI.postObject(
        url: Endpoints.resetPwdApi,
        body: {
          "countryCode": countryCode,
          "phone": mobileNumber,
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
