import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';

class Dashboard extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: commonController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(55),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ACCOUNT);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Obx(() {
                        final isTeamLogin = myPref.getIsTeamLogin();

                        final profileImage = isTeamLogin
                            ? Get.find<CommonController>()
                                      .profileData
                                      .value
                                      .data
                                      ?.teamMember
                                      ?.profilePhoto ??
                                  ''
                            : commonController
                                      .profileData
                                      .value
                                      .data
                                      ?.user
                                      ?.image ??
                                  '';

                        if (profileImage.isEmpty) {
                          return const Icon(
                            Icons.account_circle_sharp,
                            color: Colors.black,
                            size: 48,
                          );
                        }

                        return ClipOval(
                          child: getImageView(
                            finalUrl: "${APIConstants.bucketUrl}$profileImage",
                            fit: BoxFit.cover,
                            height: 48,
                            width: 48,
                          ),
                        );
                      }),
                    ),

                    SizedBox(width: 1.h),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            final isTeamLogin = myPref.getIsTeamLogin();

                            final firstName = isTeamLogin
                                ? commonController
                                          .profileData
                                          .value
                                          .data
                                          ?.teamMember
                                          ?.firstName ??
                                      ''
                                : commonController
                                          .profileData
                                          .value
                                          .data
                                          ?.user
                                          ?.firstName ??
                                      '';

                            final lastName = isTeamLogin
                                ? commonController
                                          .profileData
                                          .value
                                          .data
                                          ?.teamMember
                                          ?.lastName ??
                                      ''
                                : commonController
                                          .profileData
                                          .value
                                          .data
                                          ?.user
                                          ?.lastName ??
                                      '';

                            return RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${firstName.capitalizeFirst} ${lastName.capitalizeFirst}!',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          GestureDetector(
                            onTap: myPref.getIsTeamLogin()
                                ? null
                                : () {
                                    if (myPref.role.val == "partner") {
                                      Get.toNamed(Routes.MANUFACTURER_ADDRESS);
                                    } else {
                                      Get.toNamed(Routes.DELIVERY_LOCATION);
                                    }
                                  },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Asset.location,
                                  width: 9,
                                  height: 12.22,
                                  color: MyColors.custom('545454'),
                                ),
                                SizedBox(width: 0.4.h),
                                Expanded(
                                  child: Obx(() {
                                    return RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        style: MyTexts.medium14.copyWith(
                                          color: MyColors.custom('545454'),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: commonController
                                                .getCurrentAddress()
                                                .value,
                                          ),
                                          const WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 4),
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    /* if (myPref.getIsTeamLogin() == false)
                      GestureDetector(
                        onTap: () {
                          Get.put<SwitchAccountController>(SwitchAccountController());
                          showSwitchAccountBottomSheet();
                          // Get.to(() => const ExploreView());
                        },
                        child: Stack(
                          alignment: AlignmentGeometry.center,
                          children: [
                            Image.asset(Asset.explore, width: 18.w),
                            Text(
                              "Switch",
                              style: MyTexts.medium14.copyWith(color: MyColors.white),
                            ),
                          ],
                        ),
                      ), */
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NOTIFICATIONS);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          border: Border.all(color: MyColors.custom('EAEAEA')),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          Asset.notification,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NEWS);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          border: Border.all(color: MyColors.custom('EAEAEA')),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          Asset.info,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            MyColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.NEWS);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          border: Border.all(color: MyColors.custom('EAEAEA')),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          Asset.chat,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            MyColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                CommonDashboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
