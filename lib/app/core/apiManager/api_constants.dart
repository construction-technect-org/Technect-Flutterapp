class APIConstants {
  static const String appleApiKey = "";
  static const String androidApiKey = "";

  static const String bucketUrl =
      "https://bucket-construction-tech.s3.ap-south-1.amazonaws.com/";
  static const String clientId = "";

  static const String sendOtp = "auth/send-otp";
  static const String resendOtp = "auth/resend-otp";
  static const String verifyOtp = "auth/verify-otp";
  static const String signup = "auth/signup";
  static const String login = "auth/login";
  static const String marketplaceUpdate = "auth/marketplace";
  static const String forgotPasswordSendOtp = "auth/forgot-password/send-otp";
  static const String forgotPasswordVerifyOtp =
      "auth/forgot-password/verify-otp";
  static const String forgotPasswordReset = "auth/forgot-password/reset";
  static const String profile = "auth/profile";
  static const String address = "address";
  static const String merchantSubmit = "merchant/submit";
  static const String deleteDocument = "merchant/documents/";
  static const String merchantUpdate = "merchant/update";
  static const String addRole = "merchant/role/create";
  static const String getAllRole = "merchant/role/list";
  static const String updateRole = "merchant/role";
  static const String team = "merchant/team";
  static const String createProduct = "merchant/product/create";
  static const String updateProduct = "merchant/product/";
  static const String teamStatsOverview = "merchant/team/stats/overview";
  static const String roleDetailById = "merchant/role";
  static const String getMainCategories = "merchant/category/main";
  static const String getSubCategories =
      "merchant/category/sub?main_category_id=";
  static const String getProducts = "merchant/category/products/sub/";
  static const String getFilter = "merchant/category/filters/sub/";
  static const String getProductList = "merchant/product/list";
  static const String updateProfile = "auth/profile";
  static const String faq = "merchant/faq/list";

  // Service Management APIs
  static const String getServiceList = "service/merchant/list";
  static const String createService = "service/create";
  static const String updateService = "service/merchant/";
  static const String deleteService = "service/merchant/";
  static const String getServiceTypes = "service/types";
  static const String getServices = "service/types";

  // Service SupportTicket API
  static const String getSupportTicketCategories = "support-ticket/categories";
  static const String  getSupportTicketPriorities = "support-ticket/priorities";
  static const String  SupportTicketCreat = "support-ticket/create";
  static const String  getSupportMyTickets = "support-ticket/my-tickets";


/// Connector Api 
 static const String connectorCreate = "connector/create";
static const String connectorUpdate = "connector/update";


//Connector products
  static const String connectorProdcut= "connector/products";



}
