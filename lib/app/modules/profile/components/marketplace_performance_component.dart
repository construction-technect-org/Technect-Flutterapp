import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';

class MarketplacePerformanceComponent extends StatelessWidget {
  const MarketplacePerformanceComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trust & Safety Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: const Color(0xFFD0D0D0)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trust & Safety',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.black,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              SizedBox(height: 2.h),
              _buildTrustSafetyItem(Asset.identityIcon, 'Identity Verified'),
              SizedBox(height: 1.h),
              _buildTrustSafetyItem(Asset.businessLiIcon, 'Business License'),
              SizedBox(height: 1.h),
              _buildTrustSafetyItem(Asset.qualityIcon, 'Quality Assurance'),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        // Marketplace Performance Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: const Color(0xFFD0D0D0)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marketplace Performance',
                style: MyTexts.medium14.copyWith(
                  color: MyColors.black,
                  fontFamily: MyTexts.Roboto,
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
                          style: MyTexts.regular14.copyWith(
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
                            color: MyColors.progressFill,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 1.5.h),
              // Metrics Row
              Row(
                children: [
                  Expanded(
                    child: _buildPerformanceMetricItem(
                      'Trust Score',
                      'Excellent',
                      MyColors.primary,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: _buildPerformanceMetricItem(
                      'Marketplace Tier',
                      'Premium',
                      MyColors.progressFill,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Obx(() {
                      final userData = controller.userData;
                      final memberSince = userData?.createdAt != null
                          ? _formatDate(userData!.createdAt!)
                          : 'Unknown';

                      return _buildPerformanceMetricItem(
                        'Member Since',
                        memberSince,
                        MyColors.black,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrustSafetyItem(String iconPath, String title) {
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
            decoration: const BoxDecoration(
              color: MyColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, size: 10, color: MyColors.white),
          ),
        ],
      ),
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
        color: MyColors.metricBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: MyTexts.regular14.copyWith(
              color: MyColors.textGrey,
              fontSize: 13.5.sp,
              fontFamily: MyTexts.Roboto,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: MyTexts.medium14.copyWith(
              color: valueColor,
              fontSize: 13.5.sp,
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
      return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
