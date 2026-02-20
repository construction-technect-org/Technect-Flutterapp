class APIConstants {
  static const String appleApiKey = "";
  static const String androidApiKey = "";

  static const String bucketUrl = "https://bucket-construction-tech.s3.ap-south-1.amazonaws.com/";
  static const String appUrl =
      "https://play.google.com/store/apps/details?id=com.constructiontechnet.app";
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
  static const String checkAvailability = "auth/check-availability";
  static const String marketplaceUpdate = "auth/marketplace";
  static const String forgotPasswordSendOtp = "auth/forgot-password/send-otp";
  static const String forgotPasswordVerifyOtp = "auth/forgot-password/verify-otp";
  static const String forgotPasswordReset = "auth/forgot-password/reset";
  static const String profile = "/v1/api/auth/profiles/me";
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
  // static const String getServiceList = "service/merchant/list";
  static const String createService = "service/create";
  // static const String updateService = "service/merchant/";


  static const String deleteService = "service/merchant/";
  static const String getServiceTypes = "service/types";
  static const String getServices = "service/types";

  // Service Persona List APIs
  static const String getPersonaList="v1/api/auth/profiles/list";

  //Switch Account Apis
  static const String switchAccount="v1/api/auth/profiles/switch";

  // Service Connector ProfileId APIs
  static const String getConnectorProfile="v1/api/business/connector";
  static const String updateConnectorPocDetails="v1/api/business/connector/poc-details";

  //Service Connector Module
  static const String getConnectorModule="v1/api/marketplace/modules";
  static const String getMainCategory="v1/api/marketplace/main-categories";
  static const String getCategory="v1/api/marketplace/categories";
  static const String getSubCategory="v1/api/marketplace/sub-categories";
  static const String getSubCategoryItem="v1/api/marketplace/category-products";



  // Service SupportTicket API
  static const String getSupportTicketCategories = "support-ticket/categories";
  static const String getSupportTicketPriorities = "support-ticket/priorities";
  static const String createPartnerSupportTicket = "support-ticket/create";
  static const String getPartnerSupportTickets = "support-ticket/my-tickets";

  // Connection Inbox API
  static const String incomingConnectionInbox = "v1/api/marketplace/connection/incoming-list";
  static const String outgoingConnectionInbox = "v1/api/marketplace/connection/outgoing-list";
  // static const String connectionInbox = "connection-request/merchant/inbox";
  static const String acceptReject = "v1/api/marketplace/connection";

  /// Connector Api
  static const String connectorCreate = "connector/create";
  static const String connectorUpdate = "connector/update";

  //Connector products
  static const String connectorProduct = "connector/product/products";
  static const String recentlyProduct = "connector/product/recently-launched";
  static const String searchProduct = "connector/product/search";
  static const String productDetails = "connector/product/";
  static const String connectionRequest = "v1/api/marketplace/connection/request";
  static const String connectionWithdrawRequest = "v1/api/marketplace/connection/withdraw-request";



  //Connector services
  static const String searchService = "connector/service/search";

  // Connector SupportTicket API
  static const String getConnectorSupportTicketCategories = "connector/support-ticket/categories";
  static const String getConnectorSupportTicketPriorities = "connector/support-ticket/priorities";
  static const String ConnectorSupportTicketCreate = "connector/support-ticket/create";
  static const String getConnectorSupportMyTickets = "connector/support-ticket/my-tickets";

  // Connector Demo Request API
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
  static const String getConnectorSupportTicket = "connector/support-ticket/my-tickets?";
  static const String createConnectorSupportTicket = "connector/support-ticket/create";
  static const String connectorFeedback = "feedback/connector";
  static const String manufacturerAddress = "address";

  // Connector Requirement API
  static const String connectorCreateRequirement = "connector/requirement";
  static const String connectorUpdateRequirement = "connector/requirement";
  static const String connectorGetRequirement = "connector/requirement/list/all";

  // Connector Service Requirement API
  static const String connectorCreateServiceRequirement = "connector/service-requirement";
  static const String connectorUpdateServiceRequirement = "connector/service-requirement";
  static const String connectorGetServiceRequirementList = "connector/service-requirement/list";
  static const String pointOfContactMerchant = "point-of-contact/merchant";
  static const String pointOfContactConnector = "point-of-contact/connector";
  static const String connectorTeamMember = "connector/team-member";
  static const String addService = "merchant/service/create";
  static const String updateService = "merchant/service/";
  static const String getServiceList = "merchant/service/list";
  static const String connectorServices = "connector/service/services";

  ///CRM
  static const String merchantChatList = "merchant/chat/conversations";
  static const String connectorChatList = "connector/chat/conversations";
  static const String messages = "messages/";
  static const String autoFill = "crm/lead/auto-fill";
  static const String crmLead = "crm/lead";
  static const String crmSalesLead = "crm/sales-lead";
  static const String crmAnalytics = "crm/analytics";
  static const String crmAnalyticsPdf = "crm/analytics/pdf";
  static const String crmNotification = "crm/notification";
  static const String crmDashboard = "crm/dashboard";
  static const String crmGroupChat = "crm/group-chat";

  // VRM
  static const String vrmLead = "vrm/lead";
  static const String vrmNotification = "vrm/notification";
  static const String vrmDashboard = "vrm/dashboard";
  static const String vrmGroupChat = "vrm/group-chat";

  ///Team-login

  static const String teamSendOtp = "team-member/auth/send-otp";
  static const String teamResendOtp = "team-member/auth/resend-otp";
  static const String teamLogIn = "team-member/auth/login";
  static const String teamProfile = "team-member/auth/profile";
}
