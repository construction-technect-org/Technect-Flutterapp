import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Marketplace/controllers/market_place_controller.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';

class MarketPlaceView extends GetView<MarketPlaceController> {
  const MarketPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,

        backgroundColor: MyColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 4.h, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.ADDRESS),
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(22.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {},
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Marketplace",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.americanSilver.withValues(alpha: 0.6),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Obx(
                  () => Column(
                    children: List.generate(controller.items.length, (index) {
                      final item = controller.items[index];
                      final isSelected = controller.selectedIndex.value == index;

                      return GestureDetector(
                        onTap: () => controller.selectIndex(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: 73,
                                    width: 73,
                                    decoration: BoxDecoration(
                                      color: MyColors.yellow,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(item["icon"], fit: BoxFit.contain),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_box,
                                      color: MyColors.primary,
                                      size: 22,
                                    ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? MyColors.yellow.withValues(alpha: 0.5)
                                        : MyColors.ghostWhite,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item["title"],
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              /// Features
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Total Products',
                            value: '10',
                            icon: SvgPicture.asset(Asset.TotalProducts),
                            iconBackground: MyColors.yellowundertones,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Featured',
                            value: '0',
                            icon: SvgPicture.asset(Asset.Featured),
                            iconBackground: MyColors.verypaleBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Low Stock',
                            value: '0',
                            icon: SvgPicture.asset(Asset.LowStock),
                            iconBackground: MyColors.paleRed,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Total Interests',
                            value: '0',
                            icon: SvgPicture.asset(Asset.TotalInterests),
                            iconBackground: MyColors.warmOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),
              Center(
                child: RoundedButton(
                  onTap: () {},
                  buttonName: '',
                  borderRadius: 12,
                  width: 50.w,
                  height: 50,
                  verticalPadding: 0,
                  child: Center(
                    child: Text(
                      '+ Add New Product',
                      style: MyTexts.medium16.copyWith(color: MyColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
