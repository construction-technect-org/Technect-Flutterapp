import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/login/services/LoginService.dart';
import 'package:construction_technect/main.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;

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
        // Store token and user data
        if (loginResponse.data?.token != null) {
          myPref.setToken(loginResponse.data?.token ?? '');
        }

        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }

        // Save credentials if remember me is checked
        if (rememberMe.value) {
          myPref.saveCredentials(mobileController.text, passwordController.text);
        } else {
          // Clear saved credentials if remember me is unchecked
          myPref.clearCredentials();
        }

        // SnackBars.successSnackBar(content: 'Login successful!');
        Get.offAllNamed(Routes.MAIN);
      } else {
        SnackBars.errorSnackBar(content: loginResponse.message ?? 'Login failed');
      }
    } catch (e) {
      // Error is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
