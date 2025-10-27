import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/UserDataModel.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/otp_verification_view.dart';
import 'package:gap/gap.dart';
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
  final otpSend = false.obs;
  final otpVerify = false.obs;
  RxBool isVerified = false.obs;

  RxInt isValid = (-1).obs;
  RxString countryCode = "".obs;

  final countdownController = CountdownController(autoStart: true);
  RxBool isResendVisible = false.obs;
  RxBool isLoading = false.obs;

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

  Future<void> verifyMobileNumber() async {
    if (!otpSend.value) {
      final otpResponse = await signUpService.sendOtp(
        mobileNumber: mobileNumberController.text,
      );

      if (otpResponse.success == true) {
        SnackBars.successSnackBar(
          content: 'OTP sent successfully to ${mobileNumberController.text}',
        );
        otpSend.value = true;
      } else {
        SnackBars.errorSnackBar(
          content: otpResponse.message ?? 'Failed to send OTP',
        );
      }
    } else {
      await sendOtp();
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
    } catch (e) {
      otpSend.value = false;
    }
  }

  Future<void> proceedToPassword() async {
    await verifyOtp();
  }

  Future<bool> checkEmail() async {
    try {
      final isAvailable = await signUpService.checkAvailability(
        email: emailController.text,
      );

      if (!isAvailable) {
        SnackBars.errorSnackBar(content: "This email is already registered");
        return false;
      }

      return true;
    } catch (e) {
      SnackBars.errorSnackBar(
        content: "Error verifying email. Please try again",
      );
      return false;
    }
  }

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
          final userData = UserDataModel(
            marketPlaceRole:
                Get.find<SignUpRoleController>().selectedFinalRole.value,
            roleName: Get.find<SignUpRoleController>().selectedRoleName.value,
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
      print(e);
    }
  }

  void openPhoneNumberBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    isValid.value = -1;

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
              const Gap(24),
              CommonPhoneField(
                controller: mobileNumberController,
                focusNode: FocusNode(),
                isValid: isValid,
                onCountryCodeChanged: (code) {
                  countryCode.value = code;
                },
              ),
              const Gap(30),
              RoundedButton(
                buttonName: "Continue",
                onTap: () async {
                  isValid.value = -1;
                  if (mobileNumberController.text.isEmpty) {
                    isValid.value = 0;
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    hideKeyboard();
                    await verifyMobileNumber().then((val) {
                      Get.back();
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
                    });
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
