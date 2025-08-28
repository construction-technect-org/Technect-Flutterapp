import 'package:construction_technect/app/modules/AddLocationManually/bindings/add_location_manually_binding.dart';
import 'package:construction_technect/app/modules/AddLocationManually/views/add_location_manually_view.dart';
import 'package:construction_technect/app/modules/BusinessHours/bindings/business_hours_bindings.dart';
import 'package:construction_technect/app/modules/BusinessHours/views/business_hours_view.dart';
import 'package:construction_technect/app/modules/editProfile/bindings/edit_profile_bindings.dart';
import 'package:construction_technect/app/modules/editProfile/views/edit_profile_view.dart';
import 'package:construction_technect/app/modules/location/bindings/location_bindings.dart';
import 'package:construction_technect/app/modules/location/views/location_view.dart';
import 'package:construction_technect/app/modules/SignUpDetails/bindings/sign_up_details_binding.dart';
import 'package:construction_technect/app/modules/SignUpDetails/views/sign_up_details_view.dart';
import 'package:construction_technect/app/modules/SignUpPassword/bindings/sign_up_password_binding.dart';
import 'package:construction_technect/app/modules/SignUpPassword/views/sign_up_password_view.dart';
import 'package:construction_technect/app/modules/SignUpRole/bindings/sign_up_role_binding.dart';
import 'package:construction_technect/app/modules/SignUpRole/views/sign_up_role_view.dart';
import 'package:construction_technect/app/modules/UpdateYourCertifications/bindings/update_your_certifications_binding.dart';
import 'package:construction_technect/app/modules/UpdateYourCertifications/views/update_your_certifications_view.dart';
import 'package:construction_technect/app/modules/forgotPassword/bindings/forgot_password_binding.dart';
import 'package:construction_technect/app/modules/forgotPassword/views/forgot_password_view.dart';

import 'package:construction_technect/app/modules/login/bindings/login_binding.dart';
import 'package:construction_technect/app/modules/login/views/login_view.dart';
import 'package:construction_technect/app/modules/main/bindings/main_binding.dart';
import 'package:construction_technect/app/modules/main/views/main_view.dart';
import 'package:construction_technect/app/modules/splash/bindings/splash_binding.dart';
import 'package:construction_technect/app/modules/splash/views/splash_view.dart';
import 'package:construction_technect/app/modules/profile/bindings/profile_binding.dart';
import 'package:construction_technect/app/modules/profile/views/profile_view.dart';
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
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
     GetPage(
      name: _Paths.BUSINESS_HOURS,
      page: () => const BusinessHoursView(),
      binding: BusinessHoursBinding(),
    ),
     GetPage(
      name: _Paths.UPDATE_YOUR_CERTIFICATION,
      page: () => const UpdateYourCertificationsView(),
      binding: UpdateYourCertificationsBinding(),
    ),
      GetPage(
      name: _Paths.LOCATION,
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),

    GetPage(
      name: _Paths.ADD_LOCATION_MANUALLY,
      page: () => const AddLocationManuallyView(),
      binding:  AddLocationBinding(),
    ),
  
  ];
}
