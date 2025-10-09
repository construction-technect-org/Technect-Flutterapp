import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/bottom/controllers/bottom_controller.dart';
import 'package:gap/gap.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                  fontFamily: MyTexts.Roboto,
                                  color: MyColors.primary,
                                ),
                              ),
                              Text(
                                "Refer your business friends now!",
                                style: MyTexts.regular14.copyWith(
                                  fontFamily: MyTexts.Roboto,
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
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.peoples,
                    title: "Teams & Roles",
                    onTap: () {
                      Get.toNamed(Routes.ROLE_MANAGEMENT);
                    },
                  ),
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
                      Get.find<BottomController>().currentIndex.value = 2;
                    },
                  ),
                  const Gap(20),
                  CommonRowItem(
                    icon: Asset.youtube,

                    title: "Tutorials",
                    onTap: () {
                      openUrl(url: "https://www.youtube.com/watch?v=hcvmq-hcDIE");
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

  Widget _buildMenuItem(
    String title,
    bool hasNotification, {
    VoidCallback? onTap,
    bool? isDestructive,
    bool? highlight,
    IconData? icon, // 👈 Material icons
    Widget? customIcon, // 👈 Images/SVGs
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.menuTile,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            if (customIcon != null) ...[
              Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isDestructive == true ? MyColors.red : MyColors.fontBlack,
                      BlendMode.srcIn,
                    ),
                    child: customIcon,
                  ),
                  if (hasNotification)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ] else if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: isDestructive == true ? MyColors.red : MyColors.primary,
              ),
            ] else ...[
              Stack(
                children: [
                  SvgPicture.asset(
                    Asset.menuSettingIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDestructive == true ? MyColors.red : MyColors.fontBlack,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (hasNotification)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],

            SizedBox(width: 4.w),
            Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: isDestructive == true ? MyColors.red : MyColors.fontBlack,
                fontWeight: highlight == true ? FontWeight.w600 : FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CommonContainer extends StatelessWidget {
  final List<Widget> children;

  const CommonContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: Column(children: children),
    );
  }
}

class CommonRowItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CommonRowItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
              height: 20,
              width: 20,
            ),
          ),
          const Gap(20),
          Text(title, style: MyTexts.regular16.copyWith(color: MyColors.primary)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: MyColors.primary, size: 16),
        ],
      ),
    );
  }
}
