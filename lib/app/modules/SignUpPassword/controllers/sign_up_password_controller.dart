import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/SignUpDetails/model/UserDataModel.dart';

class SignUpPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final password = ''.obs;
  final confirmPassword = ''.obs;

  SignUpService signUpService = SignUpService();
  final isLoading = false.obs;

  UserDataModel? userData;

  @override
  void onInit() {
    super.onInit();

    // Get user data passed from previous screen
    final arguments = Get.arguments;
    if (arguments != null && arguments is UserDataModel) {
      userData = arguments;
    }

    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    confirmPasswordController.addListener(() {
      confirmPassword.value = confirmPasswordController.text;
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  bool isFormValid() {
    return password.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        password.value == confirmPassword.value &&
        password.value.length >= 8;
  }

  Future<void> completeSignUp() async {
    if (!isFormValid()) {
      if (password.value.isEmpty || confirmPassword.value.isEmpty) {
        SnackBars.errorSnackBar(content: 'Please fill all required fields');
      } else if (password.value != confirmPassword.value) {
        SnackBars.errorSnackBar(content: 'Passwords do not match');
      } else if (password.value.length < 8) {
        SnackBars.errorSnackBar(
          content: 'Password must be at least 8 characters long',
        );
      }
      return;
    }

    isLoading.value = true;

    try {
      // Check if user data is available
      if (userData == null) {
        SnackBars.errorSnackBar(
          content: 'User data not found. Please try again.',
        );
        return;
      }

      final signUpResponse = await signUpService.signup(
        roleId: userData!.roleId,
        firstName: userData!.firstName,
        lastName: userData!.lastName,
        countryCode: userData!.countryCode,
        mobileNumber: userData!.mobileNumber,
        email: userData!.email,
        password: password.value,
        confirmPassword: confirmPassword.value,
      );

      if (signUpResponse.success == true) {
        // Store token and user data for future use
        if (signUpResponse.data?.token != null) {
          // You can store this token in local storage for authentication
          print('Token: ${signUpResponse.data!.token}');
          print('User ID: ${signUpResponse.data!.user?.id}');
          print('Role: ${signUpResponse.data!.user?.roleName}');
        }

        SnackBars.successSnackBar(content: 'Account created successfully!');
        Get.offAllNamed(Routes.LOGIN);
      } else {
        SnackBars.errorSnackBar(
          content: signUpResponse.message ?? 'Failed to create account',
        );
      }
    } catch (e) {
      // Error snackbar is already shown by ApiManager
    } finally {
      isLoading.value = false;
    }
  }
}
