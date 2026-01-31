import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AadharOtpVerificationView extends StatefulWidget {
  const AadharOtpVerificationView({super.key});

  @override
  State<AadharOtpVerificationView> createState() =>
      _AadharOtpVerificationViewState();
}

class _AadharOtpVerificationViewState extends State<AadharOtpVerificationView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _localOtpController;
  final SignUpRoleController contr = Get.find<SignUpRoleController>();

  @override
  void initState() {
    super.initState();
    _localOtpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        width: double.maxFinite,
        //height: 32.h,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SizedBox(
                width: double.maxFinite,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  useHapticFeedback: true,
                  useExternalAutoFillGroup: true,
                  controller: _localOtpController,
                  onCompleted: (value) async {
                    contr.otpController.text = value;
                    await contr.verifyAadharOTP();
                  },
                  keyboardType: TextInputType.number,
                  textStyle: MyTexts.extraBold16.copyWith(
                    color: MyColors.primary,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    borderWidth: 0.5,
                    fieldHeight: 54,
                    fieldWidth: width / 8,
                    activeFillColor: MyColors.white,
                    inactiveFillColor: MyColors.white,
                    selectedFillColor: MyColors.white,
                    activeColor: MyColors.primary,
                    inactiveColor: MyColors.gra54EA,
                    selectedColor: MyColors.primary,
                  ),
                  enableActiveFill: true,
                  animationType: AnimationType.fade,
                ),
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors.grayE6,
                border: Border.all(color: MyColors.grayC2),
              ),
              child: Center(
                child: Text(
                  "Enter the OTP sent to your mobile number",
                  style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                ),
              ),
            ),
            const Gap(20),
            Obx(() {
              return contr.isResendVisible.value
                  ? GestureDetector(
                      onTap: () async {
                        await contr.sendOTPAadhar().then((val) {
                          contr.startTimer();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn’t receive the OTP?  ",
                            style: MyTexts.regular16.copyWith(
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                          Text(
                            " Resend OTP",
                            style: MyTexts.bold16.copyWith(
                              color: MyColors.primary,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Countdown(
                      controller: contr.countdownController,
                      seconds: 60,
                      interval: const Duration(milliseconds: 100),
                      build: (_, double time) {
                        return Text(
                          "Resend in 00:${time.ceil().toString().padLeft(2, '0')}",
                          style: MyTexts.bold16.copyWith(color: MyColors.green),
                        );
                      },
                      onFinished: () {
                        contr.onCountdownFinish();
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
