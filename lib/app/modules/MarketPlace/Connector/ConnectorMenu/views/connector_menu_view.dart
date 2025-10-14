import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorBottom/controllers/connector_main_tab_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/controllers/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/menu/views/menu_view.dart';
import 'package:gap/gap.dart';

class ConnectorMenuView extends StatelessWidget {
  const ConnectorMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        isCenter: false,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text("MENU"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFFFED29).withValues(alpha: 0.5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(Asset.gift),
                          const Gap(13),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Get Couples for Every Referral",
                                style: MyTexts.medium16.copyWith(
                                  fontFamily: MyTexts.SpaceGrotesk,
                                  color: MyColors.primary,
                                ),
                              ),
                              Text(
                                "Refer your business friends now!",
                                style: MyTexts.regular14.copyWith(
                                  fontFamily: MyTexts.SpaceGrotesk,
                                  color: MyColors.gray5D,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              HearderText(text: "Profile"),
              Gap(1.h),
              CommonContainer(
                children: [
                  CommonRowItem(
                    icon: Asset.profile,
                    title: "Profile Details",
                    onTap: () {
                      if ((Get.find<ConnectorHomeController>()
                                      .profileData
                                      .value
                                      .data
                                      ?.user
                                      ?.roleName ??
                                  "")
                              .toLowerCase() ==
                          "House-Owner".toLowerCase()) {
                        Get.toNamed(Routes.CONNECTOR_PROFILE);
                      } else {
                        Get.toNamed(Routes.PROFILE);
                      }
                    },
                  ),
                  // const Gap(20),
                  // CommonRowItem(
                  //   icon: Asset.peoples,
                  //   title: "Teams & Roles",
                  //   onTap: () {
                  //     Get.toNamed(Routes.ROLE_MANAGEMENT);
                  //   },
                  // ),
                ],
              ),
              SizedBox(height: 2.h),
              HearderText(text: "Support"),
              Gap(1.h),
              CommonContainer(
                children: [
                  CommonRowItem(
                    icon: Asset.suportTicket,
                    title: "Help & Support",
                    onTap: () {
                      Get.find<ConnectorBottomController>().currentIndex.value =
                          2;
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.youtube,

                    title: "Tutorials",
                    onTap: () {
                      openUrl(
                        url: "https://www.youtube.com/watch?v=hcvmq-hcDIE",
                      );
                    },
                  ),
                  const Gap(20),

                  CommonRowItem(
                    icon: Asset.faq,

                    title: "F.A.Q.S",
                    onTap: () {
                      Get.toNamed(Routes.FAQ);
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.feed,

                    title: "Feedback",
                    onTap: () {
                      Get.toNamed(Routes.FEEDBACK_VIEW);
                    },
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    HearderText(text: "Others"),
                    Gap(1.h),
                    CommonContainer(
                      children: [
                        CommonRowItem(
                          icon: Asset.sub,
                          title: "Explore Subscription Plans",
                          onTap: () {},
                        ),
                        const Gap(20),
                        CommonRowItem(
                          icon: Asset.gift,

                          title: "Refer & Get Coupons",
                          onTap: () {
                            Get.toNamed(Routes.REFER_EARN);
                          },
                        ),
                        const Gap(20),

                        CommonRowItem(
                          icon: Asset.link,

                          title: "Use on Desktop",
                          onTap: () {
                            openUrl(url: "https://www.google.com");
                          },
                        ),
                        const Gap(20),
                        CommonRowItem(
                          icon: Asset.notifications,

                          title: "Whats NEWS",
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),

              HearderText(text: "About"),
              Gap(1.h),
              CommonContainer(
                children: [
                  CommonRowItem(
                    icon: Asset.info,
                    title: "About Us",
                    onTap: () {
                      openUrl(url: Constants.aboutUS);
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.policy,
                    title: "Privacy Policy",
                    onTap: () {
                      openUrl(url: Constants.privacyPolicy);
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.tc,
                    title: "Terms & Conditions",
                    onTap: () {
                      openUrl(url: Constants.termsCondition);
                    },
                  ),
                ],
              ),
              const Gap(20),

              // _buildMenuItem(
              //   'Service Management',
              //   false,
              //   onTap: () {
              //     Get.toNamed(Routes.SERVICE_MANAGEMENT);
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Product Management',
              //   customIcon: SvgPicture.asset(
              //     Asset.productManagement,
              //     height: 24,
              //     width: 24,
              //   ),
              //
              //   false,
              //   onTap: () {
              //     Get.to(() => ProductManagementView());
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Approval Inbox',
              //   true,
              //   customIcon: Image.asset(
              //     Asset.vectorIcon,
              //     height: 24,
              //     width: 24,
              //   ),
              //
              //   onTap: () {
              //     Get.to(() => const ProductApprovalView());
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Connection Inbox',
              //   true,
              //   customIcon: Image.asset(Asset.crmIcon, height: 24, width: 24),
              //   onTap: () {
              //     Get.toNamed(Routes.CONNECTION_INBOX);
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Role Management',
              //   customIcon: SvgPicture.asset(Asset.role, height: 24, width: 24),
              //
              //   false,
              //   onTap: () {
              //     Get.toNamed(Routes.ROLE_MANAGEMENT);
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Support Ticket',
              //   true,
              //   customIcon: SvgPicture.asset(Asset.suportTicket),
              //   onTap: () {
              //     Get.to(() => CustomerSupportView());
              //   },
              // ),
              // SizedBox(height: 1.h),
              // _buildMenuItem(
              //   'Settings',
              //   false,
              //   customIcon: SvgPicture.asset(Asset.settingsIcon),
              //
              //   onTap: () {
              //     Get.to(() => const SettingView());
              //   },
              //
              //   // onTap: () {
              //   //   Get.toNamed(Routes.PROFILE);
              //   // },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
