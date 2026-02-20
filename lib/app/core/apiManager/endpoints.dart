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
  static const String personaApi = "/v1/api/auth/profiles/list";
  static const String merchantProfileApi = "/v1/api/business/merchant";
  static const String bizHoursApi = "/v1/api/business/merchant/business-hours/";
  static const String pocApi = "/v1/api/business/merchant/poc-details/";
  static const String bizDetailsApi =
      "/v1/api/business/merchant/business-details";
  static const String certApi = "/v1/api/upload/certificate/";
  static const String delCertAPi = "/v1/api/upload/certificate";
  static const String moduleApi = "/v1/api/marketplace/modules?moduleFor=";
  static const String mainCatApi =
      "/v1/api/marketplace/main-categories?moduleId=";
  static const String catApi = "/v1/api/marketplace/categories?mainCategoryId=";
  static const String subCatApi =
      "/v1/api/marketplace/sub-categories?categoryId=";
  static const String catProdApi =
      "/v1/api/marketplace/category-products?subCategoryId=";
  static const String merchantProjects =
      "/v1/api/business/merchant/projects";
  static const String getAllPermissionApi =
      "/v1/api/business/permissions?permissionFor=";
  static const String createRoleApi = "/v1/api/business/roles/custom/";
}
