import 'package:construction_technect/app/core/apiManager/endpoints.dart';
import 'package:construction_technect/app/core/apiManager/manage_api.dart';
import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/aadhar_details_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/aadhar_sendotp_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/gst_details_model.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/verify_otp_model.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MainSignUpService extends GetxService {
  final ManageApi _manageApi = Get.find<ManageApi>();

  Future<void> tempSignUp(String mobileNumber, String email, String countryCode) async {
    try {
      final response = await _manageApi.postObject(
        url: Endpoints.signUpUserPhone,
        body: {
          if ((email ?? "").isNotEmpty) "email": email,
          if ((mobileNumber ?? "").isNotEmpty) "phone": mobileNumber,
          if ((mobileNumber ?? "").isNotEmpty && (countryCode ?? "").isNotEmpty)
            "countryCode": countryCode,
        },
      );

      final data = response ?? {};
      if (data["success"] == true) {
        SnackBars.successSnackBar(content: "OTP sent Successfully");
        /*   if (signUpResponse.data?.token != null) {
          myPref.setToken(signUpResponse.data!.token!);
        }
        if (signUpResponse.data?.user != null) {
          myPref.setUserModel(signUpResponse.data!.user!);
        } */
        print("AllData $data");
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        }
        Get.toNamed(Routes.OTP_Verification);
      }
      //
    } catch (e, st) {
      throw Exception('Error in Sign Up: $e , $st');
    }
  }

  Future<VerifyOTPModel> verifyOtp({
    required String countryCode,
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final response = await _manageApi.postObject(
        url: Endpoints.verifyOTP,
        body: {"countryCode": countryCode, "phone": mobileNumber, "otp": otp},
      );

      return VerifyOTPModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in verifyOtp: $e , $st');
    }
  }

  Future<DetailsGST> verifyGST({required String gstNumber}) async {
    try {
      final response = await _manageApi.postObjectBeforeSignUp(
        url: Endpoints.verifyGST,
        body: {"gstNumber": gstNumber},
      );
      print("GST $response");
      return DetailsGST.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in verifying GST: $e , $st');
    }
  }

  Future<CompleteSignUpModel> completeSignUp({
    required String roleName,
    required String firstName,
    required String lastName,

    required String password,
    required String confirmPassword,

    //String? panCard,
    Map<String, dynamic>? address,
    String? fcmToken,
    String? deviceType,
    String? referralCode,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "role": roleName,
        "firstName": firstName,
        "lastName": lastName,

        "password": password,
        "confirmPassword": confirmPassword,

        "referralCode": referralCode,
        "address": address,
      };
      // Add FCM token and device type if provided
      if (fcmToken != null && fcmToken.isNotEmpty) {
        body["fcmToken"] = fcmToken;
      }
      if (deviceType != null && deviceType.isNotEmpty) {
        body["deviceType"] = deviceType;
      }

      final response = await _manageApi.postObjectBeforeSignUp(
        url: Endpoints.completeSignUp,
        body: body,
      );
      print("Res123");
      print(response);
      return CompleteSignUpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in Signing Up: $e , $st');
    }
  }

  Future<AadharSendOTPModel> sendAadharOTP({required String aadharNumber}) async {
    try {
      final response = await _manageApi.postObject(
        url: Endpoints.aadharVerify,
        body: {"aadharNumber": aadharNumber},
      );
      print("OTP , $response");
      return AadharSendOTPModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in Sending OTP: $e , $st');
    }
  }

  Future<AadharDetailsModel> veriAadharOTP({required String otp}) async {
    try {
      final response = await _manageApi.postObject(
        url: Endpoints.aadharOTPVerify,
        body: {"otp": otp},
      );
      print("OTP 123 $response");
      return AadharDetailsModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in Verifying OTP: $e , $st');
    }
  }
}
