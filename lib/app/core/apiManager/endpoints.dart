class Endpoints {
  static const String baseUrl = "https://api.constructiontechnect.com";
  static const String signUpUserPhone = "/v1/api/auth/user/signup/phone";
  static const String verifyOTP = "/v1/api/auth/user/signup/verify";
  static const String verifyGST = "/v1/api/auth/user/signup/profile/kyc/gst";
  static const String completeSignUp =
      "/v1/api/auth/user/signup/profile/complete";
  static const String aadharVerify =
      "/v1/api/auth/user/signup/profile/kyc/aadhar";
  static const String aadharOTPVerify =
      "/v1/api/auth/user/signup/profile/kyc/aadhar/verify";
  static const String loginAPI = "/v1/api/auth/user/signin/phone";
  static const String forgotPwdApi = "/v1/api/auth/user/forgot-password";
  static const String verifyPwdApi = "/v1/api/auth/user/forgot-password/verify";
  static const String resetPwdApi = "/v1/api/auth/user/forgot-password/reset";
  static const String getUserApi = "/v1/api/user/me";
}
