import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/components/certifications_component.dart';
import 'package:construction_technect/app/modules/profile/components/info_metrics_component.dart';
import 'package:construction_technect/app/modules/profile/components/marketplace_performance_component.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: MyColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profile', style: MyTexts.bold18.copyWith(color: MyColors.primary)),
            TextButton.icon(
              onPressed: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
              icon: SvgPicture.asset(
                Asset.editIcon,
                width: 12,
                height: 12,
                colorFilter: const ColorFilter.mode(
                  MyColors.primary,
                  BlendMode.srcIn,
                ), // 👈 optional: match text color
              ),
              label: Text(
                "Edit Profile",
                style: MyTexts.bold14.copyWith(
                  color: MyColors.primary,
                  decoration: TextDecoration.underline, // underline under text
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            _buildProfileBanner(),
            SizedBox(height: 1.h),

            Obx(() {
              final completionPercentage = controller.profileCompletionPercentage;
              if (completionPercentage > 90) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        const InfoMetricsComponent(),
                        const CertificationsComponent(isDelete: false),
                        SizedBox(height: 2.h),
                        const MarketplacePerformanceComponent(),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      _buildTabBar(),
                      SizedBox(height: 1.h),
                      Expanded(child: _buildTabContent()),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBanner() {
    return Obx(() {
      final completionPercentage = controller.profileCompletionPercentage;
      final progressValue = completionPercentage / 100.0;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Progress Circle
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 6,
                    backgroundColor: MyColors.profileRemaining,
                    valueColor: const AlwaysStoppedAnimation<Color>(MyColors.profileFill),
                  ),
                ),
                Text(
                  '$completionPercentage%',
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.white,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete your Profile',
                    style: MyTexts.medium18.copyWith(
                      color: MyColors.white,
                      fontSize: 17.sp,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    completionPercentage > 90 ? "Profile Verified" : 'Profile Pending',
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.white,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ],
              ),
            ),
            // Profile Emoji
            Image.asset(Asset.profileEmoji, width: 80, height: 80),
          ],
        ),
      );
    });
  }

  Widget _buildTabBar() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTabItem(0, 'Info & Metrics'),
            _buildTabItem(1, 'Certifications'),
            _buildTabItem(2, 'Marketplace Performance'),
          ],
        ),
      );
    });
  }

  Widget _buildTabItem(int index, String title) {
    final isSelected = controller.selectedTabIndex.value == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: isSelected ? MyColors.primary : const Color(0xFF737373),
                fontFamily: MyTexts.Roboto,
              ),
            ),
            SizedBox(height: 0.5.h),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? MyColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(
      () => SingleChildScrollView(
        child: switch (controller.selectedTabIndex.value) {
          0 => const InfoMetricsComponent(),
          1 => const CertificationsComponent(isDelete: true),
          2 => const MarketplacePerformanceComponent(),
          _ => const InfoMetricsComponent(),
        },
      ),
    );
  }
}
