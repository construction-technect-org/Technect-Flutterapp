import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:construction_technect/app/modules/Authentication/forgotPassword/views/otp_verification_view.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.loginBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 50),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.sw),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(110),
                      Container(
                        height: 193,
                        width: 234,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Asset.auth),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Center(
                        child: Text(
                          'India’s Fastest Growing\nConstruction Network',
                          style: MyTexts.medium18.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(24),
                      Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Text(
                          'Forgot password',
                          style: MyTexts.medium20.copyWith(
                            color: Colors.black,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                      ),
                      const Gap(24),
                      CommonPhoneField(
                        headerText: "Mobile Number",
                        controller: controller.phoneEmailController,
                        focusNode: FocusNode(),
                        isValid: controller.isValid,
                        customErrorMessage: controller.mobileValidationError,
                        onCountryCodeChanged: (code) {
                          controller.countryCode.value = code;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: 'Request otp',
              onTap: () async {
                if (!formKey.currentState!.validate()) return;
                if (controller.mobileValidationError.isNotEmpty ||
                    controller.mobileValidationError.value != '') {
                  return;
                }
                controller.isValid.value = -1;
                if (controller.phoneEmailController.text.isEmpty) {
                  controller.isValid.value = 0;
                }
                if (formKey.currentState!.validate()) {
                  if (controller.phoneEmailController.text.isEmpty) {
                    controller.isValid.value = 0;
                  } else {
                    await controller.sendOtp().then((val) {
                      Get.to(
                        () => OtpVerificationView(
                          isLoading: controller.isLoading,
                          onTap: () async {
                            await controller.sendOtp().then((val) {
                              controller.startTimer();
                            });
                          },
                          countdownController: controller.countdownController,
                          isResendVisible: controller.isResendVisible,
                          otpController: controller.otpController,
                          onCompleted: (value) {
                            controller.verifyOtp();
                          },
                          onFinished: () {
                            controller.onCountdownFinish();
                          },
                        ),
                      );
                      controller.startTimer();
                    });
                  }

                  // controller.resetPassword();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
