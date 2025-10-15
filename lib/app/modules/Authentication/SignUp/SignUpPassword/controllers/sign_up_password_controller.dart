// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:construction_technect/app/core/widgets/success_screen.dart';
// import 'package:construction_technect/app/modules/SignUpDetails/SignUpService/SignUpService.dart';
// import 'package:construction_technect/app/modules/SignUpDetails/model/UserDataModel.dart';

// class SignUpPasswordController extends GetxController {
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   final password = ''.obs;
//   final confirmPassword = ''.obs;
//   final isPasswordVisible = false.obs;
//   final isConfirmPasswordVisible = false.obs;

//   SignUpService signUpService = SignUpService();
//   final isLoading = false.obs;

//   UserDataModel? userData;

//   @override
//   void onInit() {
//     super.onInit();

//     // Get user data passed from previous screen
//     final arguments = Get.arguments;
//     if (arguments != null && arguments is UserDataModel) {
//       userData = arguments;
//     }

//     passwordController.addListener(() {
//       password.value = passwordController.text;
//     });
//     confirmPasswordController.addListener(() {
//       confirmPassword.value = confirmPasswordController.text;
//     });
//   }

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
//   }

//   @override
//   void onClose() {
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }

//   bool isFormValid() {
//     return password.value.isNotEmpty &&
//         confirmPassword.value.isNotEmpty &&
//         password.value == confirmPassword.value &&
//         password.value.length >= 8;
//   }

//   Future<void> completeSignUp() async {
//     if (!isFormValid()) {
//       if (password.value.isEmpty || confirmPassword.value.isEmpty) {
//         SnackBars.errorSnackBar(content: 'Please fill all required fields');
//       } else if (password.value != confirmPassword.value) {
//         SnackBars.errorSnackBar(content: 'Passwords do not match');
//       } else if (password.value.length < 8) {
//         SnackBars.errorSnackBar(content: 'Password must be at least 8 characters long');
//       }
//       return;
//     }

//     isLoading.value = true;

//     try {
//       // Check if user data is available
//       if (userData == null) {
//         SnackBars.errorSnackBar(content: 'User data not found. Please try again.');
//         return;
//       }

//       final signUpResponse = await signUpService.signup(
//         roleName: userData!.roleName,
//         firstName: userData!.firstName,
//         lastName: userData!.lastName,
//         countryCode: userData!.countryCode,
//         mobileNumber: userData!.mobileNumber,
//         email: userData!.email,
//         password: password.value,
//         gst: userData!.gst,
//         confirmPassword: confirmPassword.value,
//       );

//       if (signUpResponse.success == true) {
//         Get.to(
//               () => SuccessScreen(
//             title: "Success!",
//             header: "Account created successfully !",
//             image: Asset.forgetSImage,
//             onTap: () {
//               Get.offAllNamed(Routes.ADD_LOCATION_MANUALLY);
//             },
//           ),
//         );
//       } else {
//         SnackBars.errorSnackBar(
//           content: signUpResponse.message ?? 'Failed to create account',
//         );
//       }
//     } catch (e) {
//       // Error snackbar is already shown by ApiManager
//     } finally {
//       isLoading.value = false;
//     }
//   }

// }

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';

class SignUpPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  SignUpService signUpService = SignUpService();
  final isLoading = false.obs;

  UserDataModel? userData;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is UserDataModel) {
      userData = arguments;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> completeSignUp() async {
    isLoading.value = true;

    try {
      if (userData == null) {
        SnackBars.errorSnackBar(
          content: 'User data not found. Please try again.',
        );
        return;
      }

      final signUpResponse = await signUpService.signup(
        roleName: userData!.roleName,
        firstName: userData!.firstName,
        lastName: userData!.lastName,
        countryCode: userData!.countryCode,
        mobileNumber: userData!.mobileNumber,
        email: userData!.email,
        password: passwordController.text,
        gst: userData!.gst,
        confirmPassword: confirmPasswordController.text,
      );

      if (signUpResponse.success == true) {
        if (signUpResponse.data?.token != null) {
          myPref.setToken(signUpResponse.data!.token!);
        }
        if (signUpResponse.data?.user != null) {
          myPref.setUserModel(signUpResponse.data!.user!);
        }

        if (userData!.roleName !=
            "House-Owner") {
          myPref.setRole("partner");
        } else {
          myPref.setRole("connector");
        }
        Get.to(
          () => SuccessScreen(
            title: "Success!",
            header: "Account created successfully !",
            image: Asset.forgetSImage,
            onTap: () {
              Get.offAllNamed(Routes.MAIN,);
            },
          ),
        );
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
