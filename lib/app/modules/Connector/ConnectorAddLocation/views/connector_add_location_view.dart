import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorAddLocation/controllers/connector_add_location_controller.dart';
import 'package:construction_technect/app/modules/Dashboard/controllers/dashboard_controller.dart';

class ConnectorAddLocationView extends GetView<ConnectorAddLocationController> {
  // final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.white,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(Asset.profil, height: 40, width: 40),
              SizedBox(width: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Welcome ${controller.profileData.value.data?.user?.firstName}!',
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.fontBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Obx(
                        () => Text(
                          controller.address.value,
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.textFieldBackground,
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
                ],
              ),
              const Spacer(),
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
                      Asset.notifications,
                      // or 'assets/images/notifications.svg'
                      width: 28,
                      height: 28,
                    ),
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
              SizedBox(width: 0.8.h),
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
                      Asset.warning, // or 'assets/images/notifications.svg'
                      width: 28,
                      height: 28,
                    ),
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
          ),
        ),
        backgroundColor: MyColors.white,
        body:  Container(),
         bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
          child: RoundedButton(
            buttonName: 'PROCEED',
            onTap: () {
              if (controller.selectedIndex.value == 0) {
                Get.toNamed(Routes.DASHABORD_MARKET_PLACE);
              }
              else{
                SnackBars.errorSnackBar(
                  content: 'Please select one feature',
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.greyE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, height: 20, width: 20),
              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: MyTexts.bold18.copyWith(color: MyColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _buildFeatureCard extends StatelessWidget {
  const _buildFeatureCard({
    super.key,
    required this.controller,
    required this.isSelected,
    required this.item,
    required this.itemWidth,
    required this.onTap,
  });

  final DashboardController controller;
  final bool isSelected;
  final Map<String, String> item;
  final double itemWidth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : MyColors.grayD4,
                ),
                color: isSelected ? MyColors.yellow : MyColors.greyE5,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    color: isSelected ? MyColors.primary : MyColors.grey,

                    item['icon']!,
                    height: itemWidth * 0.35, // responsive icon size
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item["title"]!,
                    textAlign: TextAlign.center,
                    style: MyTexts.medium13.copyWith(color: MyColors.fontBlack),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 20,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(5),
                  // shape: BoxShape.s,
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
