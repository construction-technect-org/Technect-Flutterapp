class APIConstants {
  static const String appleApiKey = "";
  static const String androidApiKey = "";

  static const String bucketUrl =
      "https://bucket-construction-tech.s3.ap-south-1.amazonaws.com/";
  static const String appUrl =
      "https://play.google.com/store/apps/details?id=com.construction_technet.app";
  static const String clientId = "";

  static const String sendOtp = "auth/send-otp";
  static const String resendOtp = "auth/resend-otp";
  static const String verifyOtp = "auth/verify-otp";

  static const String notificationToggle = "notification-settings/toggle";

  static const String deactivateSendOtp = "auth/deactivate/send-otp";
  static const String deactivateVerifyOtp = "auth/deactivate/verify-otp";
  static const String deleteSendOtp = "auth/delete/send-otp";
  static const String deleteVerifyOtp = "auth/delete/verify-otp";

  static const String signup = "auth/signup";
  static const String login = "auth/login";
  static const String checkEmail = "auth/check-email";
  static const String marketplaceUpdate = "auth/marketplace";
  static const String forgotPasswordSendOtp = "auth/forgot-password/send-otp";
  static const String forgotPasswordVerifyOtp = "auth/forgot-password/verify-otp";
  static const String forgotPasswordReset = "auth/forgot-password/reset";
  static const String profile = "auth/profile";
  static const String address = "address";
  static const String merchantSubmit = "merchant/submit";
  static const String deleteDocument = "merchant/documents/";
  static const String merchantUpdate = "merchant/update";
  static const String addRole = "merchant/role/create";
  static const String getAllRole = "merchant/role/list";
  static const String updateRole = "merchant/role";
  static const String deleteRole = "merchant/role/";
  static const String team = "merchant/team";
  static const String createProduct = "merchant/product/create";
  static const String updateProduct = "merchant/product/";
  static const String teamStatsOverview = "merchant/team/stats/overview";
  static const String roleDetailById = "merchant/role";
  static const String getMainCategories = "merchant/category/main";
  static const String getSubCategories = "merchant/category/sub?main_category_id=";
  static const String getProducts = "merchant/category/products/sub/";
  static const String getFilter = "merchant/category/filters/sub/";
  static const String getProductList = "merchant/product/list";
  static const String updateProfile = "auth/profile";
  static const String faq = "merchant/faq/list";
  static const String merchantFeedback = "feedback/merchant";
  static const String demoRequest = "demo-request/create";
  static const String notifications = "notifications";
  static const String notificationsProduct = "notifications/product";
  static const String merchantDashboard = "merchant/dashboard";
  static const String newsMerchant = "news/merchant";
  static const String merchantAnalytics = "merchant/analytics";
  static const String merchantReport = "merchant/analytics/pdf";

  static const String connectorAnalytics = "connector/analytics";
  static const String connectorReport = "connector/analytics/pdf";

  // Service Management APIs
  static const String getServiceList = "service/merchant/list";
  static const String createService = "service/create";
  static const String updateService = "service/merchant/";

  static const String deleteService = "service/merchant/";
  static const String getServiceTypes = "service/types";
  static const String getServices = "service/types";

  // Service SupportTicket API
  static const String getSupportTicketCategories = "support-ticket/categories";
  static const String getSupportTicketPriorities = "support-ticket/priorities";
  static const String SupportTicketCreat = "support-ticket/create";
  static const String getSupportMyTickets = "support-ticket/my-tickets";

  // Connection Inbox API
  static const String connectionInbox = "connection-request/merchant/inbox";
  static const String acceptReject = "connection-request";

  /// Connector Api
  static const String connectorCreate = "connector/create";
  static const String connectorUpdate = "connector/update";

  //Connector products
  static const String connectorProduct = "connector/product/products";
  static const String recentlyProduct = "connector/product/recently-launched";
  static const String productDetails = "connector/product/";

  // Connector SupportTicket API
  static const String getConnectorSupportTicketCategories =
      "connector/support-ticket/categories";
  static const String getConnectorSupportTicketPriorities =
      "connector/support-ticket/priorities";
  static const String ConnectorSupportTicketCreate = "connector/support-ticket/create";
  static const String getConnectorSupportMyTickets =
      "connector/support-ticket/my-tickets";

  // Connector Demo Request API
  static const String connectorDemoRequest = "connector/demo-request/my-requests";
  static const String connectorDemoRequestCreate = "connector/demo-request/create";

  static const String connectionConnectorInbox = "connector/connection-request/inbox";
  static const String cancelConnection = "connector/connection-request/";

  // Connector Site address
  static const String connectorSiteAddress = "connector/site-location";
  static const String notifyME = "connector/stock-notification/request";
  static const String addToConnect = "connector/connection-request/send";
  static const String wishList = "connector/wishlist";
  static const String connectorGetProductReview = "connector/product/";
  static const String connectorMerchantStore = "connector/merchant-store/merchant-stores";
  static const String connectorNotifications = "connector/notifications";
  static const String newsConnector = "news/connector";
  static const String cartList = "connector/connection-request/cart";
}
