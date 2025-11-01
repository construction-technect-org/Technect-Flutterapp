import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/connector_info_metrics_component.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/connector_point_of_contact.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/connector_team_member.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:gap/gap.dart';

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
                                            controller.selectedTabIndex.value ==
                                                0
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
                                const Gap(10),
                                GestureDetector(
                                  onTap: () =>
                                      controller.selectedTabIndex.value = 1,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha:
                                            controller.selectedTabIndex.value ==
                                                1
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
                                          "Metrics",
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _buildTabContent(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(() {
      final index = controller.selectedTabIndex.value;
      Widget content;

      if (index == 0) {
        content = const ConnectorInfoMetricsComponent();
      } else {
        content = ConnectorMetrics();
      }

      return SingleChildScrollView(child: content);
    });
  }
}

class ConnectorMetrics extends StatelessWidget {
  ConnectorMetrics({super.key});

  final controller = Get.find<ConnectorProfileController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Row(
          children: [
            Text(
              'Point of contact',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => ConnectorPointOfContactScreen());
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
        ),
        _buildPointOfContactContent(),
        Gap(2.h),
        Row(
          children: [
            Text(
              'Members',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => ConnectorTeamMemberScreen());
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
        ),
        _buildTeamMemberContent(),
      ],
    );
  }

  Widget _buildPointOfContactContent() {
    return Obx(() {
      final pointOfContact = homeController
          .profileData
          .value
          .data
          ?.connectorProfile
          ?.pointOfContact;
      if (pointOfContact?.name?.isEmpty ?? true) {
        return GestureDetector(
          onTap: () {
            Get.to(() => ConnectorPointOfContactScreen());
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.grayEA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                " + Add Point of contact",
                style: MyTexts.bold16.copyWith(color: MyColors.grey),
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: MyColors.grayEA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(title: "Name", data: pointOfContact?.name ?? "-"),
              const Gap(6),
              buildRow(
                title: "Designation",
                data: pointOfContact?.relation ?? "-",
              ),
              const Gap(6),
              buildRow(
                title: "Phone number",
                data: pointOfContact?.phoneNumber ?? "-",
              ),
              const Gap(6),
              buildRow(
                title: "Alternative number",
                data: pointOfContact?.alternativePhoneNumber ?? "-",
              ),
              const Gap(6),
              buildRow(title: "Email id", data: pointOfContact?.email ?? "-"),
              const Gap(6),
            ],
          ),
        );
      }
    });
  }

  Widget buildRow({String? data, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            data ?? "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamMemberContent() {
    return Obx(() {
      final teamMembers =
          homeController.profileData.value.data?.connectorProfile?.teamMembers;
      if (teamMembers?.name?.isEmpty ?? true) {
        return GestureDetector(
          onTap: () {
            Get.to(() => ConnectorTeamMemberScreen());
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.grayEA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                " + Add Members",
                style: MyTexts.bold16.copyWith(color: MyColors.grey),
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: MyColors.grayEA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(title: "Name", data: teamMembers?.name ?? "-"),
              const Gap(6),
              buildRow(
                title: "Number of Members",
                data: teamMembers?.numberOfMembers?.toString() ?? "-",
              ),
              const Gap(6),
              buildRow(
                title: "Phone number",
                data: teamMembers?.phoneNumber ?? "-",
              ),
              const Gap(6),
            ],
          ),
        );
      }
    });
  }
}
