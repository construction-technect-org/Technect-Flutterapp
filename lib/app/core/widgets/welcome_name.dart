import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class WelcomeName extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Asset.profil, height: 40, width: 40),
        SizedBox(width: 1.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Welcome ${controller.profileData.value.data?.user?.firstName}!',
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.navigateToEditAddress();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                    SizedBox(width: 0.4.h),
                    Obx(
                      () => Expanded(
                        child: Text(
                          controller.getCurrentAddress(),
                          overflow: TextOverflow.ellipsis,
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.textFieldBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.hexGray92),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            clipBehavior: Clip.none, // 👈 allows badge to overflow
            children: [
              SvgPicture.asset(
                Asset.notifications, // or 'assets/images/notifications.svg'
                width: 28,
                height: 28,
              ),
              // 🔴 Red Dot Badge
              Positioned(
                right: 0,
                top: 3,
                child: Container(
                  width: 6.19,
                  height: 6.19,
                  decoration: const BoxDecoration(
                    color: MyColors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
