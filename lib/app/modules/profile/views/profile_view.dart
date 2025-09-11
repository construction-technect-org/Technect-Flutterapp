import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/profile/components/certifications_component.dart';
import 'package:construction_technect/app/modules/profile/components/info_metrics_component.dart';
import 'package:construction_technect/app/modules/profile/components/marketplace_performance_component.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final HomeController controller1 = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // This removes the back button

        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    'Welcome ${controller1.profileData.value.data?.user?.firstName}!',
                    style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller1.navigateToEditAddress();
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Obx(
                        () => Text(
                          controller1.getCurrentAddress(),
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.textFieldBackground,
                          ),
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
                clipBehavior: Clip.none, // 👈 allows badge to overflow
                children: [
                  SvgPicture.asset(
                    Asset.notifications, // or 'assets/images/notifications.svg'
                    width: 28,
                    height: 28,
                  ),
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile',
                  style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Asset.editIcon,
                        width: 12,
                        height: 12,
                        color: MyColors.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "Edit Profile",
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildProfileBanner(),
            SizedBox(height: 1.h),

            Obx(() {
              final completionPercentage =
                  controller.profileCompletionPercentage;
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
                    strokeWidth: 8,
                    backgroundColor: MyColors.profileRemaining,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      MyColors.green,
                    ),
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
                    completionPercentage > 90
                        ? "Profile Verified"
                        : 'Profile Pending',
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
