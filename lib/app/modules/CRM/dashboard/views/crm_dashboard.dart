import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/controller/crm_dashboard_controller.dart';
class CRMDashboardScreen extends StatelessWidget {
  CRMDashboardScreen({super.key});

  final controller = Get.put<CRMDashboardController>(CRMDashboardController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              Padding(
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
                            return (controller.profileData.value.data?.user?.image ?? "").isEmpty
                                ? const Icon(
                                    Icons.account_circle_sharp,
                                    color: Colors.black,
                                    size: 48,
                                  )
                                : ClipOval(
                                    child: getImageView(
                                      finalUrl:
                                          "${APIConstants.bucketUrl}${controller.profileData.value.data?.user?.image ?? ""}",
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
                              Obx(
                                () => RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.custom('545454'),
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${(controller.profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(controller.profileData.value.data?.user?.lastName ?? "").capitalizeFirst}!',
                                        style: MyTexts.medium16.copyWith(
                                          color: MyColors.fontBlack,
                                          fontFamily: MyTexts.SpaceGrotesk,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
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
                                      colorFilter: ColorFilter.mode(MyColors.custom('545454'),BlendMode.srcIn)
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
                                              TextSpan(text: controller.getCurrentAddress().value),
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
                        // const Gap(10),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.put<SwitchAccountController>(SwitchAccountController());
                        //     showSwitchAccountBottomSheet();
                        //   },
                        //   child: Stack(
                        //     alignment: AlignmentGeometry.center,
                        //     children: [
                        //       Image.asset(Asset.explore, width: 18.w),
                        //       Text(
                        //         "Switch",
                        //         style: MyTexts.medium14.copyWith(color: MyColors.white),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.All_CHAT_LIST);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              border: Border.all(color: MyColors.custom('EAEAEA')),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(Asset.chat, width: 24, height: 24),
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
                            child: SvgPicture.asset(Asset.notification, width: 24, height: 24),
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
                            child: SvgPicture.asset(Asset.news, width: 24, height: 24),
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    Obx(() {
                      return CommonDashboard(
                        totalMerchant:
                            controller
                                .profileData
                                .value
                                .data
                                ?.statistics
                                ?.totalMerchantProfilesCreated
                                ?.toString() ??
                            "0",
                        totalConnector:
                            controller
                                .profileData
                                .value
                                .data
                                ?.statistics
                                ?.totalConnectorProfilesCreated
                                ?.toString() ??
                            "0",
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
