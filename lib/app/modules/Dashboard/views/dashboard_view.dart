import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Dashboard/controllers/dashboard_controller.dart';
import 'package:gap/gap.dart';

class DashboardView extends GetView<DashboardController> {
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
                    Row(
                      children: [
                        SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                        SizedBox(width: 0.4.h),
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.address.value,
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.textFieldBackground,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
              ),
              Gap(10),
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
                      width: 20,
                      height: 20,
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
                      width: 20,
                      height: 20,
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(22.5),
                    border: Border.all(color: MyColors.grayD4),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 8),
                        child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                      filled: true,
                      fillColor: MyColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Features",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.black),
                ),
              ),
              SizedBox(height: 1.h),

              /// ✅ FIXED GridView
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.greyE5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically calculate item width
                    final double itemWidth =
                        (constraints.maxWidth - (3 * 10)) / 3; // 4 per row with spacing
                    final double itemHeight = itemWidth + 10; // for icon + text

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.features.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.features[index];

                        return Obx(() {
                          final isSelected = controller.selectedIndex.value == index;
                          return _buildFeatureCard(
                            controller: controller,
                            isSelected: isSelected,
                            item: item,
                            itemWidth: itemWidth,
                            onTap: () {
                              // if(isSelected){
                              if (index == 0) {
                                controller.selectedIndex.value = index;
                              } else {
                                SnackBars.successSnackBar(
                                  content: 'This feature will come soon',
                                );
                              }
                              // }
                              // else{
                              //
                              // }
                            },
                          );
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Statistics",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.black),
                ),
              ),
              SizedBox(height: 1.h),
              // ✅ Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _buildStatCard("Partners", "250", Asset.noOfUsers)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard("Connectors", "180", Asset.noOfConectors),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              // ✅ World Map
              Expanded(
                child: Center(child: Image.asset(Asset.worldMap, width: 90.w)),
              ),

              // ✅ Proceed Button
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
          child: RoundedButton(
            buttonName: 'PROCEED',
            onTap: () {
              if (controller.selectedIndex.value == 0) {
                Get.toNamed(Routes.DASHABORD_MARKET_PLACE);
              } else {
                SnackBars.errorSnackBar(content: 'Please select one feature');
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
                  Text(value, style: MyTexts.bold18.copyWith(color: MyColors.primary)),
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
