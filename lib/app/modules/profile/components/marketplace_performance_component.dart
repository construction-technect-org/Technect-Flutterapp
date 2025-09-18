import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class MarketplacePerformanceComponent extends StatelessWidget {
  const MarketplacePerformanceComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     color: MyColors.white,
        //     border: Border.all(color: const Color(0xFFD0D0D0)),
        //     borderRadius: BorderRadius.circular(12),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withValues(alpha: 0.1),
        //         blurRadius: 8,
        //         offset: const Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Trust & Safety',
        //         style: MyTexts.medium16.copyWith(
        //           color: MyColors.black,
        //           fontFamily: MyTexts.Roboto,
        //         ),
        //       ),
        //       SizedBox(height: 2.h),
        //       Obx(
        //         () => _buildTrustSafetyItem(
        //           Asset.identityIcon,
        //           'Identity Verified',
        //           controller.merchantProfile?.verificationStatus?.identityVerified ??
        //               false,
        //         ),
        //       ),
        //       SizedBox(height: 1.h),
        //       Obx(
        //         () => _buildTrustSafetyItem(
        //           Asset.businessLiIcon,
        //           'Business License',
        //           controller.merchantProfile?.verificationStatus?.businessLicense ??
        //               false,
        //         ),
        //       ),
        //       SizedBox(height: 1.h),
        //       Obx(
        //         () => _buildTrustSafetyItem(
        //           Asset.qualityIcon,
        //           'Quality Assurance',
        //           controller.merchantProfile?.verificationStatus?.qualityAssurance ??
        //               false,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 2.h),
        // Marketplace Performance Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text(
              'Marketplace Performance',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            SizedBox(height: 1.5.h),
            Obx(() {
              final completionPercentage = controller
                  .profileCompletionPercentage;
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
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      Text(
                        '$completionPercentage%',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.black,
                          fontFamily: MyTexts.Roboto,
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
                        () =>
                        _buildPerformanceMetricItem(
                          'Trust Score',
                          controller.merchantProfile?.trustScore ?? 'No Score',
                          MyColors.primary,
                        ),
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: Obx(
                        () =>
                        _buildPerformanceMetricItem(
                          'Marketplace Tier',
                          controller.merchantProfile?.marketplaceTier ??
                              'No Tier',
                          MyColors.warning,
                        ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Text('Member Since:', style: MyTexts.regular14.copyWith(
                    color: MyColors.grey, fontFamily: MyTexts.Roboto),),
                const Gap(5),
                Obx(() {
                  return Text( controller.merchantProfile?.memberSince != null
                      ? DateFormat('dd MM yyyy').format(
                    DateTime.parse(controller.merchantProfile!.memberSince!),
                  )
                      : 'Unknown',
                    style: MyTexts.bold14.copyWith(
                        color: MyColors.black, fontFamily: MyTexts.Roboto),);
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustSafetyItem(String iconPath, String title, bool verified) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.menuTile,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconPath, width: 14, height: 14),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              title,
              style: MyTexts.regular14.copyWith(
                color: MyColors.textGrey,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ),
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
      ),
    );
  }

  Widget _buildPerformanceMetricItem(String label, String value,
      Color valueColor) {
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
              fontFamily: MyTexts.Roboto,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: MyTexts.medium14.copyWith(
              color: valueColor,
              fontSize: 16.sp,
              fontFamily: MyTexts.Roboto,
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
      return '${date.day.toString().padLeft(2, '0')} ${months[date.month -
          1]} ${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
