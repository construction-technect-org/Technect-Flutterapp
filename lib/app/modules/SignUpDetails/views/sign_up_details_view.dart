import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/SignUpDetails/controllers/sign_up_details_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpDetailsView extends GetView<SignUpDetailsController> {
  const SignUpDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.bricksBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(43)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 4.h),
                      // Stepper
                      const StepperWidget(currentStep: 1),
                      SizedBox(height: 2.h),
                      Text('SIGN UP', style: MyTexts.light22),
                      Text(
                        'Enter your Basic Details',
                        style: MyTexts.medium16.copyWith(color: MyColors.greyDetails),
                      ),
                      SizedBox(height: 2.h),
                      // First Name
                      Row(
                        children: [
                          Text(
                            'First Name',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(controller: controller.firstNameController),
                      SizedBox(height: 1.5.h),
                      // Last Name
                      Row(
                        children: [
                          Text(
                            'Last Name',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(controller: controller.lastNameController),
                      SizedBox(height: 1.5.h),
                      // Mobile Number
                      Row(
                        children: [
                          Text(
                            'Mobile Number',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: controller.mobileNumberController,
                        suffix: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              controller.verifyMobileNumber();
                            },
                            child: Container(
                              width: 90,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: MyColors.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  'Verify',
                                  style: MyTexts.medium16.copyWith(color: MyColors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),

                      // Email ID
                      Row(
                        children: [
                          Text(
                            'Email ID',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                      ),
                      SizedBox(height: 1.5.h),
                      // OTP Field
                      Row(
                        children: [
                          Text(
                            'Enter OTP',
                            style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                          ),
                          Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: controller.otpController,
                        onChanged: (value) {
                          controller.otp.value = value;
                        },
                        onCompleted: (value) {
                          controller.otp.value = value;
                        },
                        keyboardType: TextInputType.number,
                        textStyle: MyTexts.extraBold16.copyWith(color: MyColors.primary),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          borderWidth: 0.5,
                          fieldHeight: 57,
                          fieldWidth: 57,
                          activeFillColor: MyColors.white,
                          inactiveFillColor: MyColors.white,
                          selectedFillColor: MyColors.white,
                          activeColor: MyColors.primary,
                          inactiveColor: MyColors.textFieldBorder,
                          selectedColor: MyColors.primary,
                        ),
                        enableActiveFill: true,
                        animationType: AnimationType.fade,
                      ),
                      SizedBox(height: 2.h),
                      RoundedButton(
                        buttonName: 'PROCEED',
                        onTap: () {
                          controller.proceedToPassword();
                        },
                      ),
                      SizedBox(height: 4.sh),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
