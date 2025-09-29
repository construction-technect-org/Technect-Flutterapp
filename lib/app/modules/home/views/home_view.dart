import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/home/components/coming_soon_dialog.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/main/controllers/main_controller.dart';
import 'package:construction_technect/app/modules/settings/views/setting_view.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        // appBar: CommonAppBar(
        //   leadingWidth: 190,
        //   leading: Container(
        //     padding: const EdgeInsets.all(7),
        //     height: 49,
        //     margin: const EdgeInsets.only(left: 13, top: 10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: MyColors.yellow,
        //       border: Border.all(color: MyColors.black),
        //     ),
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.offAllNamed(Routes.CONNECTOR_MAIN_TAB);
        //       },
        //       child: Row(
        //         children: [
        //           SvgPicture.asset(Asset.connectorSvg, width: 24, height: 24),
        //           const Gap(8),
        //           Text(
        //             "Join As Connector",
        //             style: MyTexts.regular14.copyWith(
        //               color: Colors.black,
        //               fontFamily: MyTexts.Roboto,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Obx(() {
                    return (controller.profileData.value.data?.user?.image ??
                                "")
                            .isEmpty
                        ? Image.asset(Asset.profil, height: 40, width: 40)
                        : ClipOval(
                            child: getImageView(
                              finalUrl:
                                  "${APIConstants.bucketUrl}${controller.profileData.value.data?.user?.image ?? ""}",
                              fit: BoxFit.cover,
                            ),
                          );
                  }),
                  SizedBox(width: 1.h),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            'Welcome ${controller.profileData.value.data?.user?.firstName}!',
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.getCurrentAddress().isNotEmpty) {
                              Get.toNamed(Routes.CONNECTOR_SELECT_LOCATION);
                            } else {
                              Get.snackbar(
                                "No Address",
                                "Please add an address first",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Asset.location,
                                width: 9,
                                height: 12.22,
                              ),
                              SizedBox(width: 0.4.h),
                              Obx(
                                () => Expanded(
                                  child: Text(
                                    controller.getCurrentAddress(),
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.textFieldBackground,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                  ),

                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATIONS);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.grayD4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            Asset.notifications,
                            width: 18,
                            height: 18,
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
                  ),
                  SizedBox(width: 0.8.h),
                  GestureDetector(
                    onTap: () {
                      ComingSoonDialog.showComingSoonDialog(
                        featureName: 'Alert',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.grayD4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            Asset.warning,
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 1.h),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText(text: "Statics"),
                          const Gap(14),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: StaticsCard(
                                    title: "Total Partners",
                                    value:
                                        (controller
                                                    .dashboardData
                                                    .value
                                                    .data
                                                    ?.totalPartnerProfiles ??
                                                0)
                                            .toString(),
                                    icon: Asset.noOfPartner,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: StaticsCard(
                                    title: "Total Products",
                                    value:
                                        (controller
                                                    .dashboardData
                                                    .value
                                                    .data
                                                    ?.totalProducts ??
                                                0)
                                            .toString(),

                                    icon: Asset.noOfConectors,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: StaticsCard(
                                    title: "Total Connectors",
                                    value:
                                        (controller
                                                    .dashboardData
                                                    .value
                                                    .data
                                                    ?.totalConnectorProfiles ??
                                                0)
                                            .toString(),

                                    icon: Asset.noOfUsers,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(14),
                          HeaderText(text: "Notification"),
                          const Gap(14),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: _buildNotiCard(
                                    onTap: () {
                                      Get.find<MainController>()
                                              .currentIndex
                                              .value =
                                          2;
                                    },
                                    title: "Support Ticket",
                                    value:
                                        (controller
                                                    .dashboardData
                                                    .value
                                                    .data
                                                    ?.merchantSupportTickets ??
                                                0)
                                            .toString(),

                                    icon: Asset.warning,
                                    color: MyColors.redgray,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildNotiCard(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.APPROVAL_INBOX,
                                        arguments: {"isInbox": true},
                                      );
                                    },
                                    title: "Inbox",
                                    value:
                                        (controller
                                                    .dashboardData
                                                    .value
                                                    .data
                                                    ?.merchantProductNotifications ??
                                                0)
                                            .toString(),

                                    icon: Asset.thumbup,
                                    color: MyColors.warning,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(14),
                          HeaderText(text: "Quick Access"),
                          const Gap(14),
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 18,
                              right: 18,
                              left: 18,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: MyColors.gray5D,
                                width: 0.5,
                              ),
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.items.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1.4,
                                  ),
                              itemBuilder: (context, index) {
                                final item = controller.items[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      Get.toNamed(
                                        Routes.APPROVAL_INBOX,
                                        arguments: {"isInbox": true},
                                      );
                                    } else if (index == 1) {
                                      ComingSoonDialog.showComingSoonDialog(
                                        featureName: 'Report',
                                      );
                                      // Get.toNamed(Routes.REPORT);
                                    } else if (index == 2) {
                                      //Get.toNamed(Routes.REPORT);
                                      ComingSoonDialog.showComingSoonDialog(
                                        featureName: 'Analysis',
                                      );
                                    } else if (index == 3) {
                                      Get.to(() => SettingView());
                                    } else if (index == 4) {
                                      Get.toNamed(
                                        Routes.ROLE_MANAGEMENT,
                                        arguments: {"isHome": true},
                                      );
                                    } else if (index == 5) {
                                      Get.toNamed(Routes.INVENTORY);
                                    } else if (index == 6) {
                                      Get.toNamed(Routes.NEWS);
                                    } else if (index == 7) {
                                      ComingSoonDialog.showComingSoonDialog(
                                        featureName: 'Refer & Earn',
                                      );
                                      // Get.toNamed(Routes.REFER_EARN);
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        item['icon'],
                                        height: 28,
                                        width: 28,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item['title'],
                                        textAlign: TextAlign.center,
                                        style: MyTexts.regular14.copyWith(
                                          color: MyColors.textFieldBackground,
                                          fontFamily: MyTexts.Roboto,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(14),
                          Row(
                            children: [
                              HeaderText(text: "Active Team"),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.ROLE_MANAGEMENT,
                                    arguments: {"isHome": true},
                                  );
                                },
                                child: Text(
                                  "View All",
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.gray5D,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: Obx(() {
                        final teamMembers = controller.teamList
                            .take(5)
                            .toList();

                        if (teamMembers.isEmpty) {
                          return Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    size: 32,
                                    color: MyColors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No team members',
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Add team members to get started',
                                    style: MyTexts.regular12.copyWith(
                                      color: MyColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: teamMembers.length,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:  (controller.teamList[index].profilePhotoUrl ?? "")
                                        .isEmpty
                                        ? Image.asset(
                                      Asset.aTeam,
                                      height: 67,
                                      width: 67,
                                    )
                                        : getImageView(
                                      finalUrl:
                                      controller.teamList[index].profilePhotoUrl ?? "",
                                      height: 67,
                                      width: 67,
                                    ),
                                  ),
                                  const Gap(12),
                                  Text(
                                    "${controller.teamList[index].firstName} ${controller.teamList[index].lastName}",
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    const Gap(14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Widget icon, // 👈 change to Widget
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Container(
        width: 180,
        height: 89,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayD4),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 0.6.h),
                Text(
                  title,
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.textFieldBackground,

                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.8.h),
            Text(
              value,
              style: MyTexts.extraBold18.copyWith(
                color: MyColors.textFieldBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotiCard({
    String? title,
    String? value,
    Function()? onTap,
    String? icon,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.greyE5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 4, top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: (color ?? Colors.black).withValues(alpha: 0.3),
                  ),
                  child: SvgPicture.asset(
                    icon ?? "",
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Gap(12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.gray5D,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  Text(
                    value ?? "",
                    style: MyTexts.bold20.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaticsCard extends StatelessWidget {
  String? icon;
  String? title;
  String? value;
  Color? color;
  Color? bColor;

  StaticsCard({
    super.key,
    this.icon,
    this.title,
    this.value,
    this.color,
    this.bColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        border: Border.all(color: bColor ?? MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SvgPicture.asset(
            icon ?? "",
            height: 20,
            width: 20,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
          ),
          const Gap(6),
          Text(
            title ?? "",
            overflow: TextOverflow.ellipsis,
            style: MyTexts.regular14.copyWith(
              color: MyColors.fontBlack,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          Text(
            value ?? "",
            style: MyTexts.bold16.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  String text;

  HeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyTexts.medium18.copyWith(
        color: MyColors.black,
        fontFamily: MyTexts.Roboto,
      ),
    );
  }
}

final List<int> barCounts = [0, 2, 4, 0, 3, 4, 3, 5, 0, 4, 3, 5];

List<String> _monthNames = [
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
  "Feb",
  "Mar",
];
