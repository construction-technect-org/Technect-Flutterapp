import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/bindings/add_location_manually_binding.dart';
import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/views/add_location_manually_view.dart';
import 'package:construction_technect/app/modules/Authentication/Location/Address/bindings/address_bindings.dart';
import 'package:construction_technect/app/modules/Authentication/Location/Address/views/address_view.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/bindings/sign_up_details_binding.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/otp_verification_screen.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/bindings/sign_up_password_binding.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpPassword/views/sign_up_password_view.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/bindings/sign_up_role_binding.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/views/sign_up_role_view.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/bindings/forgot_password_binding.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/forgot_password_view.dart';
import 'package:construction_technect/app/modules/Authentication/login/bindings/login_binding.dart';
import 'package:construction_technect/app/modules/Authentication/login/views/login_view.dart';
import 'package:construction_technect/app/modules/ChatSystem/binding/chat_system_binding.dart';
import 'package:construction_technect/app/modules/ChatSystem/views/chat_system_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/bindings/add_requirement_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/views/add_requirement_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/bindings/add_service_requirement_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/views/add_service_requirement_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/bindings/cart_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Cart/views/cart_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/bindings/connector_profile_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/views/connector_profile_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/views/connector_selected_product_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/bindings/requirement_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/views/requirement_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/SearchProduct/bindings/search_product_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/SearchProduct/views/search_product_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/bindings/wish_list_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/WishList/views/wish_list_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/AddManufacturerAddress/bindings/add_manufacturer_address_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/AddManufacturerAddress/views/add_manufacturer_address_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/bindings/connection_inbox_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/binding/add_service_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/view/add_service_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/binding/service_detail_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/view/service_detail_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/views/construction_service_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Account/binding/account_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Account/view/account_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/bindings/add_delivery_address_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/views/add_delivery_address_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/bindings/delivery_location_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/views/delivery_location_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/bindings/notification_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/views/notification_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/bindings/approval_Inbox_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/views/approval_Inbox_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/bindings/inventory_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/views/inventory_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/bindings/report_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Report/views/report_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/bindings/setting_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/views/setting_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/bindings/manufacturer_address_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/views/manufacturer_address_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/bindings/faq_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/views/faq_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FeedBack/bindings/feedback_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FeedBack/views/feedback_view_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/bindings/news_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/News/views/news_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/BusinessHours/bindings/business_hours_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/BusinessHours/views/business_hours_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/bindings/profile_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/bindings/edit_profile_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/views/edit_profile_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/views/profile_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/ReferAndCoupon/bindings/refer_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/ReferAndCoupon/views/refer_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/bindings/add_role_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/views/add_role_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/bindings/add_team_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/views/add_team_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleDetails/bindings/role_details_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleDetails/views/role_details_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/bindings/role_management_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/role_management_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/bindings/add_product_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/views/add_product_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/bindings/product_detail_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/views/product_detail_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/SearchService/bindings/search_service_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/SearchService/views/search_service_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/bindings/create_new_ticket_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/views/creat_new_ticket.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/bindings/request_demo_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/RequestDemo/views/request_demo_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/SuppoerRequestFilter/bindings/support_request_bindings.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/SuppoerRequestFilter/views/support_request_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/bindings/bottom_binding.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/views/bottom_view.dart';
import 'package:construction_technect/app/modules/OnBoarding/bindings/on_boarding_binding.dart';
import 'package:construction_technect/app/modules/OnBoarding/view/on_boarding_screen.dart';
import 'package:construction_technect/app/modules/splash/bindings/splash_binding.dart';
import 'package:construction_technect/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_ROLE,
      page: () => const SignUpRoleView(),
      binding: SignUpRoleBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_DETAILS,
      page: () => SignUpDetailsView(),
      binding: SignUpDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_PASSWORD,
      page: () => SignUpPasswordView(),
      binding: SignUpPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => BottomBarView(),
      binding: BottomBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_HOURS,
      page: () => BusinessHoursView(),
      binding: BusinessHoursBinding(),
    ),

    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),

    GetPage(
      name: _Paths.ADD_LOCATION_MANUALLY,
      page: () => AddLocationManuallyView(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_MANAGEMENT,
      page: () => RoleManagementView(),
      binding: RoleManagementBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ROLE,
      page: () => AddRoleView(),
      binding: AddRoleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TEAM,
      page: () => AddTeamView(),
      binding: AddTeamBinding(),
    ),
    GetPage(
      name: _Paths.APPROVAL_INBOX,
      page: () => ApprovalInboxView(),
      binding: ApprovalInboxBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_DETAILS,
      page: () => const RoleDetailsView(),
      binding: RoleDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK_VIEW,
      page: () => const FeedbackViewScreen(),
      binding: FeedbackBindings(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqScreen(),
      binding: FAQBindings(),
    ),

    // GetPage(
    //   name: _Paths.SERVICE_DETAILS,
    //   page: () => ServiceDetailsView(),
    //   binding: ServiceDetailBinding(),
    // ),
    GetPage(
      name: _Paths.CHAT_SYSTEM,
      page: () => const ChatSystemView(),
      binding: ChatSystemBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTION_INBOX,
      page: () => ConnectionInboxView(),
      binding: ConnectionInboxBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),

    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),

    GetPage(
      name: _Paths.CONNECTOR_PROFILE,
      page: () => const ConnectorProfileView(),
      binding: ConnectorProfileBinding(),
    ),

    GetPage(
      name: Routes.REQUEST_DEMO,
      page: () => RequestDemoView(),
      binding: RequestDemoBinding(),
    ),
    GetPage(
      name: Routes.SUPPORT_REQUEST,
      page: () => const SupportRequestScreen(),
      binding: SupportRequestBindings(),
    ),
    GetPage(
      name: Routes.CREATE_NEW_TICKET,
      page: () => CreatNewTicket(),
      binding: CreateNewTicketBinding(),
    ),
    GetPage(
      name: Routes.REFER_EARN,
      page: () => const ReferAndEarnScreen(),
      binding: ReferBindings(),
    ),
    GetPage(
      name: Routes.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY,
      page: () => InventoryView(),
      binding: InventoryBinding(),
    ),
    GetPage(name: Routes.NEWS, page: () => NewsView(), binding: NewsBinding()),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.ADD_REQUIREMENT,
      page: () => AddRequirementView(),
      binding: AddRequirementBinding(),
    ),
    GetPage(
      name: Routes.REQUIREMENT,
      page: () => RequirementView(),
      binding: RequirementBinding(),
    ),
    GetPage(
      name: Routes.ADD_SERVICE_REQUIREMENT,
      page: () => AddServiceRequirementView(),
      binding: AddServiceRequirementBinding(),
    ),
    GetPage(
      name: Routes.WISH_LIST,
      page: () => WishListView(),
      binding: WishListBinding(),
    ),
    GetPage(
      name: Routes.ON_BOARDING,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.CART_LIST,
      page: () => CartListView(),
      binding: CartListBinding(),
    ),
    GetPage(
      name: Routes.SELECT_PRODUCT,
      page: () => SelectedProductView(),
      // binding: OnBoardingBinding(),
    ),
    GetPage(
      name: Routes.SELECT_SERVICE,
      page: () => ConstructionServiceView(),
      // binding: OnBoardingBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_LOCATION,
      page: () => DeliveryLocationView(),
      binding: DeliveryLocationBinding(),
    ),
    GetPage(
      name: Routes.ADD_DELIVERY_ADDRESS,
      page: () => const AddDeliveryAddressView(),
      binding: AddDeliveryAddressBinding(),
    ),
    GetPage(
      name: Routes.MANUFACTURER_ADDRESS,
      page: () => ManufacturerAddressView(),
      binding: ManufacturerAddressBinding(),
    ),
    GetPage(
      name: Routes.ADD_MANUFACTURER_ADDRESS,
      page: () => AddManufacturerAddressView(),
      binding: AddManufacturerAddressBinding(),
    ),
    GetPage(
      name: Routes.OTP_Verification,
      page: () => const OtpVerificationScreen(),
      binding: SignUpDetailsBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_PRODUCT,
      page: () => SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_SERVICE,
      page: () => SearchServiceView(),
      binding: SearchServiceBinding(),
    ),
    GetPage(
      name: Routes.ADD_SERVICES,
      page: () => AddServiceScreen(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_DETAILS,
      page: () => const ServiceDetailScreen(),
      binding: ServiceDetailBinding(),
    ),
  ];
}
