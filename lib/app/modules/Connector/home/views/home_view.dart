import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/home/components/home_components.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CommonController commonController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Vaishnavi!',
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Text(
                        'Sadashiv Peth, Pune',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
                        ),
                      ),
                    ],
                  ),
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
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(Asset.notifications, width: 28, height: 28),
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: TextField(
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

            // Features title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Features",
                style: MyTexts.extraBold18.copyWith(color: MyColors.textFieldBackground),
              ),
            ),

            SizedBox(height: 1.h),

            // Features grid
            Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically calculate item width
                    final double itemWidth =
                        (constraints.maxWidth - (3 * 10)) / 3; // 4 per row with spacing
                    final double itemHeight = itemWidth + 10; // for icon + text

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        // final isSelected =
                        //     controller.selectedIndex.value == index;

                        return GestureDetector(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            if (item['title'] == "Marketplace") {
                              Get.toNamed(Routes.CONNECTOR_MARKET_PLACE);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFED29),

                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['icon'],
                                  height: itemWidth * 0.35, // responsive icon size
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item["title"],
                                  textAlign: TextAlign.center,
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Team title row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Team", style: MyTexts.bold18.copyWith(color: MyColors.fontBlack)),
                  Text(
                    "View All",
                    style: MyTexts.medium12.copyWith(color: MyColors.textFieldBackground),
                  ),
                ],
              ),
            ),

            // Team List
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 3,
              shrinkWrap: true, // Important for nested scrollables
              physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: MerchantCard(), // Use your card here
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
