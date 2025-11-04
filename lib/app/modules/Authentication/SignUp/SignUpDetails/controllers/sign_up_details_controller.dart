import 'dart:developer';

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/widget/mobile_number_sp_widget.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:gap/gap.dart';
import 'package:timer_count_down/timer_controller.dart';

class SignUpDetailsController extends GetxController {
  static final SignUpDetailsController to = Get.find();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final gstController = TextEditingController();
  final aadhaarController = TextEditingController();
  SignUpService signUpService = SignUpService();
  final otpSend = false.obs;
  final otpVerify = false.obs;
  RxBool isVerified = false.obs;

  RxInt isValid = (-1).obs;
  RxString countryCode = "+91".obs;
  final RxString mobileValidationError = "".obs;

  final countdownController = CountdownController(autoStart: true);
  RxBool isResendVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool isNavigatingToOtp = false.obs;

  // Email validation state
  RxString emailError = "".obs;
  RxBool isEmailValidating = false.obs;

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> validateGSTAvailability() async {
    final value = gstController.text.trim();
    isVerified.value = await Validate().validateGSTAvailability(value);
  }

  Future<void> validateEmailAvailability(String email) async {
    isEmailValidating.value = true;
    emailError.value = await Validate().validateEmail(email) ?? "";
    isEmailValidating.value = false;
  }

  Future<bool> validateNumberAvailability(String number) async {
    try {
      log("mobileNumber: $number,        countryCode: ${countryCode.value},");

      // Check if mobile number is available
      final isAvailable = await signUpService.checkAvailability(
        mobileNumber: number,
        countryCode: countryCode.value,
      );

      if (!isAvailable) {
        log("This mobile number is already registered:$isAvailable ");
        SnackBars.errorSnackBar(
          content: 'This mobile number is already registered',
        );
        return false;
      } else {
        log("This mobile number is Not registered:$isAvailable ");
        return true;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error verifying mobile number: $e');
      log("validateNumberAvailability: $e");
      return false;
    }
  }

  Future<bool> verifyMobileNumber() async {
    try {
      // First check if mobile number is available
      final isNumberAvailable = await validateNumberAvailability(
        mobileNumberController.text,
      );

      // If number is not available, stop here
      if (!isNumberAvailable) {
        return false;
      }

      // Send OTP if mobile number is available
      if (!otpSend.value) {
        final otpResponse = await signUpService.sendOtp(
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

  // Resend OTP method
  Future<void> sendOtp() async {
    try {
      final otpResponse = await signUpService.resendOtp(
        mobileNumber: mobileNumberController.text,
        code: countryCode.value,
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

  Future<void> proceedToPassword() async {
    await verifyOtp();
  }

  // Future<bool> checkEmail() async {
  //   try {
  //     final isAvailable = await signUpService.checkAvailability(
  //       email: emailController.text,
  //     );

  //     if (!isAvailable) {
  //       SnackBars.errorSnackBar(content: "This email is already registered");
  //       return false;
  //     }

  //     return true;
  //   } catch (e) {
  //     SnackBars.errorSnackBar(
  //       content: "Error verifying email. Please try again",
  //     );
  //     return false;
  //   }
  // }

  // Verify OTP method
  Future<void> verifyOtp() async {
    try {
      final otpResponse = await signUpService.verifyOtp(
        mobileNumber: mobileNumberController.text,
        otp: otpController.text,
      );

      if (otpResponse.success == true) {
        if (otpResponse.data?.verified == true) {
          otpVerify.value = true;
          SnackBars.successSnackBar(content: 'OTP verified successfully!');
          final cont = SignUpRoleController.to;
          final userData = UserDataModel(
            marketPlaceRole: cont.selectedFinalRole.value,
            roleName: cont.selectedRoleName.value,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            countryCode: countryCode.value,
            mobileNumber: mobileNumberController.text,
            email: emailController.text,
            gst: gstController.text,
            aadhaar: aadhaarController.text,
            panCard: "",
            address: "",
          );
          Get.back();
          Get.toNamed(Routes.SIGN_UP_PASSWORD, arguments: userData);
        } else {
          SnackBars.errorSnackBar(
            content: 'OTP verification failed. Please try again.',
          );
        }
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to verify OTP',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void openPhoneNumberBottomSheet() {
    final formKey = GlobalKey<FormState>();
    isValid.value = -1;
    mobileValidationError.value = "";

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
              // CommonPhoneField(
              //   controller: mobileNumberController,
              //   focusNode: FocusNode(),
              //   isValid: isValid,
              //   customErrorMessage: mobileValidationError,
              //   onCountryCodeChanged: (code) {
              //     countryCode.value = code;
              //   },
              // ),
              MobileNumberSpWidget(
                number: mobileNumberController,
                // focusNode: FocusNode(),
                formKey: formKey,
                isValid: isValid,
                customErrorMessage: mobileValidationError,
                onCountryCodeChanged: (code) {
                  countryCode.value = code;
                },
              ),
              const Gap(30),
              RoundedButton(
                buttonName: "Continue",
                onTap: () async {
                  // Clear previous errors
                  isValid.value = -1;
                  mobileValidationError.value = "";

                  // Validate mobile number
                  final mobileNumber = mobileNumberController.text.trim();
                  if (mobileNumber.isEmpty) {
                    isValid.value = 0;
                    return;
                  }

                  final mobileError = ValidationUtils.validateMobileNumber(
                    mobileNumber,
                  );
                  if (mobileError != null) {
                    mobileValidationError.value = mobileError;
                    isValid.value = 1;
                    return;
                  }

                  if (formKey.currentState!.validate()) {
                    hideKeyboard();

                    if (isNavigatingToOtp.value) return;
                    if (Get.currentRoute == Routes.OTP_Verification) return;
                    isNavigatingToOtp.value = true;
                    try {
                      resetOtpState();
                      final sent = await verifyMobileNumber();
                      if (!sent) return;

                      if (Get.isBottomSheetOpen == true) {
                        Get.back();
                      }
                      // Use named route to avoid duplicates
                      resetOtpState();
                      await Get.toNamed(Routes.OTP_Verification);
                    } finally {
                      isNavigatingToOtp.value = false;
                    }
                  }
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }
}
