import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/ReferAndCoupon/controller/refer_controller.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends GetView<ReferController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Refer & Earn'),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(16),
                        Text(
                          "Share App With Coupon Code",
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.gray2E,
                          ),
                        ),
                        const Gap(20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.grayEA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  APIConstants.appUrl,
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.grayA5,
                                    fontFamily: MyTexts.SpaceGrotesk,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(16),
                              GestureDetector(
                                onTap: () {
                                  SharePlus.instance.share(
                                    ShareParams(
                                      text:
                                          'Hello Friend 👋\n\nDownload the CONSTRUCTION TECHNECT App from the link below and use my referral code to get instant discounts & rewards on your purchases.\n\n${APIConstants.appUrl}\n\nReferral Code: ${Get.find<CommonController>().profileData.value.data?.referral?.myReferralCode ?? ""}\n\nShared by: ${(Get.find<CommonController>().profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(Get.find<CommonController>().profileData.value.data?.user?.lastName ?? "").capitalizeFirst}',
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(Asset.refer),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(24),
                        Text(
                          "How this works",
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.gray2E,
                          ),
                        ),
                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6EDFF),
                            border: Border.all(color: const Color(0xFFC2D3FF)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _StepItem(
                                step: "1",
                                text:
                                    "Invite your friends, family and business",
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
                          ),
                        ),
                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F5E6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColors.white,
                                  border: Border.all(
                                    color: const Color(0xFFC3E7C2),
                                  ),
                                ),
                                child: Obx(() {
                                  return Text(
                                    Get.find<CommonController>()
                                            .profileData
                                            .value
                                            .data
                                            ?.referral
                                            ?.totalReferrals
                                            .toString() ??
                                        "0",
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.gray2E,
                                    ),
                                  );
                                }),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Text(
                                  "Total Invites",
                                  style: MyTexts.medium14.copyWith(
                                    fontSize: 15.sp,
                                    color: MyColors.fontBlack,
                                    fontFamily: MyTexts.SpaceGrotesk,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Gap(24),
                        Text(
                          "Rewards",
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.grayEA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Earned discount of 25% on your subscription",
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.gray2E,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MyColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFC2D3FF)),
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
          ),
        ),
      ],
    );
  }
}
