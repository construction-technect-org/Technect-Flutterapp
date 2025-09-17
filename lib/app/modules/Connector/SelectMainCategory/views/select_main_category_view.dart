import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/SelectMainCategory/controllers/select_main_category_controller.dart';

class SelectMainCategoryView extends GetView<SelectMainCategoryController> {
  SelectMainCategoryView({super.key});

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

              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Select Main Category",
                  style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                ),
              ),

              /// Horizontal category chips
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child: Row(
                    children: List.generate(controller.categories.length, (index) {
                      final category = controller.categories[index];
                      final isSelected = controller.selectedCategory.value == index;

                      return GestureDetector(
                        onTap: () {
                          controller.selectCategory(
                            index,
                          ); // ✅ Make sure this also updates subcategories/products
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.paleBlue,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: MyColors.primary)
                                : Border.all(color: Colors.transparent),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                category['image'], // ✅ Fixed line
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category['title'],
                                style: MyTexts.medium14.copyWith(color: MyColors.primary),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),

              /// 👇 Add your Category/SubCategory/Product grids here
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.8.h),

                  /// ✅ Wrap Category GridView in Obx
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return buildSelectableCard(
                        title: categories[index]["name"],
                        assetsImage: categories[index]["image"],
                        isSelected: controller.selectedCategory.value == index,
                        onTap: () {
                          controller.selectCategory(index);
                        },
                      );
                    },
                  ),

                  SizedBox(height: 1.h),
                  const Text(
                    "Sub-Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.8.h),

                  /// ✅ Wrap Sub-Category GridView in Obx
                  Obx(
                    () => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 9,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.subCategories.length,
                      itemBuilder: (context, index) {
                        final subCategory = controller.subCategories[index];
                        return buildSelectableCard(
                          title: subCategory["name"],
                          assetsImage: subCategory["image"],
                          isSelected: controller.selectedSubCategory.value == index,
                          onTap: () {
                            controller.selectSubCategory(index);
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 1.h),
                  const Text(
                    "Product",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.8.h),

                  /// ✅ Wrap Product GridView in Obx
                  Obx(
                    () => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return buildSelectableCard(
                          title: product["name"],
                          assetsImage: product["image"],
                          isSelected: controller.selectedProduct.value == index,
                          onTap: () {
                            controller.selectProduct(index);
                          },
                        );
                      },
                    ),
                  ),
                ],
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
