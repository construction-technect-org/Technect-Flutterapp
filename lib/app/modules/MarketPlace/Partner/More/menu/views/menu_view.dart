import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FeatureDashBoard/Dashboard/views/explore_view.dart';
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
        title: const Text("More"),
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
              if (myPref.role.val == "partner") ...[
                Gap(1.h),
                CommonContainer(
                  icon: Asset.inbox,
                  title: "Inbox",
                  onTap: () {
                    Get.toNamed(Routes.APPROVAL_INBOX);
                  },
                ),
              ] else ...[
                Gap(1.h),
                CommonContainer(
                  icon: Asset.wishlist,
                  title: "WishList",
                  onTap: () {
                    Get.toNamed(Routes.WISH_LIST);
                  },
                ),
                const Gap(16),
                CommonContainer(
                  icon: Asset.cart,
                  title: "Connect",
                  onTap: () {
                    Get.toNamed(Routes.CART_LIST);
                  },
                ),
              ],
              const Gap(16),
              CommonContainer(
                icon: Asset.report,
                title: "Report",
                onTap: () {
                  Get.toNamed(Routes.REPORT, arguments: {"isReport": true});
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.analysis,
                title: "Analysis",
                onTap: () {
                  Get.toNamed(Routes.REPORT, arguments: {"isReport": false});
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.setting,
                title: "Setting",
                onTap: () {
                  Get.toNamed(Routes.SETTING);
                },
              ),
              if (myPref.role.val == "partner") ...[
                const Gap(16),
                CommonContainer(
                  icon: Asset.team,
                  title: "Team",
                  onTap: () {
                    Get.toNamed(Routes.ROLE_MANAGEMENT);
                  },
                ),
                const Gap(16),
                CommonContainer(
                  icon: Asset.inventory,
                  title: "Inventory",
                  onTap: () {
                    Get.toNamed(Routes.INVENTORY);
                  },
                ),
              ],

              const Gap(16),
              CommonContainer(
                icon: Asset.news,
                title: "News",
                onTap: () {
                  Get.toNamed(Routes.NEWS);
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.refer,
                title: "Refer & Earn",
                onTap: () {
                  Get.toNamed(Routes.REFER_EARN);
                },
              ),
              const Gap(16),
              CommonContainer(
                icon: Asset.info,
                title: "Explore Plan",
                onTap: () {
                  Get.to(() => const ExploreView());
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CommonContainer({
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
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: MyColors.grayEA.withValues(alpha: 0.32),
                    blurRadius: 4,
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage(Asset.moreBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                    height: 20,
                    width: 20,
                  ),
                ),
                const Gap(12),
                Text(
                  title,
                  style: MyTexts.medium15.copyWith(color: MyColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
