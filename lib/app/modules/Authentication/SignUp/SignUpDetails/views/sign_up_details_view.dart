import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/controllers/sign_up_details_controller.dart';

//import 'package:carousel_slider/carousel_slider.dart';

class SignUpDetailsView extends StatefulWidget {
  SignUpDetailsView({super.key});

  @override
  State<SignUpDetailsView> createState() => _SignUpDetailsViewState();
}

class _SignUpDetailsViewState extends State<SignUpDetailsView> {
  final SignUpDetailsController controller =
      Get.find<SignUpDetailsController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.emailController.text = "";
    controller.mobileNumberController.text = "";
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            CommonPhoneField(
              headerText: "Mobile Number",
              style: MyTexts.medium14.copyWith(
                color: MyColors.gra54,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
              isRed: true,
              controller: controller.mobileNumberController,
              focusNode: FocusNode(),
              isValid: controller.isValid,
              customErrorMessage: controller.numberError,
              onCountryCodeChanged: (code) {
                controller.countryCode.value = code;
              },
              onSubmitted: (val) {
                FocusScope.of(context).requestFocus(controller.emailFocusNode);
              },
            ),

            SizedBox(height: 1.8.h),
            Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final email = controller.emailController.text;
                  // Only validate availability if format is valid
                  final formatError = Validate.validateEmail(email);
                  if (formatError == null) {
                    controller.validateEmailAvailability(email);
                  } else {
                    // Format error - clear API error, validator will show format error
                    controller.emailError.value = "";
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    headerText: "Email Address",
                    hintText: "Enter your email address",
                    isRed: true,

                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(254),
                      EmailInputFormatter(),
                    ],
                    validator: (value) => Validate.validateEmail(value),
                    onChange: (value) {
                      controller.emailError.value = "";
                    },
                    onFieldSubmitted: (value) {
                      if (value != null) {
                        // Only validate availability if format is valid
                        final formatError = Validate.validateEmail(value);
                        if (formatError == null) {
                          controller.validateEmailAvailability(value);
                        } else {
                          // Format error - clear API error, validator will show format error
                          controller.emailError.value = "";
                        }
                      }
                    },
                  ),
                  Obx(() {
                    if (controller.emailError.value.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          controller.emailError.value,
                          style: MyTexts.medium13.copyWith(
                            color: MyColors.red33,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),

            SizedBox(height: 1.8.h),
            RoundedButton(
              buttonName: 'Continue',
              onTap: () async {
                await controller.validateEmailAvailability(
                  controller.emailController.text,
                );

                if (controller.emailError.value.isNotEmpty) {
                  SnackBars.errorSnackBar(content: controller.emailError.value);
                  return;
                }
                controller.isValid.value = -1;
                controller.numberError.value = "";

                final mobileNumber = controller.mobileNumberController.text
                    .trim();
                final mobileError = await Validate.validateMobileNumberAsync(
                  mobileNumber,
                  countryCode: controller.countryCode.value,
                );
                if (!formKey.currentState!.validate()) {
                  if (mobileError != null && mobileError.isNotEmpty) {
                    controller.numberError.value = mobileError;
                    controller.isValid.value = 1;
                    return;
                  }
                }

                hideKeyboard();
                if (formKey.currentState!.validate()) {
                  controller.resetOtpState();
                  final sent = await controller.verifyMobileNumber();
                  if (!sent) return;

                  if (Get.isBottomSheetOpen == true) {
                    Get.back();
                  }

                  // Use named route to avoid duplicates
                  controller.resetOtpState();
                  Get.toNamed(Routes.OTP_Verification);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
