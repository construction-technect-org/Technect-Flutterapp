import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSelectedProduct/components/connector_category_card.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSelectedProduct/components/connector_product_card.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';

class ConnectorSelectedProductView extends StatelessWidget {
  final ConnectorSelectedProductController controller = Get.put(
    ConnectorSelectedProductController(),
  );
  final CommonController commonController = Get.find();
  final List<Map<String, String>> items = [
    {
      "title": "Main Category",
      "image": Asset.Product, // replace with your asset
      "label": "Construction Materials",
    },
    {"title": "Category", "image": Asset.Product, "label": "Fine Aggregate"},
    {"title": "Sub-Category", "image": Asset.Product, "label": "Sand"},
    {"title": "Product", "image": Asset.Product, "label": "Manufacture Sand"},
  ];
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
                child: Obx(() {
                  bool isPageSwipeEnabled;

                  switch (controller.currentPage.value) {
                    case 0:
                      // Page 0 → Location selected?
                      isPageSwipeEnabled = controller.selectedSiteIndex.value != -1;
                      break;
                    case 1:
                      // Page 1 → Main category selected?
                      isPageSwipeEnabled =
                          controller.selectedMainCategoryIndex.value != -1;
                      break;
                    case 2:
                      // Page 2 → Subcategory or product selected?
                      isPageSwipeEnabled = controller.selectedProductIndex.value != -1;
                      break;
                    default:
                      isPageSwipeEnabled = false;
                  }

                  return PageView.builder(
                    controller: controller.pageController,
                    physics: isPageSwipeEnabled
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    onPageChanged: (index) {
                      controller.currentPage.value = index;
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) return _locationContent();
                      if (index == 1) return _productDetailsContent();
                      return _subCategoryContent();
                    },
                  );
                }),
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

      if (page == 2) {
        return AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.white,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(Asset.profil, height: 40, width: 40),
              SizedBox(width: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Kirti',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      SizedBox(width: 0.4.w),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              _iconWithBadge(Asset.notifications),
              SizedBox(width: 0.8.h),
              _iconWithBadge(Asset.warning),
            ],
          ),
        );
      }
      // For other pages, keep your original back button / title AppBar
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
              SizedBox(width: 0.8.h),
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

          /// Delivery Radius
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Within Radius ",
                      style: MyTexts.regular16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.textFieldBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "5 KM",
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                size: 18,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                const Divider(color: MyColors.brightGray1),
              ],
            ),
          ),

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
                          SizedBox(height: 0.8.h),
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
                children: List.generate(controller.mainCategories.length, (index) {
                  final item = controller.mainCategories[index];
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
                              Asset.constuctionMaterial,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              item.name,
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

            // Sub Category
            if (controller.subCategories.isNotEmpty) ...[
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
                  itemCount: controller.subCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedSubCategoryIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectSubCategory(index),
                      child: ConnectorCategoryCard(
                        category: CategoryItem(
                          controller.subCategories[index].name,
                          Asset.Product,
                        ),
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),
            ],

            // Category Product (NEW)
            if (controller.categoryProducts.isNotEmpty) ...[
              SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Text(
                  "Select  Product",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categoryProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected =
                        controller.selectedProductCategoryIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectProductItem(index),
                      child: ConnectorCategoryCard(
                        category: CategoryItem(
                          controller.categoryProducts[index].name,
                          Asset.Product,
                        ),
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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search & Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton(svgAsset: Asset.searchIcon, label: "Search Product"),
                SizedBox(width: 2.w),
                _buildButton(
                  svgAsset: Asset.connectorLocation,
                  label: "Location",
                  trailing: Icons.arrow_drop_down,
                ),
                SizedBox(width: 2.w),
                _buildButton(svgAsset: Asset.filterIcon, label: "Specification"),
              ],
            ),
            SizedBox(height: 2.h),

            // Grid of items
            GridView.builder(
              shrinkWrap: true, // Important: allows GridView to take minimal height
              physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      items[index]["title"]!,
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            items[index]["image"]!,
                            height: 54,
                            width: 63,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: const Icon(Icons.check, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.9.h),
                    Text(
                      items[index]["label"]!,
                      textAlign: TextAlign.center,
                      style: MyTexts.regular12.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 2.h),
            // List of products
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12), // space below each card
                  child: ConnectorProductCard(
                    statusText: 'Active',
                    statusColor: MyColors.green,
                    productName: 'Premium M Sand',
                    companyName: "M M manufacturers",
                    brandName: 'SV Manufacturers',
                    locationText: 'Vasai Virar, Mahab Chowpatty',
                    pricePerUnit: 1234,
                    stockCount: 10,
                    imageAsset: Asset.Product,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildButton({
  String? imageAsset, // For PNG/JPG
  String? svgAsset, // For SVG
  required String label,
  IconData? trailing,
}) {
  return Container(
    width: 110,
    height: 30,
    decoration: BoxDecoration(
      color: MyColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: MyColors.greyFour),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageAsset != null)
          Image.asset(imageAsset, width: 10, height: 10, fit: BoxFit.contain),
        if (svgAsset != null) SvgPicture.asset(svgAsset, width: 10, height: 10),
        if (imageAsset != null || svgAsset != null)
          const SizedBox(width: 8), // 5 pixels spacing after the image
        Text(label, style: MyTexts.medium12.copyWith(color: MyColors.fontBlack)),
        if (trailing != null) ...[
          const SizedBox(width: 20),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black),
        ],
      ],
    ),
  );
}
