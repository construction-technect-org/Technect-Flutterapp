import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';

class CrmHeader extends StatelessWidget {
  final bool inScreen;
  const CrmHeader({super.key, required this.inScreen});

  @override
  Widget build(BuildContext context) {
    final commonController = Get.find<CommonController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.ACCOUNT),
            behavior: HitTestBehavior.translucent,
            child: Obx(() {
              return (commonController.profileData.value.data?.user?.image ?? "").isEmpty
                  ? const Icon(Icons.account_circle_sharp, color: Colors.black, size: 48)
                  : ClipOval(
                      child: getImageView(
                        finalUrl:
                            "${APIConstants.bucketUrl}${commonController.profileData.value.data?.user?.image ?? ""}",
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
                      style: MyTexts.medium14.copyWith(color: MyColors.custom('545454')),
                      children: [
                        TextSpan(
                          text:
                              '${(commonController.profileData.value.data?.user?.firstName ?? "").capitalizeFirst} ${(commonController.profileData.value.data?.user?.lastName ?? "").capitalizeFirst}!',
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
                        color: MyColors.custom('545454'),
                      ),
                      SizedBox(width: 0.4.h),
                      Expanded(
                        child: Obx(() {
                          return RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              style: MyTexts.medium14.copyWith(color: MyColors.custom('545454')),
                              children: [
                                TextSpan(text: commonController.getCurrentAddress().value),
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
            onTap: () => commonController.toggleIsCrm(inScreen),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Image.asset(Asset.explore, width: 18.w),
                Text(
                  commonController.isCrm.value ? "VRM" : "CRM",
                  style: MyTexts.medium14.copyWith(color: MyColors.white),
                ),
              ],
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
        ],
      ),
    );
  }
}
