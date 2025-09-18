

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ListOfMerchant/controllers/list_0f_merchant_controller.dart';

class ListOfMerchantView extends GetView<ListOfMerchantController> {
  ListOfMerchantView({super.key});

  // Dummy data
  final List<Map<String, dynamic>> categories = [
    {"name": "Fine Aggregate", "image": Asset.Product},
  ];

  final List<Map<String, dynamic>> subCategories = [
    {"name": "Sand", "image": Asset.Product},
  ];

  final List<Map<String, dynamic>> products = [
    {"name": "Manufacture Sand", "image": Asset.Product},
    {"name": "Concrete Sand", "image": Asset.Product},
    {"name": "Plastering Sand", "image": Asset.Product},
    {"name": "River Sand", "image": Asset.Product},
    {"name": "Dust", "image": Asset.Product},
  ];
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

            
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSelectableCard({
  required String title,
  required String assetsImage,
  required bool isSelected,
  required VoidCallback onTap,
  double? width,
  double? height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width ?? 68,
              height: height ?? 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? MyColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(assetsImage, fit: BoxFit.cover),
              ),
            ),
            if (isSelected)
              const Positioned(
                top: -6,
                right: -6,
                child: Icon(Icons.check_box, color: MyColors.primary),
              ),
          ],
        ),
        SizedBox(height: 0.6.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: MyTexts.medium12.copyWith(color: MyColors.primary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}



