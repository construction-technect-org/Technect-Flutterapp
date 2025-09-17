import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/product_card.dart';

class ProductApprovalView extends StatelessWidget {
  const ProductApprovalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: WelcomeName(),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Search bar
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
            const SizedBox(height: 16),

            /// Stats Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const _StatCard(
                      title: "Total Products",
                      value: "1.2K",
                      imagePath: Asset.inboxTotalProducts,
                    ),
                    SizedBox(width: 2.w),
                    const _StatCard(
                      title: "Approved Products",
                      value: "8.5K",
                      imagePath: Asset.approvedProducts,
                    ),
                    SizedBox(width: 2.w),
                    const _StatCard(
                      title: "Rejected Products",
                      value: "350",
                      imagePath: Asset.rejectedProducts,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Product Approval",
                    style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                  ),
                  const Spacer(), // Automatically takes available space
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // "Approved" text with underline using Container decoration
                      Container(
                        padding: const EdgeInsets.only(bottom: 2), // Space for underline
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: MyColors.gray53)),
                        ),
                        child: Text(
                          "Approved",
                          style: MyTexts.extraBold18.copyWith(color: MyColors.green),
                        ),
                      ),
                      SizedBox(width: 0.4.w), // space between text and icon
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30,
                        color: MyColors.darkSilver,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.APPROVAL_INBOX);
                      },
                      child: const ProductCard(
                        statusText: 'Approved',
                        statusColor: MyColors.green,
                        productName: 'Premium M Sand',
                        brandName: 'SV Manufacturers',
                        locationText: 'Vasai Virar, Mahab Chowpatty',
                        pricePerUnit: 123,
                        stockCount: 0,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String imagePath;

  const _StatCard({required this.title, required this.value, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 24, height: 24),
          SizedBox(height: 0.6.h),
          Text(title, style: MyTexts.regular12.copyWith(color: MyColors.fontBlack)),
          SizedBox(height: 0.4.h),
          Text(value, style: MyTexts.extraBold14.copyWith(color: MyColors.fontBlack)),
        ],
      ),
    );
  }
}
