import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: const Text("Refer & Earn"), isCenter: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Text(
              "Share App With Coupon Code",
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      APIConstants.appUrl,
                      style: MyTexts.regular16.copyWith(
                        color: MyColors.warning,
                        fontFamily: MyTexts.Roboto,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(
                          text:
                              'Hello Friend 👋\n\nDownload the CONSTRUCTION TECHNECT App from the link below and use my referral code to get instant discounts & rewards on your purchases.\n\n${APIConstants.appUrl}\n\nReferral Code: ${Get.find<HomeController>().profileData.value.data?.referral?.myReferralCode ?? ""}\n\nShared by: ${(Get.find<HomeController>().profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(Get.find<HomeController>().profileData.value.data?.user?.lastName ?? "").capitalizeFirst}',
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: MyColors.primary,
                      child: Icon(Icons.share, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            Text(
              "How this works:",
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StepItem(
                    step: "1",
                    text: "Invite your friends, family and business",
                  ),
                  Gap(12),
                  _StepItem(
                    step: "2",
                    text: "They hit the road with subscriptions",
                  ),
                  Gap(12),
                  _StepItem(
                    step: "3",
                    text: "You get discount on subscriptions.",
                  ),
                ],
              ),
            ),
            const Gap(24),

            Text(
              "Statistics",
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColors.grayF2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      "Total Invites",
                      style: MyTexts.medium14.copyWith(
                        fontSize: 15.sp,
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(() {
                      return Text(
                        Get.find<HomeController>()
                                .profileData
                                .value
                                .data
                                ?.referral
                                ?.totalReferrals
                                .toString() ??
                            "0",
                        style: MyTexts.bold16.copyWith(color: Colors.white),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const Gap(24),
            Text(
              "Rewards",
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyColors.grayF2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Gap(12),
                  Expanded(
                    child: Text(
                      "Earned discount of 25% on your subscription",
                      style: MyTexts.regular16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
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

class _StepItem extends StatelessWidget {
  final String step;
  final String text;

  const _StepItem({required this.step, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: MyColors.primary,
          child: Text(
            step,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: MyTexts.regular14.copyWith(
              fontSize: 15.sp,
              color: MyColors.fontBlack,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }
}
