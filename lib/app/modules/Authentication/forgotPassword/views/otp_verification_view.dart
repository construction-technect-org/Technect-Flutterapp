import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
//import 'package:construction_technect/app/modules/Authentication/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpVerificationView extends StatefulWidget {
  final RxBool isLoading;
  final bool? isBackToLogin;
  final RxBool isResendVisible;
  final TextEditingController otpController;
  final Function(String)? onCompleted;
  final Function()? onTap;
  final Function? onFinished;
  final CountdownController countdownController;

  const OtpVerificationView({
    super.key,
    required this.isLoading,
    required this.isResendVisible,
    this.isBackToLogin = true,
    required this.otpController,
    required this.onCompleted,
    required this.onFinished,
    required this.onTap,
    required this.countdownController,
  });

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: widget.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(
          title: Text("OTP Verification"),
          isCenter: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Gap(32),
              Center(
                child: SizedBox(
                  width: 290,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    useHapticFeedback: true,
                    useExternalAutoFillGroup: true,
                    controller: widget.otpController,
                    onCompleted: widget.onCompleted,
                    keyboardType: TextInputType.number,
                    textStyle: MyTexts.extraBold16.copyWith(
                      color: MyColors.primary,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 0.5,
                      fieldHeight: 64,
                      fieldWidth: 64,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.grayE6,
                  border: Border.all(color: MyColors.grayC2),
                ),
                child: Center(
                  child: Text(
                    "Enter the OTP sent to your email and mobile number",
                    style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                  ),
                ),
              ),
              const Gap(20),
              Obx(() {
                return widget.isResendVisible.value
                    ? GestureDetector(
                        onTap: widget.onTap,
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
                        controller: widget.countdownController,
                        seconds: 30,
                        interval: const Duration(milliseconds: 100),
                        build: (_, double time) {
                          return Text(
                            "Resend in 00:${time.ceil().toString().padLeft(2, '0')}",
                            style: MyTexts.bold16.copyWith(
                              color: MyColors.green,
                            ),
                          );
                        },
                        onFinished: widget.onFinished,
                      );
              }),
              const Spacer(),
              if (widget.isBackToLogin == true)
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text(
                    "Back to login",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.lightBlueSecond,
                      fontFamily: "SpaceGrotesk",
                      decoration: TextDecoration.underline,
                      decorationColor: MyColors
                          .lightBlueSecond, // Optional: Color of the underline
                      decorationThickness:
                          2, // Optional: Thickness of the underline
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
              //Gap(MediaQuery.of(context).size.height / 3),

              /*  TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text(
                    'Back to login',
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.lightBlueSecond,
                      decoration: TextDecoration.underline,
                      decorationColor: MyColors.primary,
                    ),
                  ),
                ), */
            ],
          ),
        ),
      ),
    );
  }
}
