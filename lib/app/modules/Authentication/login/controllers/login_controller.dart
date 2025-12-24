import 'dart:developer';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/core/services/fcm_service.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/otp_verification_view.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/LoginModel.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';
import 'package:construction_technect/app/modules/Authentication/login/services/LoginService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer_count_down/timer_controller.dart';

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
      // Get FCM token and device type
      final fcmToken = await FCMService.getFCMToken();
      final deviceType = FCMService.getDeviceType();

      final loginResponse = await loginService.login(
        countryCode: countryCode.value,
        mobileNumber: mobileController.text,
        password: passwordController.text,
        fcmToken: fcmToken,
        deviceType: deviceType,
      );

      if (loginResponse.success == true) {
        myPref.setIsTeamLogin(false);
        loginError.value = "";
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

      // Get FCM token and device type
      final fcmToken = await FCMService.getFCMToken();
      final deviceType = FCMService.getDeviceType();

      final loginResponse = await loginService.socialLogin(
        provider: 'google',
        providerId: user.uid,
        firstName: nameParts['firstName'] ?? '',
        lastName: nameParts['lastName'] ?? '',
        email: user.email ?? '',
        profileImage: user.photoURL ?? '',
        roleName: 'Merchant',
        fcmToken: fcmToken,
        deviceType: deviceType,
      );
      if (loginResponse.success == true) {
        myPref.setIsTeamLogin(false);

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

  final mobileNumberController = TextEditingController();
  RxInt isValidd = (-1).obs;
  RxString countryCodee = "+91".obs;
  RxString numberError = "".obs;

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

  void openPhoneNumberBottomSheet() {
    final formKey = GlobalKey<FormState>();
    isValidd.value = -1;
    numberError.value = "";

    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Gap(24),
              Text(
                "Mobile Number",
                style: MyTexts.medium20.copyWith(color: Colors.black),
              ),
              const Gap(5),
              CommonPhoneField(
                controller: mobileNumberController,
                focusNode: FocusNode(),
                isValid: isValidd,
                customErrorMessage: numberError,
                onCountryCodeChanged: (code) {
                  countryCodee.value = code;
                },
              ),
              const Gap(15),
              RoundedButton(
                buttonName: "Continue",
                onTap: () async {
                  isValidd.value = -1;
                  numberError.value = "";

                  if (!formKey.currentState!.validate()) return;

                  // final mobileNumber = mobileNumberController.text.trim();
                  // final mobileError = await Validate.validateMobileNumberAsync(
                  //   mobileNumber,
                  //   countryCode: countryCode.value,
                  // );
                  //
                  // if (mobileError != null && mobileError.isNotEmpty) {
                  //   numberError.value = mobileError;
                  //   isValid.value = 1;
                  //   return;
                  // }

                  hideKeyboard();

                  try {
                    resetOtpState();
                    final sent = await verifyMobileNumber();
                    if (!sent) return;

                    if (Get.isBottomSheetOpen == true) {
                      Get.back();
                    }

                    // Use named route to avoid duplicates
                    resetOtpState();
                    Get.to(
                      () => OtpVerificationView(
                        isLoading: isLoading,
                        onTap: () async {
                          await sendOtp().then((val) {
                            startTimer();
                          });
                        },
                        countdownController: countdownController,
                        isResendVisible: isResendVisible,
                        otpController: otpController,
                        onCompleted: (value) {
                          verifyOtp();
                        },
                        onFinished: () {
                          onCountdownFinish();
                        },
                      ),
                    );
                    startTimer();
                    // await Get.offNamed(Routes.OTP_Verification);
                  } finally {}
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ).whenComplete(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  final countdownController = CountdownController(autoStart: true);

  Future<String?> validateNumberAvailability(String number) async {
    return await Validate.validateMobileNumberAsync(
      number,
      countryCode: countryCode.value,
    );
  }

  Future<bool> verifyMobileNumber() async {
    try {
      // final availabilityError = await validateNumberAvailability(
      //   mobileNumberController.text,
      // );
      // if (availabilityError != null && availabilityError.isNotEmpty) {
      //   numberError.value = availabilityError;
      //   return false;
      // }

      // Send OTP if mobile number is available
      if (!otpSend.value) {
        final otpResponse = await SignUpService().teamSendOtp(
          mobileNumber: mobileNumberController.text,
        );

        if (otpResponse.success == true) {
          SnackBars.successSnackBar(
            content: 'OTP sent successfully to ${mobileNumberController.text}',
          );
          otpSend.value = true;
          return true;
        } else {
          SnackBars.errorSnackBar(
            content: otpResponse.message ?? 'Failed to send OTP',
          );
          return false;
        }
      } else {
        await sendOtp();
        return true;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error sending OTP: $e');
      log("verifyMobileNumber: $e");
      return false;
    }
  }

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  Future<void> sendOtp() async {
    try {
      final otpResponse = await SignUpService().teamResendOtp(
        mobileNumber: mobileNumberController.text,
      );

      if (otpResponse.success == true) {
        SnackBars.successSnackBar(
          content: 'OTP resent successfully to ${mobileNumberController.text}',
        );
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to resend OTP',
        );
        otpSend.value = false;
      }
      startTimer();
    } catch (e) {
      otpSend.value = false;
    }
  }

  void resetOtpState() {
    try {
      otpSend.value = false;
      otpVerify.value = false;
      isResendVisible.value = false;
      otpController.text = '';
      // Safely stop/reset countdown if supported
      try {
        countdownController.restart();
      } catch (_) {}
    } catch (_) {}
  }

  final otpController = TextEditingController();

  final otpSend = false.obs;
  final otpVerify = false.obs;
  RxBool isVerified = false.obs;
  RxBool isResendVisible = false.obs;

  // Verify OTP method
  Future<void> verifyOtp() async {
    try {
      // Get FCM token and device type
      final fcmToken = await FCMService.getFCMToken();
      final deviceType = FCMService.getDeviceType();

      final loginResponse = await LoginService().teamLogin(
        mobileNumber: mobileNumberController.text,
        otp: otpController.text,
        fcmToken: fcmToken,
        deviceType: deviceType,
      );

      if (loginResponse.success == true) {
        otpVerify.value = true;
        SnackBars.successSnackBar(content: 'OTP verified successfully!');
        Get.back();
        myPref.setIsTeamLogin(true);
        myPref.setDashboard("marketplace");
        myPref.setRole("partner");
        if (loginResponse.data?.token != null) {
          myPref.setToken(loginResponse.data?.token ?? '');
        }

        if (loginResponse.data?.user != null) {
          myPref.setUserModel(loginResponse.data?.user ?? UserModel());
        }
        final permissionsValue = extractPermissions(
          loginResponse.data?.teamMember,
        );
        myPref.setPermissions(permissionsValue);
        //
        // if ((loginResponse.data?.user?.marketPlaceRole ?? "").toLowerCase() !=
        //     "partner") {
        //   myPref.setRole("partner");
        // } else {
        //   myPref.setRole("connector");
        // }
        // if (rememberMe.value) {
        //   myPref.saveCredentials(
        //     mobileController.text,
        //     passwordController.text,
        //   );
        // } else {
        //   myPref.clearCredentials();
        // }
        Get.offAll(
          () => SuccessScreen(
            title: "Success!",
            header: "Thanks for Connecting !",
            onTap: () {
              Get.find<CommonController>().fetchProfileData();
              // Get.find<CommonController>().loadTeamFromStorage();
              Get.offAllNamed(Routes.MAIN);
            },
          ),
        );
      } else {
        SnackBars.errorSnackBar(
          content: loginResponse.message ?? 'Failed to verify OTP',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

String extractPermissions(TeamMemberModel? data) {
  if (data == null) return '';
   return data.roles
        ?.map((r) => r.functionalities ?? '')
        .where((e) => e.isNotEmpty)
        .join(',') ??
        '';
}
