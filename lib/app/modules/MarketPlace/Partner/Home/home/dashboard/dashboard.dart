import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';

class Dashboard extends StatelessWidget {
  final CommonController commonController = Get.find<CommonController>();
  final DashBoardController _controller = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: _controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: MyColors.tertiary,
                padding: const EdgeInsets.only(top: 55, bottom: 24),
                child: Row(
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
                            : commonController.profileData.value.data?.user?.image ?? '';

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
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${_controller.userMainModel?.firstName?.capitalizeFirst ?? ''} ${_controller.userMainModel?.lastName?.capitalizeFirst ?? ''}',
                                  style: MyTexts.medium16.copyWith(
                                    color: MyColors.fontBlack,
                                    fontFamily: MyTexts.SpaceGrotesk,
                                  ),
                                ),
                              ],
                            ),
                          ),

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
                                          TextSpan(text: _controller.selectedAddress.value),
                                          const WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
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
                          colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
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
                          colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        //Get.toNamed(Routes.NEWS);
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
                          colorFilter: ColorFilter.mode(MyColors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
              CommonDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
