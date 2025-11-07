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

  @override
  void initState() {
    super.initState();
    _localOtpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: const Text("OTP Verification"),
        isCenter: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
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
                    controller: _localOtpController,
                    onCompleted: (value) {
                      contr.otpController.text = value;
                      contr.verifyOtp();
                    },
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
                    "Check your text message for your OTP",
                    style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                  ),
                ),
              ),
              const Gap(20),
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
                              "Didn’t get the OTP? ",
                              style: MyTexts.regular16.copyWith(
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                            Text(
                              " Resend SMS",
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
                            style: MyTexts.bold16.copyWith(
                              color: MyColors.green,
                            ),
                          );
                        },
                        onFinished: () {
                          contr.onCountdownFinish();
                        },
                      );
              }),
              Gap(MediaQuery.of(context).size.height / 3),
            ],
          ),
        ),
      ),
    );
  }
}
