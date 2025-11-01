import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/commom_phone_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/settings/controller/setting_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Settings'),
                isCenter: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.grayEA.withValues(alpha: 0.32),
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MyColors.grayEA.withValues(alpha: 0.32),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Notifications",
                                style: MyTexts.medium15.copyWith(
                                  color: MyColors.gray2E,
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
                                      isNotification:
                                          controller.isNotification.value,
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                    const HeaderText(text: "Account"),
                    const Gap(16),
                    _buildSettingAction(
                      context,
                      icon: Icons.logout,
                      text: "Log Out",
                      color: MyColors.red,
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Are you sure you want to log out?",
                          confirmText: "Log Out",
                          onConfirm: () {
                            myPref.logout();
                            Get.offAllNamed(Routes.LOGIN);
                          },
                        );
                      },
                    ),
                    // Deactivate
                    _buildSettingAction(
                      context,
                      icon: Icons.pause_circle_filled,
                      text: "Deactivate my Account",
                      color: MyColors.red,
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Deactivate Account",
                          message:
                              "Are you sure to deactivate your account ? you can reactivate it anytime by  back in.",
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
                    ),

                    // Delete
                    _buildSettingAction(
                      context,
                      icon: Icons.delete_forever,
                      text: "Delete my Account",
                      color: MyColors.red,
                      onTap: () {
                        _showConfirmDialog(
                          context,
                          title: "Delete Account",
                          message:
                              "This action cannot be undone are you sure you want to delete your account permanently",
                          confirmText: "Delete",
                          onConfirm: () {
                            Get.back();
                            Get.to(
                              () => AccountActionScreen(actionType: "delete"),
                            );
                          },
                        );
                      },
                    ),
                    Visibility(
                      visible: false,
                      child: Column(
                        children: [
                          const Divider(),
                          const Gap(5),
                          const HeaderText(text: "Theme"),
                          const Gap(3),
                          Row(
                            children: [
                              Text(
                                "Dark Mode",
                                style: MyTexts.regular16.copyWith(
                                  color: Colors.black,
                                  fontFamily: MyTexts.SpaceGrotesk,
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
                                  fontFamily: MyTexts.SpaceGrotesk,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingAction(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 19),
          decoration: BoxDecoration(
            color: MyColors.white,
            boxShadow: [
              BoxShadow(
                color: MyColors.grayEA.withValues(alpha: 0.32),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: MyColors.grayEA.withValues(alpha: 0.32)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: MyTexts.medium15.copyWith(
                    color: MyColors.gray2E,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: MyColors.gray2E),
            ],
          ),
        ),
      ),
    );
  }
}

void _showConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  required String confirmText,
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF9D0CB)),
          color: const Color(0xFFFCECE9),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Text(
            title,
            style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: (message ?? "").isEmpty
          ? null
          : Text(
              message ?? "",
              style: MyTexts.medium14.copyWith(color: MyColors.gray54),
              textAlign: TextAlign.center,
            ),
      actions: [
        Row(
          children: [
            Expanded(
              child: RoundedButton(
                onTap: () {
                  Get.back();
                },
                buttonName: 'Cancel',
                borderRadius: 12,
                verticalPadding: 0,
                height: 45,
                color: MyColors.grayCD,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: RoundedButton(
                onTap: onConfirm,
                buttonName: confirmText,
                borderRadius: 12,
                verticalPadding: 0,
                height: 45,
                color: const Color(0xFFE53D26),
              ),
            ),
          ],
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
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.moreIBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      isDelete ? "Delete Account" : "Deactivate Account",
                    ),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(16),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              onTap: controller.isLoading.value
                  ? () {}
                  : () => controller.requestOtp(
                      isDeactivate: !isDelete,
                      actionType: actionType,
                    ),
              buttonName: isDelete
                  ? "Request OTP for Deletion"
                  : "Request OTP for Deactivation",
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessAction extends StatelessWidget {
  final String actionType;

  const SuccessAction({super.key, required this.actionType});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.LOGIN);
    });
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.loginBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffFCECE9),
              border: Border.all(color: const Color(0xffF9D0CB)),
            ),
            child: Text(
              "Your account is $actionType",
              style: MyTexts.bold18.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
