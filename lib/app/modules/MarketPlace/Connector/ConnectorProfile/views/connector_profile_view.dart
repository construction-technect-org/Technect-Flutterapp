import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/connector_info_metrics_component.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';

class ConnectorProfileView extends GetView<ConnectorProfileController> {
  const ConnectorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
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
                  title: const Text('Profile summary view'),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: MyColors.grayF7,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Obx(() {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                  controller.selectedTabIndex.value = 0,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha:
                                        controller.selectedTabIndex.value == 0
                                            ? 1
                                            : 0,
                                      ),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 16,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Info & Metrics",
                                          style: MyTexts.medium15.copyWith(
                                            color: MyColors.gray2E,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 1.h),
                      const ConnectorInfoMetricsComponent(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(24.0),
      //   child: RoundedButton(buttonName: "PROCEED", onTap: () {}),
      // ),
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
                    fontFamily: MyTexts.SpaceGrotesk,
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
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    completionPercentage > 90
                        ? "Profile Verified"
                        : 'Profile Pending',
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.warning,
                      fontFamily: MyTexts.SpaceGrotesk,
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
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildTabItem(0, 'Info & Metrics')],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            SizedBox(height: 0.5.h),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


