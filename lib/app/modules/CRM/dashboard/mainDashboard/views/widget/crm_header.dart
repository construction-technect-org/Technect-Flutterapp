import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';

class CrmHeader extends StatelessWidget {
  final commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Row(
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
                onTap: () => Get.toNamed(Routes.MANUFACTURER_ADDRESS),
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
                              TextSpan(text: commonController.getManufacturerAddress().value),
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
          onTap: () => _showCrmVrmSwitchSheet(context, commonController),
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Image.asset(Asset.explore, width: 18.w),
              Text('Switch', style: MyTexts.medium14.copyWith(color: MyColors.white)),
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
    );
  }

  void _showCrmVrmSwitchSheet(BuildContext context, CommonController commonController) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const Text(
              'Switch to VRM',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _switchTile(
              title: 'VRM',
              subtitle: 'Go to VRM dashboard',
              asset: Asset.contractor,
              onTap: () {
                Get.back();
                Get.offAllNamed(Routes.VRM_MAIN);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required String asset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.custom('EAEAEA')),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(asset, height: 40, width: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: MyTexts.bold16.copyWith(color: MyColors.fontBlack)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: MyTexts.regular12.copyWith(color: MyColors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
