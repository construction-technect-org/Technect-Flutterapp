import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/modules/BusinessHours/controller/business_hours_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessHoursView extends GetView<BusinessHoursController> {
  const BusinessHoursView({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF162A57);

    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: MyColors.oldLace,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.access_time,
                      color: MyColors.warning,
                      size: 46,
                    ),
                  ),
                  SizedBox(width: 2.h, height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BUSINESS HOURS",
                        style: MyTexts.light22.copyWith(
                          color: MyColors.textFieldBackground,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Update your Working Hours",
                        style: MyTexts.light16.copyWith(
                          color: MyColors.greyDetails,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Enable toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enable",
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      Text(
                        "Quickly Enable or Disable business hours",
                        style: MyTexts.bold12.copyWith(
                          color: MyColors.graniteGray,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Switch(
                      value: controller.isEnabled.value,
                      onChanged: (val) {
                        controller.isEnabled.value = val;
                      },
                      activeColor: MyColors.white,
                      activeTrackColor: navy,
                    ),
                  ),
                ],
              ),
              Divider(height: 2.h),

              // Timezone dropdown (static here)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Timezone",
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      Text(
                        "Set your timezone",
                        style: MyTexts.bold12.copyWith(
                          color: MyColors.graniteGray,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.textFieldBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(UTC-8:00) Pacific Time",
                          style: MyTexts.bold14.copyWith(
                            color: MyColors.fontBlack,
                          ),
                        ),
                        Image.asset(
                          Asset.updownIcon,
                          width: 14,
                          height: 14,
                          color: MyColors.fontBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              const Divider(height: 40),
              // Days List
              Obx(() {
                if (!controller.isEnabled.value) {
                  // hide completely
                  return const SizedBox.shrink();
                }
                return Column(
                  children: controller.daysEnabled.keys.map((day) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Obx(() {
                        final bool enabled = controller.daysEnabled[day]!.value;
                        return Row(
                          children: [
                            Switch(
                              value: enabled,
                              onChanged: (val) {
                                controller.daysEnabled[day]!.value = val;
                              },
                              activeColor: MyColors.white,
                              activeTrackColor: navy,
                            ),
                            Expanded(
                              child: Text(
                                day,
                                 style: MyTexts.bold16.copyWith(
                            color: MyColors.fontBlack,
                          ),
                              ),
                            ),
                            if (enabled) ...[
                              // Show From/To fields
                              SizedBox(
                                width: 95,
                                height: 37,
                                child: TextField(
                                  controller: controller.fromControllers[day],
                                  enabled:
                                      true, // set false if you want disabled
                                  decoration: InputDecoration(
                                    hintText: "From",
                                    helperStyle: MyTexts.bold14.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: MyColors
                                            .textFieldBorder, // default border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: MyColors
                                            .textFieldBorder, // default border color
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: MyColors
                                            .textFieldBorder, // default border color
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 95,
                                height: 37,
                                child: TextField(
                                  controller: controller.toControllers[day],
                                  decoration: InputDecoration(
                                    hintText: "To",
                                    helperStyle: MyTexts.bold14.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ] else ...[
                              // Show Closed
                              Container(
                                width: 198,
                                height: 37,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors
                                        .textFieldBorder, // default border color
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Asset.closeIcon,
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ), // spacing between icon & text
                                      Text(
                                        "Closed",
                                        style: MyTexts.bold14.copyWith(
                                          color: MyColors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      }),
                    );
                  }).toList(),
                );
              }),

              // Submit button
              SizedBox(height: 4.h),
              RoundedButton(
                buttonName: 'SUBMIT',
                onTap: () {
                  Get.toNamed(Routes.UPDATEYOURCERTIFICATION);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
