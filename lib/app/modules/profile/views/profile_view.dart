import 'package:construction_technect/app/core/utils/common_appbar.dart';
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
      appBar: CommonAppBar(
        isCenter: false,
        title: Text("Profile".toUpperCase()),
      ),

      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildProfileBanner(),
            SizedBox(height: 2.h),
            Obx(() {
              final completionPercentage =
                  controller.profileCompletionPercentage;
              if (completionPercentage > 90) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      _buildTabBar(),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _buildTabContent(),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          buttonName: controller.merchantProfile!=null? "SAVE":"PROCEED",
          onTap: () {
            for (var cert in controller.certificates) {
              if (cert.isDefault && (cert.filePath == null || cert.filePath!.isEmpty)) {
                SnackBars.errorSnackBar(content: "Please upload all relevant certificates");
                return;
              }
            }
            if ((controller.businessModel.value.businessEmail ?? "").isEmpty) {
              SnackBars.errorSnackBar(content: "Please fill business metrics");
            } else if (controller.businessHoursData.isEmpty) {
              SnackBars.errorSnackBar(content: "Please fill business hours");
            }
            else {
              controller.handleMerchantData();
              //27ABCDE1234F1Z5
            }
          },
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.primary, width: 1.2),
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
                    color: MyColors.black,
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
                    completionPercentage > 90
                        ? "Complete Profile"
                        : 'Complete your Profile',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.primary,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    completionPercentage > 90
                        ? "Profile Verified"
                        : 'Profile Pending',
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.warning,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabItem(0, 'Info & Metrics'),
            _buildTabItem(1, 'Certifications'),
            // _buildTabItem(2, 'Marketplace Performance'),
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
          // 2 => const MarketplacePerformanceComponent(),
          _ => const InfoMetricsComponent(),
        },
      ),
    );
  }
}
///27ABCDE1234F1Z5
