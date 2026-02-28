import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController _localOtpController;
  final contr = Get.find<SignUpDetailsController>();
  final ValueNotifier<bool> isOtpComplete = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _localOtpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: Text("OTP Verification"), isCenter: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Gap(32),

              /// 🔹 Title
              const Text(
                "Enter OTP to proceed",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              ),

              const SizedBox(height: 8),

              /// 🔹 OTP Sent Text (Single Line)
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "OTP sent to ",
                          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                        ),
                        TextSpan(
                          text: "${contr.countryCode.value} ${contr.mobileNumberController.text}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2F80ED),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (contr.emailController.text.isNotEmpty) ...[
                          const TextSpan(
                            text: " and ",
                            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                          ),
                          TextSpan(
                            text: contr.emailController.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2F80ED),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1, // 👈 Force single line
                    overflow: TextOverflow.ellipsis, // 👈 Show ...
                  ),
                ),
              ),

              const SizedBox(height: 4),

              /// 🔹 Go Back (Next Line)
              GestureDetector(
                onTap: () => Get.back(),
                child: const Text(
                  "Go back to Edit.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2F80ED),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: SizedBox(
                  width: 290,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    useHapticFeedback: true,
                    useExternalAutoFillGroup: true,
                    controller: _localOtpController,
                    onCompleted: (value) {
                      contr.otpController.text = value;
                      contr.verifyOtp();
                      isOtpComplete.value = true;
                    },
                    onChanged: (value) {
                      isOtpComplete.value = value.length == 4;
                    },
                    keyboardType: TextInputType.number,
                    textStyle: MyTexts.extraBold16.copyWith(color: MyColors.primary),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 0.5,
                      fieldHeight: 64,
                      fieldWidth: 64,
                      activeFillColor: MyColors.white,
                      inactiveFillColor: MyColors.greyFive,
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
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: MyColors.grayE6,
              //     border: Border.all(color: MyColors.grayC2),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "Enter the OTP sent to your email and mobile number",
              //       style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
              //     ),
              //   ),
              // ),
              const Gap(20),
              // Obx(() {
              //   return contr.isResendVisible.value
              //       ? GestureDetector(
              //           onTap: () async {
              //             await contr.sendOtp();
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "Didn’t receive the OTP?  ",
              //                 style: MyTexts.regular16.copyWith(
              //                   fontFamily: MyTexts.SpaceGrotesk,
              //                 ),
              //               ),
              //               Text(
              //                 " Resend OTP",
              //                 style: MyTexts.bold16.copyWith(
              //                   color: MyColors.primary,
              //                   fontFamily: MyTexts.SpaceGrotesk,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       : Countdown(
              //           controller: contr.countdownController,
              //           seconds: 30,
              //           interval: const Duration(milliseconds: 100),
              //           build: (_, double time) {
              //             return Text(
              //               "Resend in 00:${time.ceil().toString().padLeft(2, '0')}",
              //               style: MyTexts.bold16.copyWith(color: MyColors.green),
              //             );
              //           },
              //           onFinished: () {
              //             contr.onCountdownFinish();
              //           },
              //         );
              // }),
              const Gap(40),
              //Gap(MediaQuery.of(context).size.height / 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 🔹 Resend OTP Text
                  Obx(() {
                    return contr.isResendVisible.value
                        ? GestureDetector(
                            onTap: () async {
                              await contr.sendOtp();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                            seconds: 30,
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

                  /// 🔹 Checkbox + Text
                  Row(
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          side: const BorderSide(color: Color(0xFF2F80ED), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Sent OTP to whatsapp",
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              ValueListenableBuilder<bool>(
                valueListenable: isOtpComplete,
                builder: (context, isComplete, child) {
                  return RoundedButton(
                    buttonName: 'Continue',
                    color: isComplete ? MyColors.primary : MyColors.greyFour,
                    onTap: isComplete
                        ? () {
                            contr.otpController.text = _localOtpController.text;
                            contr.verifyOtp();
                          }
                        : null,
                  );
                },
              ),
              SizedBox(height: 2.h),

              // TextButton(
              //   onPressed: () {
              //     Get.offAllNamed(Routes.ON_BOARDING);
              //   },
              //   child: Text(
              //     "Back to login",
              //     style: TextStyle(
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w500,
              //       color: MyColors.lightBlueSecond,
              //       fontFamily: "SpaceGrotesk",
              //       decoration: TextDecoration.underline,
              //       decorationColor: MyColors
              //           .lightBlueSecond, // Optional: Color of the underline
              //       decorationThickness:
              //           2, // Optional: Thickness of the underline
              //       decorationStyle: TextDecorationStyle.solid,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
