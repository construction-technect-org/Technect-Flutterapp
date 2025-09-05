// lib/app/modules/RoleDetails/views/role_details_view.dart
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/%20RoleDetails/controllers/%20role_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleDetailsView extends GetView<RoleDetailsController> {
  const RoleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADDRESS);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.hexGray92),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(Asset.notifications, width: 28, height: 28),
                  Positioned(
                    right: 0,
                    top: 3,
                    child: Container(
                      width: 6.19,
                      height: 6.19,
                      decoration: const BoxDecoration(
                        color: MyColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(22.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 8),
                        child: SvgPicture.asset(
                          Asset.searchIcon,
                          height: 16,
                          width: 16,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(
                        color: MyColors.darkGray,
                      ),
                      filled: true,
                      fillColor: MyColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          Asset.filterIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Role Details",
                          style: MyTexts.medium18.copyWith(
                            color: MyColors.fontBlack,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ROLE_DETAILS);
                          },
                          child: Container(
                            width: 27,
                            height: 26,
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),

                    /// Role Card
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(color: MyColors.americanSilver),
                        ),
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: MyColors
                                        .paleBluecolor, // background color
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Asset.Admin,
                                      width: 14.54, // scale as needed
                                      height: 13,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  controller.roleTitle.value,
                                  style: MyTexts.medium20.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 1.5.h),
                            Text(
                              "Role Description:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            ...controller.roleDescription
                                .map(
                                  (desc) => Text(
                                    "• $desc",
                                    style: MyTexts.regular14.copyWith(
                                      color: MyColors.gray32,
                                    ),
                                  ),
                                )
                                .toList(),
                            SizedBox(height: 2.h),
                            Text(
                              "Functionality:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Wrap(
                              spacing: 2.w,
                              children: controller.functionalities
                                  .map(
                                    (func) => OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: MyColors.green,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30.sp,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 1.2.h,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        func,
                                        style: MyTexts.regular16.copyWith(
                                          color: MyColors.green,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Role Status:",
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.green,
                                borderRadius: BorderRadius.circular(30.sp),
                              ),
                              child: Text(
                                controller.roleStatus.value,
                                style: MyTexts.regular16.copyWith(
                                  color: MyColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
