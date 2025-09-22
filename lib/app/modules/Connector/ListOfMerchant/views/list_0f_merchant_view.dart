import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ListOfMerchant/components/connector_product_card.dart';
import 'package:construction_technect/app/modules/Connector/ListOfMerchant/controllers/list_0f_merchant_controller.dart';

class ListOfMerchantView extends GetView<ListOfMerchantController> {
  ListOfMerchantView({super.key});

  final List<Map<String, dynamic>> categories = [
    {"title": "Main Category", "name": "Sand", "image": Asset.Product, "selected": true},
    {"title": "Category", "name": "Sand", "image": Asset.Product, "selected": true},
    {"title": "Sub-Category", "name": "Sand", "image": Asset.Product, "selected": true},
    {"title": "Product", "name": "Sand", "image": Asset.Product, "selected": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.backgroundColor,
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
                color: MyColors.white,
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

              /// Categories Grid
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ), // no padding around grid
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    mainAxisSpacing: 0, // no vertical space
                    crossAxisSpacing: 0, // no horizontal space
                    childAspectRatio: 0.99, // adjust as needed
                  ),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item["title"],
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.Roboto,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 0.8.h),

                        // Wrap image with Stack to overlay the check icon
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                item["image"],
                                width: 90,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -6,
                              right: -6,
                              child: Container(
                                height: 20,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: MyColors.primary,
                                  borderRadius: BorderRadius.circular(5),
                                  // shape: BoxShape.s,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 0.7.h),
                        Text(
                          item["name"],
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.Roboto,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Search Product
                      _buildChip(
                        asset: Asset.searchIcon,
                        isSvg: true,
                        text: "Search Product",
                      ),
                      SizedBox(width: 2.w),
                      // Location
                      _buildChip(
                        icon: Icons.location_on_outlined,
                        text: "Location",
                        trailing: Icons.keyboard_arrow_down,
                      ),
                      SizedBox(width: 2.w),
                      // Specification
                      _buildChip(
                        asset: Asset.filterIcon,
                        isSvg: true,
                        text: "Specification",
                        trailing: Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Product",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Get.toNamed(
                        //   Routes.PRODUCT_DETAILS,
                        //   arguments: {"product": product},
                        // );
                      },
                      child: const ConnectorProductCard(
                        statusText: 'Active',
                        statusColor: MyColors.green,
                        productName: 'Premium M Sand',
                        brandName: 'SV Manufacturers',
                        locationText: 'Vasai Virar, Mahab Chowpatty',
                        pricePerUnit: 1000,
                        stockCount: 1,
                        imageAsset: Asset.Product,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip({
    String? asset, // path to image (PNG, JPG, etc.) or SVG
    bool isSvg = false, // true if the asset is SVG
    IconData? icon,
    required String text,
    IconData? trailing,
  }) {
    return Container(
      width: 109,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center, // center vertically
        children: [
          if (asset != null)
            isSvg
                ? SvgPicture.asset(asset, width: 12, height: 12, fit: BoxFit.contain)
                : Image.asset(asset, width: 12, height: 12, fit: BoxFit.cover)
          else if (icon != null)
            Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis, // prevent overflow
              style: MyTexts.medium10.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 6),
            Icon(trailing, size: 18, color: Colors.black),
          ],
        ],
      ),
    );
  }
}
