import 'dart:developer';

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/core/widgets/verifying_otp_screen.dart';
//import 'package:construction_technect/app/core/widgets/success_screen.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/sign_up_service.dart';
import 'package:phone_number_hint/phone_number_hint.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/otp_verification_screen.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';
//import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:timer_count_down/timer_controller.dart';

class SignUpDetailsController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final gstController = TextEditingController();
  final aadhaarController = TextEditingController();
  SignUpService signUpService = SignUpService();
  final MainSignUpService _mainSignUpService = Get.find<MainSignUpService>();
  final otpSend = false.obs;
  final otpVerify = false.obs;
  RxBool isVerified = false.obs;
  FocusNode emailFocusNode = FocusNode();

  RxInt isValid = (-1).obs;
  RxString countryCode = "+91".obs;
  RxString numberError = "".obs;
  RxInt phonTap = 0.obs;
  final _phoneNumberHintPlugin = PhoneNumberHint();

  // final RxString mobileValidationError = "".obs;

  Future<void> getPhoneNumber() async {
    String? result;
    phonTap.value++;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      if (phonTap.value < 2) {
        result = await _phoneNumberHintPlugin.requestHint() ?? '';
        if (result.isNotEmpty) {
          mobileNumberController.text = result.substring(3);
        }
      }
    } on PlatformException {
      result = 'Failed to get hint.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  final countdownController = CountdownController(autoStart: true);
  RxBool isResendVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOTPLoading = false.obs;

  // Email validation state
  RxString emailError = "".obs;
  RxBool isEmailValidating = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Init called again");
    mobileNumberController.text = "";
    emailController.text = "";
    //emailError.value = "";
    //numberError.value = "";
  }

  void startTimer() {
    isResendVisible.value = false;
    countdownController.restart();
  }

  void onCountdownFinish() {
    isResendVisible.value = true;
  }

  Future<void> validateGSTAvailability() async {
    final value = gstController.text.trim();
    isVerified.value = await Validate.validateGSTAvailability(value);
  }

  Future<void> validateEmailAvailability(String email) async {
    // First check format validation - if format is invalid, don't check API
    final formatError = Validate.validateEmail(email);
    if (formatError != null) {
      // Format error - clear API error, format error will be shown by validator
      emailError.value = "";
      isEmailValidating.value = false;
      return;
    }

    // Format is valid, now check availability via API
    // validateEmailAsync already checks format first, but we check here to avoid API call
    isEmailValidating.value = true;
    // final apiError = await Validate.validateEmailAsync(email);
    // apiError will be null if format is invalid (handled above), or error message if API fails
    // emailError.value = apiError ?? "";
    isEmailValidating.value = false;
  }

  Future<String?> validateNumberAvailability(String number) async {
    // Use the new async validation that checks format first, then availability
    return await Validate.validateMobileNumberAsync(number, countryCode: countryCode.value);
  }

  Future<bool> verifyMobileNumber() async {
    try {
      // First check if mobile number is available
      final availabilityError = await validateNumberAvailability(mobileNumberController.text);

      // If number is not available, return error message
      // Empty string means valid, null also means valid (shouldn't happen with async)
      if (availabilityError != null && availabilityError.isNotEmpty) {
        numberError.value = availabilityError;
        return false;
      }

      // Send OTP if mobile number is available
      if (!otpSend.value) {
        final otpResponse = await signUpService.sendOtp(mobileNumber: mobileNumberController.text);

        if (otpResponse.success == true) {
          SnackBars.successSnackBar(
            content: 'OTP sent successfully to ${mobileNumberController.text}',
          );
          otpSend.value = true;
          return true;
        } else {
          SnackBars.errorSnackBar(content: otpResponse.message ?? 'Failed to send OTP');
          return false;
        }
      } else {
        await sendOtp();
        return true;
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error sending OTP');
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
        SnackBars.errorSnackBar(content: otpResponse.message ?? 'Failed to resend OTP');
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

  // Verify OTP method
  Future<void> verifyOtp() async {
    try {
      isOTPLoading.value = true;

      final otpResponse = await _mainSignUpService.verifyOtp(
        mobileNumber: mobileNumberController.text,
        otp: otpController.text,
        countryCode: countryCode.value,
      );

      print("OTP response = $otpResponse");

      if (otpResponse.success == true) {
        if (isOTPLoading.value) {
          Get.offAll(
            () => VerifyingOtpScreen(
              header: "Verifying the OTP",
              onTap: () {
                if (otpResponse.user?.phoneVerified == true) {
                  print("Token Verification");
                  print("Token ${otpResponse.token}");
                  otpVerify.value = true;
                  myPref.setToken(otpResponse.token!);
                  myPref.setTokenType(otpResponse.tokenType!);
                  myPref.setPhone(mobileNumberController.text.trim());
                  myPref.setEmail(emailController.text.trim());
                  myPref.setCC(countryCode.value);
                  SnackBars.successSnackBar(content: 'OTP verified successfully!');

                  Get.back();
                  Get.to(
                    () => SuccessScreen(
                      title: "Success!",
                      header: "OTP Verified Successfully",
                      onTap: () {
                        Get.offAllNamed(Routes.SIGN_UP_ROLE);
                      },
                    ),
                  );
                } else {
                  SnackBars.errorSnackBar(content: 'OTP verification failed. Please try again.');
                }
              },
            ),
          );
        }
      } else {
        SnackBars.errorSnackBar(content: otpResponse.message ?? 'Failed to verify OTP');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isOTPLoading.value = false;
    }
  }

  void openPhoneNumberBottomSheet() {
    final formKey = GlobalKey<FormState>();
    isValid.value = -1;
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
              Text("Mobile Number", style: MyTexts.medium20.copyWith(color: Colors.black)),
              const Gap(5),
              CommonPhoneField(
                controller: mobileNumberController,
                focusNode: FocusNode(),
                isValid: isValid,
                customErrorMessage: numberError,
                onCountryCodeChanged: (code) {
                  countryCode.value = code;
                },
              ),
              const Gap(15),
              RoundedButton(
                buttonName: "Continue",
                onTap: () async {
                  isValid.value = -1;
                  numberError.value = "";

                  if (!formKey.currentState!.validate()) return;

                  final mobileNumber = mobileNumberController.text.trim();
                  final mobileError = await Validate.validateMobileNumberAsync(
                    mobileNumber,
                    countryCode: countryCode.value,
                  );

                  if (mobileError != null && mobileError.isNotEmpty) {
                    numberError.value = mobileError;
                    isValid.value = 1;
                    return;
                  }

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
                    await Get.offNamed(Routes.OTP_Verification);
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
}
