import 'package:construction_technect/app/modules/AddLocationManually/bindings/add_location_manually_binding.dart';
import 'package:construction_technect/app/modules/AddLocationManually/views/add_location_manually_view.dart';
import 'package:construction_technect/app/modules/AddProduct/bindings/add_product_binding.dart';
import 'package:construction_technect/app/modules/AddProduct/views/add_product_view.dart';
import 'package:construction_technect/app/modules/AddRole/bindings/add_role_binding.dart';
import 'package:construction_technect/app/modules/AddRole/views/add_role_view.dart';
import 'package:construction_technect/app/modules/AddTeam/bindings/add_team_binding.dart';
import 'package:construction_technect/app/modules/AddTeam/views/add_team_view.dart';
import 'package:construction_technect/app/modules/AddService/bindings/add_service_binding.dart';
import 'package:construction_technect/app/modules/AddService/views/add_service_view.dart';
import 'package:construction_technect/app/modules/Address/bindings/address_bindings.dart';
import 'package:construction_technect/app/modules/Address/views/address_view.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/bindings/approval_Inbox_bindings.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/views/approval_Inbox_view.dart';
import 'package:construction_technect/app/modules/BusinessHours/bindings/business_hours_bindings.dart';
import 'package:construction_technect/app/modules/BusinessHours/views/business_hours_view.dart';
import 'package:construction_technect/app/modules/ChatSystem/binding/chat_system_binding.dart';
import 'package:construction_technect/app/modules/ChatSystem/views/chat_system_view.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/bindings/connection_inbox_binding.dart';
import 'package:construction_technect/app/modules/ConnectionInbox/views/connection_inbox_view.dart';
import 'package:construction_technect/app/modules/Marketplace/bindings/market_place_binding.dart';
import 'package:construction_technect/app/modules/Marketplace/views/market_place_view.dart';
import 'package:construction_technect/app/modules/ProductDetail/bindings/product_detail_binding.dart';
import 'package:construction_technect/app/modules/ProductDetail/views/product_detail_view.dart';
import 'package:construction_technect/app/modules/RoleDetails/bindings/role_details_binding.dart';
import 'package:construction_technect/app/modules/RoleDetails/views/role_details_view.dart';
import 'package:construction_technect/app/modules/RoleManagement/bindings/role_management_binding.dart';
import 'package:construction_technect/app/modules/RoleManagement/views/role_management_view.dart';
import 'package:construction_technect/app/modules/ServiceManagement/controllers/service_management_controller.dart';
import 'package:construction_technect/app/modules/ServiceManagement/views/service_management_view.dart';
import 'package:construction_technect/app/modules/SignUpDetails/bindings/sign_up_details_binding.dart';
import 'package:construction_technect/app/modules/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/SignUpPassword/bindings/sign_up_password_binding.dart';
import 'package:construction_technect/app/modules/SignUpPassword/views/sign_up_password_view.dart';
import 'package:construction_technect/app/modules/SignUpRole/bindings/sign_up_role_binding.dart';
import 'package:construction_technect/app/modules/SignUpRole/views/sign_up_role_view.dart';
import 'package:construction_technect/app/modules/TeamDetails/bindings/team_details_binding.dart';
import 'package:construction_technect/app/modules/TeamDetails/views/team_details_view.dart';
import 'package:construction_technect/app/modules/UpdateYourCertifications/bindings/update_your_certifications_binding.dart';
import 'package:construction_technect/app/modules/UpdateYourCertifications/views/update_your_certifications_view.dart';
import 'package:construction_technect/app/modules/YourRole/bindings/your_role_binding.dart';
import 'package:construction_technect/app/modules/YourRole/views/your_role_view.dart';
import 'package:construction_technect/app/modules/editProfile/bindings/edit_profile_bindings.dart';
import 'package:construction_technect/app/modules/editProfile/views/edit_profile_view.dart';
import 'package:construction_technect/app/modules/forgotPassword/bindings/forgot_password_binding.dart';
import 'package:construction_technect/app/modules/forgotPassword/views/forgot_password_view.dart';
import 'package:construction_technect/app/modules/login/bindings/login_binding.dart';
import 'package:construction_technect/app/modules/login/views/login_view.dart';
import 'package:construction_technect/app/modules/main/bindings/main_binding.dart';
import 'package:construction_technect/app/modules/main/views/main_view.dart';
import 'package:construction_technect/app/modules/profile/bindings/profile_binding.dart';
import 'package:construction_technect/app/modules/profile/views/profile_view.dart';
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
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_ROLE,
      page: () => const SignUpRoleView(),
      binding: SignUpRoleBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_DETAILS,
      page: () => const SignUpDetailsView(),
      binding: SignUpDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_PASSWORD,
      page: () => const SignUpPasswordView(),
      binding: SignUpPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainTabBarView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_HOURS,
      page: () => BusinessHoursView(),
      binding: BusinessHoursBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_YOUR_CERTIFICATION,
      page: () => const UpdateYourCertificationsView(),
      binding: UpdateYourCertificationsBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),

    GetPage(
      name: _Paths.ADD_LOCATION_MANUALLY,
      page: () => const AddLocationManuallyView(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
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
      page: () => const AddRoleView(),
      binding: AddRoleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TEAM,
      page: () => const AddTeamView(),
      binding: AddTeamBinding(),
    ),
    GetPage(
      name: _Paths.APPROVAL_INBOX,
      page: () => const ApprovalInboxView(),
      binding: ApprovalInboxBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_DETAILS,
      page: () => const RoleDetailsView(),
      binding: RoleDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TEAM_DETAILS,
      page: () => const TeamDetailsView(),
      binding: TeamDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MARKET_PLACE,
      page: () => const MarketPlaceView(),
      binding: MarketPlaceBinding(),
    ),
    GetPage(
      name: _Paths.YOUR_ROLE,
      page: () => const YourRoleView(),
      binding: YourRoleBinding(),
    ),
      GetPage(
      name: _Paths.SERVICE_MANAGEMENT,
      page: () => ServiceManagementView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ServiceManagementController>(
          () => ServiceManagementController(),
        );
      }),
    ),
    GetPage(
      name: _Paths.ADD_SERVICE,
      page: () => const AddServiceView(),
      binding: AddServiceBinding(),
    ),
     GetPage(
      name: _Paths.CHAT_SYSTEM,
      page: () => const ChatSystemView(),
      binding: ChatSystemBinding(),
    ),
     GetPage(
      name: _Paths.CONNECTION_INBOX,
      page: () =>  ConnectionInboxView(),
      binding: ConnectionInboxBinding(),
    ),
  ];
}
