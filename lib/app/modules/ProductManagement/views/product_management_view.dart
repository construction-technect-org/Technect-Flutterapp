import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/product_card.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';

class ProductManagementHomeView extends StatelessWidget {
  const ProductManagementHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,

      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,

        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () {
                    // 👇 Navigate to new screen
                    Get.toNamed(Routes.ADDRESS);
                  },
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
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(22.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000), // light shadow (10% black)
                        blurRadius: 8, // soften the shadow
                        offset: Offset(0, 4), // move shadow down
                      ),
                    ],
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

              /// Features title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Product Management",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                ),
              ),
              SizedBox(height: 2.h),

              /// ✅ Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Total Products',
                            value: '04',
                            icon: SvgPicture.asset(Asset.TotalProducts),
                            iconBackground: MyColors.yellowundertones,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Featured',
                            value: '02',
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
                            value: '04',
                            icon: SvgPicture.asset(Asset.LowStock),
                            iconBackground: MyColors.paleRed,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Total Interests',
                            value: '02',
                            icon: SvgPicture.asset(Asset.TotalInterests),
                            iconBackground: MyColors.warmOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ✅ Product Cards
              // Inside your widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PRODUCT_DETAILS);
                      },
                      child: ProductCard(
                        statusText: 'Active',
                        statusColor: const Color(0xFF10B981),
                        productName: 'Premium M Sand ${index + 1}',
                        companyName: 'M M manufacturers',
                        brandName: 'SV Manufacturers',
                        locationText: 'Vasai Virar, Mahab Chowpatty',
                        pricePerUnit: 123.00,
                        stockCount: 45,
                        imageAsset: Asset.Product,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(height: 2.h),
              Center(
                child: RoundedButton(
                  onTap: () {
                    Get.toNamed(Routes.ADDP_PRODUCT);
                  },
                  buttonName: '',
                  borderRadius: 12,
                  width: 50.w,
                  height: 45,
                  verticalPadding: 0,
                  horizontalPadding: 0,
                  child: Center(
                    child: Text(
                      '+ Add Certification',
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.white,
                        fontFamily: MyTexts.Roboto,
                      ),
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
