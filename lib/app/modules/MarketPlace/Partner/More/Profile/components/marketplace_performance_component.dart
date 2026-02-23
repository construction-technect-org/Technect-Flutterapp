

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MarketplacePerformanceComponent extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Text(
          'Trust & Safety',
          style: MyTexts.bold16.copyWith(
            color: MyColors.primary,
            fontFamily: MyTexts.SpaceGrotesk,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Identity Verified',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                Obx(() {
                  return CupertinoSwitch(
                    value:
                        controller
                            .merchantProfile
                            ?.verificationStatus
                            ?.identityVerified ??
                        false,
                    onChanged: (val) {},
                  );
                }),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Business License',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                Obx(() {
                  return CupertinoSwitch(
                    value:
                        controller
                            .merchantProfile
                            ?.verificationStatus
                            ?.businessLicense ??
                        false,
                    onChanged: (val) {},
                  );
                }),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Quality Assurance',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                Obx(() {
                  return CupertinoSwitch(
                    value:
                        controller
                            .merchantProfile
                            ?.verificationStatus
                            ?.qualityAssurance ??
                        false,
                    onChanged: (val) {
                      // controller
                      //     .merchantProfile
                      //     ?.verificationStatus
                      //     ?.qualityAssurance=!(controller
                      //     .merchantProfile
                      //     ?.verificationStatus
                      //     ?.qualityAssurance ??
                      //     true);
                      // log(  controller
                      //     .merchantProfile
                      //     ?.verificationStatus
                      //     ?.qualityAssurance);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
        SizedBox(height: 2.h),
        // Marketplace Performance Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text(
              'Marketplace Performance',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            SizedBox(height: 1.5.h),
            Obx(() {
              final completionPercentage =
                  controller.profileCompletionPercentage;
              final progressValue = completionPercentage / 100.0;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile Completeness',
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.textGrey,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                      ),
                      Text(
                        '$completionPercentage%',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.black,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    width: double.infinity,
                    height: 6,
                    decoration: BoxDecoration(
                      color: MyColors.progressRemaining,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progressValue,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.green,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 2.h),
            // Metrics Row
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => _buildPerformanceMetricItem(
                      'Trust Score',
                      controller.merchantProfile?.trustScore ?? 'No Score',
                      MyColors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Obx(
                    () => _buildPerformanceMetricItem(
                      'Marketplacee Tier',
                      controller.merchantProfile?.marketplaceTier ?? 'No Tier',
                      MyColors.warning,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Text(
                  'Member Since:',
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.grey,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                ),
                const Gap(5),
                Obx(() {
                  return Text(
                    controller.merchantProfile?.memberSince != null
                        ? DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(
                              controller.merchantProfile!.memberSince!,
                            ),
                          )
                        : 'Unknown',
                    style: MyTexts.bold14.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustSafetyItem(String iconPath, String title, bool verified) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: MyTexts.regular14.copyWith(
              color: MyColors.textGrey,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ),
        CupertinoSwitch(value: verified, onChanged: (val) {}),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: verified ? MyColors.primary : MyColors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(
            verified ? Icons.check : Icons.close,
            size: 10,
            color: MyColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetricItem(
    String label,
    String value,
    Color valueColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.greyE5, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: MyTexts.regular14.copyWith(
              color: MyColors.textGrey,
              fontSize: 14.sp,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: MyTexts.medium14.copyWith(
              color: valueColor,
              fontSize: 16.sp,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
