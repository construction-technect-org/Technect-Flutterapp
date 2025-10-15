import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/Authentication/login/services/LoginService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final rememberMe = false.obs;
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
  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      final loginResponse = await loginService.login(
        countryCode: countryCode.value,
        mobileNumber: mobileController.text,
        password: passwordController.text,
      );

      if (loginResponse.success == true) {
        if (loginResponse.data?.token != null) {
          myPref.setToken(loginResponse.data?.token ?? '');
        }

        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }

        if (loginResponse.data?.user?.roleName !=
            "House-Owner") {
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
              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        SnackBars.errorSnackBar(
          content: loginResponse.message ?? 'Login failed',
        );
      }
    } catch (e) {
      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }
}
