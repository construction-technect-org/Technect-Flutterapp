import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:construction_technect/app/modules/settings/controller/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

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
                          title: "Delete Account",
                          message:
                              "This action cannot be undone. Are you sure you want to delete your account permanently?",
                          confirmText: "Delete",
                          onConfirm: () {
                            // TODO: Implement delete account logic
                            Get.back(); // Close dialog
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          onPressed: onConfirm,
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
