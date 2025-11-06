import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/OtpModel.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/model/SignUpModel.dart';

class SignUpService {
  ApiManager apiManager = ApiManager();

  Future<bool> checkAvailability({
    String? email,
    String? mobileNumber,
    String? countryCode,
    String? gstNumber,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.checkAvailability,
        body: {
          if ((email ?? "").isNotEmpty) "email": email,
          if ((mobileNumber ?? "").isNotEmpty) "mobileNumber": mobileNumber,
          // API expects countryCode when checking phone availability
          if ((mobileNumber ?? "").isNotEmpty && (countryCode ?? "").isNotEmpty)
            "countryCode": countryCode,
          if ((gstNumber ?? "").isNotEmpty) "gstNumber": gstNumber,
        },
      );
      // Parse availability based on requested field
      final data = response["data"] ?? {};
      if ((email ?? '').isNotEmpty) {
        final emailData = data["email"];
        if (emailData is Map) {
          // Check if available is explicitly true
          final available = emailData["available"];
          // If available is explicitly false, email is not available (already registered)
          if (available == false) {
            return false;
          }
          // If available is explicitly true, email is available
          if (available == true) {
            return true;
          }
          // If available is null or not a boolean, check for exists field
          // Some APIs return exists: true when email is already registered
          final exists = emailData["exists"];
          if (exists == true) {
            return false; // Email exists, so not available
          }
          // If we can't determine, default to false (not available) for safety
          return false;
        }
        // if API doesn't return email block, default to false (not available) for safety
        return false;
      }
      if ((mobileNumber ?? '').isNotEmpty) {
        final phoneData = data["phone"] ?? data["mobileNumber"];
        if (phoneData is Map) {
          return phoneData["available"] == true && phoneData["exists"] != true;
        }
        return false;
      }
      if ((gstNumber ?? '').isNotEmpty) {
        final gstData = data["gstNumber"] ?? data["gst"];
        if (gstData is Map) {
          return gstData["available"] == true;
        }
        return true;
      }
      return false;
    } catch (e, st) {
      throw Exception('Error checking availability: $e , $st');
    }
  }

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

  Future<OtpModel> resendOtp({
    required String mobileNumber,
    String? code,
  }) async {
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

  Future<OtpModel> verifyOtp({
    required String mobileNumber,
    required String otp,
  }) async {
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
    required String roleName,
    required String firstName,
    required String lastName,
    required String countryCode,
    required String mobileNumber,
    required String marketPlaceRole,
    required String email,
    required String password,
    required String confirmPassword,
    String? gst,
    String? aadhaar,
    String? panCard,
    String? address,
  }) async {
    try {
      final response = await apiManager.postObject(
        url: APIConstants.signup,
        body: {
          "roleName": roleName,
          "firstName": firstName,
          "lastName": lastName,
          "countryCode": countryCode,
          "mobileNumber": mobileNumber,
          "email": email,
          "marketPlaceRole": marketPlaceRole,
          "password": password,
          "confirmPassword": confirmPassword,
          if ((gst ?? "").isNotEmpty) "gstNumber": gst,
          if ((aadhaar ?? "").isNotEmpty) "aadharNumber": aadhaar,
          if ((panCard ?? "").isNotEmpty) "panCardNumber": panCard,
          if ((address ?? "").isNotEmpty) "gstNumber": address,
        },
      );
      return SignUpModel.fromJson(response);
    } catch (e, st) {
      throw Exception('Error in signup: $e , $st');
    }
  }
}
