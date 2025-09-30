import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:construction_technect/app/modules/settings/controller/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final controller = Get.put<SettingController>(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(title: const Text('Settings'), isCenter: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MyColors.grayD4),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Notifications",
                        style: MyTexts.regular16.copyWith(
                          color: Colors.black,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      const Spacer(),
                      Obx(() {
                        return CupertinoSwitch(
                          activeTrackColor: MyColors.primary,
                          value: controller.isNotification.value,
                          onChanged: (val) {
                            controller.isNotification.value = val;
                            controller.notificationToggle(
                              isNotification: controller.isNotification.value,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                  const Gap(5),
                  Visibility(
                    visible: false,
                    child: Column(
                      children: [
                        const Divider(),
                        const Gap(5),
                        HeaderText(text: "Theme"),
                        const Gap(3),
                        Row(
                          children: [
                            Text(
                              "Dark Mode",
                              style: MyTexts.regular16.copyWith(
                                color: Colors.black,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            const Spacer(),
                            Obx(() {
                              return CupertinoSwitch(
                                activeTrackColor: MyColors.primary,
                                value: controller.isDarkMode.value,
                                onChanged: (val) {
                                  controller.isDarkMode.value = val;
                                  controller.isLightMode.value =
                                      !controller.isLightMode.value;
                                },
                              );
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Light Mode",
                              style: MyTexts.regular16.copyWith(
                                color: Colors.black,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                            const Spacer(),
                            Obx(() {
                              return CupertinoSwitch(
                                activeTrackColor: MyColors.primary,
                                value: controller.isLightMode.value,
                                onChanged: (val) {
                                  controller.isLightMode.value = val;
                                  controller.isDarkMode.value =
                                      !controller.isDarkMode.value;
                                },
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(5),
                  const Divider(),
                  const Gap(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Log Out",
                          message: "Are you sure you want to log out?",
                          confirmText: "Log Out",
                          onConfirm: () {
                            myPref.logout();
                            Get.offAllNamed(Routes.LOGIN);
                          },
                        );
                      },
                      child: Text(
                        "Log Account",
                        style: MyTexts.medium16.copyWith(color: MyColors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Deactivate Account",
                          message:
                              "Are you sure you want to deactivate your account? You can reactivate it anytime by logging back in.",
                          confirmText: "Deactivate",
                          onConfirm: () {
                            Get.back();

                            Get.to(
                              () =>
                                  AccountActionScreen(actionType: "deactivate"),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Deactivate my Account",
                        style: MyTexts.medium16.copyWith(color: MyColors.red),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Delete Account",
                          message:
                              "This action cannot be undone. Are you sure you want to delete your account permanently?",
                          confirmText: "Delete",
                          onConfirm: () {
                            Get.back();
                            Get.to(
                              () => AccountActionScreen(actionType: "delete"),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Delete my Account",
                        style: MyTexts.medium16.copyWith(color: MyColors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Confirmation Dialog
void _showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmText,
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: MyTexts.regular16.copyWith(color: Colors.black87, height: 1.4),
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: () => Get.back(),
          child: const Text("Cancel", style: TextStyle(color: Colors.black87)),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.logout, size: 18, color: Colors.white),
          label: Text(confirmText, style: const TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: onConfirm,
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

class AccountActionScreen extends StatelessWidget {
  final String actionType;

  AccountActionScreen({super.key, required this.actionType});

  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    final isDelete = actionType == "delete";

    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          appBar: CommonAppBar(
            title: Text(isDelete ? "Delete Account" : "Deactivate Account"),
            isCenter: false,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonPhoneField(
                    headerText: "Mobile Number",
                    controller: controller.mobileController,
                    focusNode: FocusNode(),
                    isValid: controller.isValid,
                    onCountryCodeChanged: (code) =>
                        controller.countryCode.value = code,
                  ),
                  const SizedBox(height: 16),
                  CommonTextField(
                    headerText: "Password",
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    hintText: "Enter your password",
                    suffixIcon: GestureDetector(
                      onTap: () => controller.isPasswordVisible.value =
                          !controller.isPasswordVisible.value,
                      child: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (controller.isOtpStep.value) ...[
                    Text(
                      "Enter the verification code sent to your mobile/email",
                      style: MyTexts.regular16.copyWith(
                        color: MyColors.primary,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: controller.otpController,
                      onChanged: (value) =>
                          controller.otpController.text = value,
                      onCompleted: (value) =>
                          controller.otpController.text = value,
                      keyboardType: TextInputType.number,
                      textStyle: MyTexts.extraBold16.copyWith(
                        color: MyColors.primary,
                      ),
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
                    const SizedBox(height: 20),

                    /// Step 2 button
                    RoundedButton(
                      onTap: controller.isLoading.value
                          ? () {}
                          : () => controller.confirmAction(
                              actionType: actionType,
                              isDeactivate: !isDelete,
                            ),
                      buttonName: isDelete
                          ? "Confirm Delete"
                          : "Confirm Deactivate",
                    ),
                    const SizedBox(height: 20),
                  ],

                  /// Info text
                  Row(
                    children: [
                      const Icon(Icons.info, color: MyColors.red),
                      const Gap(12),
                      Expanded(
                        child: Text(
                          isDelete
                              ? "Deleting your account will remove all stored data and connections permanently."
                              : "Deactivating will disable your account temporarily. You can log back in to reactivate.",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (!controller.isOtpStep.value)
                    RoundedButton(
                      onTap: controller.isLoading.value
                          ? () {}
                          : () =>
                                controller.requestOtp(isDeactivate: !isDelete),
                      buttonName: isDelete
                          ? "Request OTP for Deletion"
                          : "Request OTP for Deactivation",
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
