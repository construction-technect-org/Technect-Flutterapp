import "dart:developer";


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

import 'package:construction_technect/app/core/services/app_service.dart';
import 'package:construction_technect/app/core/services/fcm_service.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/sign_up_service.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignUpPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final rememberMe = false.obs;

  final MainSignUpService _mainSignUpService = Get.find<MainSignUpService>();
  final AppHiveService _appHiveService = Get.find<AppHiveService>();

  SignUpService signUpService = SignUpService();
  final isLoading = false.obs;

  UserDataModel? userData;
  String? firstName;
  String? lastName;
  String? role;
  String? phone;
  String? email;
  String? cc;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map;

    firstName = arguments['firstName'];
    lastName = arguments['lastName'];
    phone = myPref.getPhone();
    email = myPref.getEmail();
    role = myPref.getRole();
    cc = myPref.getCC();
    // if (arguments != null && arguments is UserDataModel) {
    //   userData = arguments;
    // }
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

  Future<void> _getCurrentLocation() async {
    try {
      //isLoading.value = true;

      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        SnackBars.errorSnackBar(
          content:
              'Location services are disabled. Please enable location services.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SnackBars.errorSnackBar(content: 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        SnackBars.errorSnackBar(
          content: 'Location permissions are permanently denied.',
        );
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      //_getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error getting current location: $e');
    }
  }

  Future<void> signUpComplete() async {
    isLoading.value = true;

    try {
      final fcmToken = await FCMService.getFCMToken();
      final deviceType = FCMService.getDeviceType();
      await _getCurrentLocation();
      log("YEs Done ${currentPosition.value}");
      final response = await _mainSignUpService.completeSignUp(
        roleName: role == "connector" ? "connector" : "merchant",
        firstName: firstName!,
        lastName: lastName!,
        //countryCode: cc!,
        //mobileNumber: phone!,
        //email: email!,
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        fcmToken: fcmToken,
        deviceType: deviceType,
        address: {
          "latitude": currentPosition.value.latitude,
          "longitude": currentPosition.value.longitude,
        },
        referralCode: "",
      );
      log("NotDone");
      if (response.success == true) {
        SnackBars.successSnackBar(content: "Password set Successfully");
        if (response.token != null) {
          await _appHiveService.setToken(response.token!);
          await _appHiveService.setTokenType(response.tokenType!);
          myPref.setToken(response.token!);
          myPref.setTokenType(response.tokenType!);
        }
        if (response.user != null) {
          await _appHiveService.setUser(response.user ?? UserMainModel());
          myPref.setUserModel(response.user ?? UserMainModel());
          log("LAst ${response.user?.firstName}");
        }
        //if (response.user != null) {

        //}

        if (rememberMe.value) {
          myPref.saveCredentials(phone!, passwordController.text.trim());
        } else {
          myPref.clearCredentials();
        }

        Get.to(
          () => SuccessScreen(
            title: "Success!",
            header: "New password set",
            image: Asset.forgetSImage,
            onTap: () {
              //et.find<CommonController>().fetchProfileData();
              //Get.find<CommonController>().loadTeamFromStorage();
              log("Sone signup");

              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        SnackBars.errorSnackBar(
          content: response.message ?? 'Failed to create account',
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /* Future<void> completeSignUp() async {
    isLoading.value = true;

    try {
      if (userData == null) {
        SnackBars.errorSnackBar(
          content: 'User data not found. Please try again.',
        );
        return;
      }

      // Get FCM token and device type
      final fcmToken = await FCMService.getFCMToken();
      final deviceType = FCMService.getDeviceType();

      final signUpResponse = await signUpService.signup(
        roleName: userData!.roleName,
        firstName: userData!.firstName,
        lastName: userData!.lastName,
        marketPlaceRole: userData!.marketPlaceRole,
        countryCode: userData!.countryCode,
        mobileNumber: userData!.mobileNumber,
        email: userData!.email,
        password: passwordController.text,
        gst: userData!.gst,
        confirmPassword: confirmPasswordController.text,
        address: userData!.address,
        aadhaar: userData!.aadhaar,
        panCard: userData!.panCard,
        fcmToken: fcmToken,
        deviceType: deviceType,
      );

      if (signUpResponse.success == true) {
        SnackBars.successSnackBar(content: "Password set Successfully");
        if (signUpResponse.data?.token != null) {
          myPref.setToken(signUpResponse.data!.token!);
        }
        if (signUpResponse.data?.user != null) {
          myPref.setUserModel(signUpResponse.data!.user!);
        }

        if (rememberMe.value) {
          myPref.saveCredentials(
            userData!.mobileNumber,
            passwordController.text,
          );
        } else {
          myPref.clearCredentials();
        }

        Get.to(
          () => SuccessScreen(
            title: "Success!",
            header: "New password set",
            image: Asset.forgetSImage,
            onTap: () {
              Get.find<CommonController>().fetchProfileData();
              Get.find<CommonController>().loadTeamFromStorage();
              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        SnackBars.errorSnackBar(
          content: signUpResponse.message ?? 'Failed to create account',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  } */
}
