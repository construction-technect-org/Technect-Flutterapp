import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProfile/components/connector_info_metrics_component.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class ConnectorProfileView extends GetView<ConnectorProfileController> {
  ConnectorProfileView({super.key});

  final HomeController controller1 = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(isCenter: false, title: Text("Profile".toUpperCase())),

      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildProfileBanner(),
            SizedBox(height: 2.h),

            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 1.h),
                  _buildTabBar(),
                  SizedBox(height: 1.h),
                  const ConnectorInfoMetricsComponent(),
                ],
              ),
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
    return SizedBox(
      width: Get.width, // 👈 force full screen width
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 👈 center children
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
                fontFamily: MyTexts.Roboto,
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


