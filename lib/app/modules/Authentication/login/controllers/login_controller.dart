import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/Authentication/login/services/LoginService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final rememberMe = false.obs;
  final RxString loginError = "".obs;
  final RxString mobileValidationError = "".obs;
  RxInt isValid = (-1).obs;
  RxString countryCode = "+91".obs;
  HomeService homeService = HomeService();

  LoginService loginService = LoginService();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    if (myPref.isRememberMeEnabled()) {
      final savedMobile = myPref.getSavedMobileNumber();
      final savedPassword = myPref.getSavedPassword();

      if (savedMobile.isNotEmpty && savedPassword.isNotEmpty) {
        mobileController.text = savedMobile;
        passwordController.text = savedPassword;
        rememberMe.value = true;
      }
    }

    // Clear error when user starts typing
    mobileController.addListener(() {
      if (loginError.value.isNotEmpty) {
        loginError.value = "";
      }
      if (mobileValidationError.value.isNotEmpty) {
        mobileValidationError.value = "";
        isValid.value = -1;
      }
    });

    passwordController.addListener(() {
      if (loginError.value.isNotEmpty) {
        loginError.value = "";
      }
    });
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    mobileFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  Future<void> login() async {
    isLoading.value = true;
    loginError.value = ""; // Clear previous errors

    try {
      final loginResponse = await loginService.login(
        countryCode: countryCode.value,
        mobileNumber: mobileController.text,
        password: passwordController.text,
      );

      if (loginResponse.success == true) {
        loginError.value = ""; // Clear error on success
        if (loginResponse.data?.token != null) {
          myPref.setToken(loginResponse.data?.token ?? '');
        }

        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }

        if ((loginResponse.data?.user?.marketPlaceRole ?? "").toLowerCase() ==
            "partner") {
          myPref.setRole("partner");
        } else {
          myPref.setRole("connector");
        }
        if (rememberMe.value) {
          myPref.saveCredentials(
            mobileController.text,
            passwordController.text,
          );
        } else {
          myPref.clearCredentials();
        }
        Get.offAll(
          () => SuccessScreen(
            title: "Success!",
            header: "Thanks for Connecting !",
            onTap: () {
              Get.find<CommonController>().fetchProfileData();
              Get.find<CommonController>().loadTeamFromStorage();
              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        loginError.value =
            loginResponse.message ?? 'Invalid mobile number or password';
      }
    } catch (e) {
      loginError.value = "Invalid mobile number or password";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> callSocialLoginAPI(User user) async {
    try {
      final loginService = LoginService();

      final nameParts = loginService.extractNameParts(user.displayName ?? '');

      final loginResponse = await loginService.socialLogin(
        provider: 'google',
        providerId: user.uid,
        firstName: nameParts['firstName'] ?? '',
        lastName: nameParts['lastName'] ?? '',
        email: user.email ?? '',
        profileImage: user.photoURL ?? '',
        roleName: 'Merchant',
      );
      if (loginResponse.success == true) {
        if (loginResponse.data?.token != null) {
          myPref.setToken(loginResponse.data?.token ?? '');
        }

        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }

        if ((loginResponse.data?.user?.marketPlaceRole ?? "").toLowerCase() !=
            "partner") {
          myPref.setRole("partner");
        } else {
          myPref.setRole("connector");
        }
        if (rememberMe.value) {
          myPref.saveCredentials(
            mobileController.text,
            passwordController.text,
          );
        } else {
          myPref.clearCredentials();
        }
        Get.offAll(
          () => SuccessScreen(
            title: "Success!",
            header: "Thanks for Connecting !",
            onTap: () {
              Get.find<CommonController>().fetchProfileData();
              Get.find<CommonController>().loadTeamFromStorage();
              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        loginError.value = loginResponse.message ?? 'Login failed';
      }
    } catch (e) {
      loginError.value = "Something went wrong";
    }
  }
}
