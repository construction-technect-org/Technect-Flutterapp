import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/login/services/LoginService.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final rememberMe = false.obs;
  RxInt isValid = (-1).obs;
  RxString countryCode = "".obs;
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

    // Check if credentials are saved and auto-fill them
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
    if (mobileController.text.isEmpty || passwordController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please fill all fields');
      return;
    }

    if (mobileController.text.length < 10) {
      SnackBars.errorSnackBar(content: 'Please enter a valid mobile number');
      return;
    }

    isLoading.value = true;

    try {
      final loginResponse = await loginService.login(
        countryCode: "+91",
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

        if (rememberMe.value) {
          myPref.saveCredentials(
            mobileController.text,
            passwordController.text,
          );
        } else {
          myPref.clearCredentials();
        }
        final addressResponse = await homeService.getAddress();
        if (addressResponse.success == true &&
            (addressResponse.data?.addresses?.isNotEmpty ?? false)) {
          myPref.setAddressData(addressResponse.toJson());
          // Get.offAllNamed(Routes.MAIN);
          Get.to(
            () => SuccessScreen(
              title: "Success!",
              header: "Thanks for Connecting !",
              onTap: () {
                Get.offAllNamed(Routes.YOUR_ROLE);
              },
            ),
          );
        } else {
          myPref.clearAddressData();
          Get.to(
            () => SuccessScreen(
              title: "Success!",
              header: "Thanks for Connecting !",
              onTap: () {
                Get.offAllNamed(
                  Routes.ADDRESS,
                  arguments: {'isFromLogin': true},
                );
              },
            ),
          );
        }
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
