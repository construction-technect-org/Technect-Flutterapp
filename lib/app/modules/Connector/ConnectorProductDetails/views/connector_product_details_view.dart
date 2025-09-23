import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProductDetails/controllers/connector_product_details_controller.dart';

class ConnectorProductDetailsView extends StatelessWidget {
  final ConnectorProductDetailsController controller = Get.put(
    ConnectorProductDetailsController(),
  );
  final CommonController commonController = Get.find();

  final List<Map<String, String>> selectMainCategory = [
    {'title': 'Construction Material', 'image': Asset.constuctionMaterial},
    {'title': 'Interior Material', 'image': Asset.interiorMateria},
  ];

  final List<CategoryItem> selectCategory = [
    CategoryItem("Fine Aggregate", Asset.Product),
    CategoryItem("Coarse Aggregate", Asset.constuctionMaterial),
    CategoryItem("Bricks", Asset.interiorMateria),
    CategoryItem("Blocks", Asset.constuctionMaterial),
    CategoryItem("Ready Concrete", Asset.interiorMateria),
    CategoryItem("Cement", Asset.constuctionMaterial),
    CategoryItem("Steel", Asset.Product),
    CategoryItem("Electrical", Asset.constuctionMaterial),
    CategoryItem("Plumbing", Asset.constuctionMaterial),
  ];

  final List<CategoryItem> selectSubCategory = [CategoryItem("Sand", Asset.Product)];

 

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Obx(
                () => controller.currentPage.value == 0
                    ? _buildSearchBar()
                    : const SizedBox.shrink(),
              ),
              Expanded(
  child: Obx(
    () {
      bool isPageSwipeEnabled = false;

      // Enable swipe only when selections are made
      if (controller.currentPage.value == 0) {
        isPageSwipeEnabled = controller.selectedMainCategoryIndex.value != -1;
      } else if (controller.currentPage.value == 1) {
        isPageSwipeEnabled = controller.selectedIndex.value != -1;
      } else if (controller.currentPage.value == 2) {
        isPageSwipeEnabled = controller.selectedSubCategoryIndex.value != -1;
      }

      return PageView(
        controller: controller.pageController,
        physics: isPageSwipeEnabled
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          controller.currentPage.value = index;
        },
        children: [
          _locationContent(),
          _productDetailsContent(),
          _subCategoryContent(),
        ],
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

  Widget _buildAppBar() {
    return Obx(() {
      final page = controller.currentPage.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (page > 0) {
                  controller.goToPage(page - 1);
                } else {
                  Get.back();
                }
              },
              borderRadius: BorderRadius.circular(50),
              child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
            ),
            const SizedBox(width: 8),
            Text(
              page == 0 ? "PRODUCT DETAILS" : "SELECT YOUR PRODUCT",
              style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
            ),
            const Spacer(),
            if (page == 0) ...[
              _iconWithBadge(Asset.notifications),
              SizedBox(width: 0.8.w),
              _iconWithBadge(Asset.warning),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: CommonTextField(
        onChange: (value) {},
        borderRadius: 22,
        hintText: 'Search',
        suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
        prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
      ),
    );
  }

  Widget _iconWithBadge(String asset) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.hexGray92),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(asset, width: 28, height: 28),
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
    );
  }

  Widget _locationContent() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Select a Location",
              style: MyTexts.medium20.copyWith(color: MyColors.fontBlack),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: _bottomOptions(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Recent Location",
              style: MyTexts.regular16.copyWith(color: MyColors.darkGrayishRed),
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: controller.sites.length,
                itemBuilder: (context, index) {
                  final isSelected = controller.selectedSiteIndex.value == index;
                  return GestureDetector(
                    onTap: () {
                      controller.selectSite(index);
                      controller.goToPage(1);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? MyColors.primary : MyColors.grayD4,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? MyColors.primary : MyColors.grayD4,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Site ${index + 1}',
                              style: MyTexts.regular14.copyWith(
                                color: isSelected ? MyColors.white : MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.sites[index],
                            style: MyTexts.regular14.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _bottomOptions() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add, color: MyColors.primary, size: 16),
            title: Text(
              "Add Location Manually",
              style: MyTexts.regular16.copyWith(color: MyColors.fontBlack),
            ),
            onTap: () => Get.toNamed(Routes.CONNECTOR_ADD_LOCATION),
          ),
          Divider(height: 1, color: MyColors.gray5D.withAlpha(30)),
          ListTile(
            leading: const Icon(Icons.my_location, color: MyColors.primary, size: 16),
            title: Text(
              "Use your Current Location",
              style: MyTexts.regular16.copyWith(color: MyColors.fontBlack),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDetailsContent() {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Select Main Category",
                style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(selectMainCategory.length, (index) {
                  final item = selectMainCategory[index];

                  // Show only selected item if any is selected
                  if (controller.selectedMainCategoryIndex.value != -1 &&
                      controller.selectedMainCategoryIndex.value != index) {
                    return const SizedBox.shrink();
                  }

                  final isSelected = controller.selectedMainCategoryIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.selectMainCategory(index),
                    child: Container(
                      width: 249,
                      height: 49,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? MyColors.yellow : MyColors.grayF2,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? MyColors.primary : MyColors.grayD4,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item['title']!,
                              style: MyTexts.medium16.copyWith(
                                fontFamily: MyTexts.Roboto,
                                color: isSelected ? MyColors.primary : MyColors.fontBlack,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Category
            if (controller.selectedMainCategoryIndex.value != -1) ...[
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Text(
                  "Select Category",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectCategory.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectCategoryItem(index),
                      child: CategoryCard(
                        category: selectCategory[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],

            // Subcategory
            if (controller.selectedIndex.value != -1) ...[
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Text(
                  "Select Sub-Category",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectSubCategory.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedSubCategoryIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectSubCategoryItem(index),
                      child: CategoryCard(
                        category: selectSubCategory[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],

            // Products
            if (controller.selectedSubCategoryIndex.value != -1) ...[
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Text(
                  "Select Product",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:  controller.selectProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectProduct == index;
                    return GestureDetector(
                      onTap: () => controller.selectProductItem(index),
                      child: CategoryCard(
                        category: controller.selectProduct[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _subCategoryContent() {
    return const Center(child: Text("Sub Category Page (Optional)"));
  }
}

// Category Model
class CategoryItem {
  final String name;
  final String imagePath;

  CategoryItem(this.name, this.imagePath);
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;

  const CategoryCard({Key? key, required this.category, this.isSelected = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, // <-- important to allow overflow
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(category.imagePath),
              ),
            ),
            if (isSelected)
              Positioned(
                top: -5, // move it slightly above the container
                right: -5, // move it slightly outside the border
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 1), // optional outline
                  ),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(height: 0.6.h),
        Flexible(
          child: Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: MyTexts.medium12.copyWith(
              color: isSelected ? MyColors.primary : MyColors.fontBlack,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }
}
