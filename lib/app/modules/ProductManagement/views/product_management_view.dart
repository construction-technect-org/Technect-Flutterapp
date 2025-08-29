import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/constants.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; // 👈 For Get.toNamed

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
                    Get.toNamed(Routes.LOCATION);
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
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
                        child: SvgPicture.asset(
                          Asset.searchIcon,
                          height: 16,
                          width: 16,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      hintText: 'Search',
                      hintStyle: MyTexts.medium16.copyWith(
                        color: MyColors.darkGray,
                      ),
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
                        child: SvgPicture.asset(
                          Asset.filterIcon,
                          height: 20,
                          width: 20,
                        ),
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
                  style: MyTexts.extraBold18.copyWith(
                    color: MyColors.fontBlack,
                  ),
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
                          child: _StatCard(
                            title: 'Total Products',
                            value: '04',
                            icon: SvgPicture.asset(Asset.TotalProducts),
                            iconBackground: MyColors.yellowundertones,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
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
                          child: _StatCard(
                            title: 'Low Stock',
                            value: '04',
                            icon: SvgPicture.asset(Asset.LowStock),
                            iconBackground: MyColors.paleRed,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _ProductCard(
                      statusText: 'Active',
                      statusColor: Color(0xFF10B981),
                      productName: 'Premium M Sand',
                      companyName: 'M M manufacturers',
                      brandName: 'SV Manufacturers',
                      locationText: 'Vasai Virar, Mahab Chowpatty',
                      pricePerUnit: 123.00,
                      stockCount: 45,
                      imageAsset: Asset.Product,
                    ),
                    SizedBox(height: 12),
                    _ProductCard(
                      statusText: 'Active',
                      statusColor: Color(0xFF10B981),
                      productName: 'Premium M Sand',
                      companyName: 'M M manufacturers',
                      brandName: 'SV Manufacturers',
                      locationText: 'Vasai Virar, Mahab Chowpatty',
                      pricePerUnit: 123.00,
                      stockCount: 45,
                      imageAsset: Asset.Product,
                    ),
                  ],
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
)

            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackground,
  });

  final String title;
  final String value;
  final Widget icon;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.americanSilver),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: SizedBox(height: 36, width: 36, child: icon),
          ),
          SizedBox(width: 1.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTexts.regular14.copyWith(color: MyColors.davysGrey),
                ),
                SizedBox(height: 0.4.h),
                Text(
                  value,
                  style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.statusText,
    required this.statusColor,
    required this.productName,
    required this.companyName,
    required this.brandName,
    required this.locationText,
    required this.pricePerUnit,
    required this.stockCount,
    required this.imageAsset, // ✅ Changed to asset
  });

  final String statusText;
  final Color statusColor;
  final String productName;
  final String companyName;
  final String brandName;
  final String locationText;
  final double pricePerUnit;
  final int stockCount;
  final String imageAsset; // ✅ asset path instead of URL

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.americanSilver),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row image + content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageAsset,
                    width: 56,
                    height: 57,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 1.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + status pill
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: MyTexts.bold16.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.paleGreen,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  statusText,
                                  style: MyTexts.regular12.copyWith(
                                    color: MyColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.4.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Company: ',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.platinumGray,
                              ),
                            ),
                            TextSpan(
                              text: companyName,
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.fontBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.2.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Brand: ',
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: brandName,
                              style: MyTexts.regular14.copyWith(
                                color: MyColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    locationText,
                    style: MyTexts.regular14.copyWith(color: MyColors.graniteg),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.7.h),
            Text(
              '₹ ${pricePerUnit.toStringAsFixed(2)}/unit',
              style: MyTexts.extraBold20.copyWith(color: MyColors.primary),
            ),
            const SizedBox(height: 6),

            SizedBox(height: 0.8.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'In Stock: ',
                    style: MyTexts.regular12.copyWith(color: MyColors.silver),
                  ),
                  TextSpan(
                    text: '45',
                    style: MyTexts.regular12.copyWith(
                      color: MyColors.fontBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.8.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Specifications',
                  style: MyTexts.regular14.copyWith(color: MyColors.warning),
                ),
                SizedBox(width: 0.6.h),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: MyColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
