import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProductDetails/controllers/connector_product_details_controller.dart';

class ConnectorProductDetailsView extends StatefulWidget {
  @override
  State<ConnectorProductDetailsView> createState() => _ConnectorProductDetailsViewState();
}

class _ConnectorProductDetailsViewState extends State<ConnectorProductDetailsView> {
  final ConnectorProductDetailsController controller = Get.put(
    ConnectorProductDetailsController(),
  );
  final CommonController commonController = Get.find();
  final PageController pageController = PageController();

  int? selectedIndex;

  final List<Map<String, String>> categories = [
    {
      'title': 'Construction Material',
      'image': Asset.constuctionMaterial,
    },
    {
      'title': 'Interior Material',
      'image': Asset.interiorMateria,
    },
  ];



final List<CategoryItem> SelectCategory = [
    CategoryItem("Fine Aggregate", Asset.constuctionMaterial),
    CategoryItem("Coarse Aggregate", Asset.constuctionMaterial),
    CategoryItem("Bricks", Asset.constuctionMaterial),
    CategoryItem("Blocks", Asset.constuctionMaterial),
    CategoryItem("Ready Concrete", Asset.constuctionMaterial),
    CategoryItem("Cement", Asset.constuctionMaterial),
    CategoryItem("Steel", Asset.constuctionMaterial),
    CategoryItem("Electrical", Asset.constuctionMaterial),
    CategoryItem("Plumbing", Asset.constuctionMaterial),
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
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(50),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                       "PRODUCT DETAILS",
                      style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                    ),
                    const Spacer(),
                    // Notifications & Warning Icons
                    _iconWithBadge(Asset.notifications),
                    SizedBox(width: 0.8.w),
                    _iconWithBadge(Asset.warning),
                  ],
                ),
              ),

              // Search Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: CommonTextField(
                  onChange: (value) {},
                  borderRadius: 22,
                  hintText: 'Search',
                  suffixIcon: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
                  prefixIcon: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
                ),
              ),
              SizedBox(height: 2.h),

              // PageView
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _locationContent(), // Page 1
                    _productDetailsContent(), // Page 2
                  ],
                ),
              ),
            ],
          ),
        ),
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

  // --- Page 1: Location Content ---
  Widget _locationContent() {
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
                            Icon(Icons.keyboard_arrow_up, size: 18, color: Colors.black),
                            Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black),
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
                return Obx(() {
                  final isSelected = controller.selectedSiteIndex.value == index;
                  return GestureDetector(
                    onTap: () {
                      controller.selectSite(index);
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
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
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  // --- Page 2: Product Details Content ---
  Widget _productDetailsContent() {
  return Column(
    children: [
      // Top Title
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              "Select Main Category",
              style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
            ),
          ],
        ),
      ),

      // List of categories
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            final bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index; // mark selected
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? MyColors.yellow : MyColors.grayF2,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? MyColors.primary : MyColors.grayD4,
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: MyTexts.medium18.copyWith(
                          color: isSelected ? MyColors.primary : MyColors.fontBlack,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Show GridView only if a category is selected
      if (selectedIndex != null) ...[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                "Select Sub Category",
                style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SelectCategory.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.97,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: SelectCategory[index]);
            },
          ),
        ),
      ],
    ],
  );
}

  Widget _bottomOptions() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.add, color: MyColors.primary, size: 16),
            title: Text(
              "Add Location Manually",
              style: MyTexts.regular16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            onTap: () {
              Get.toNamed(Routes.CONNECTOR_ADD_LOCATION);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 0.8, color: MyColors.gray5D.withValues(alpha: 0.1)),
          ),
          ListTile(
            leading: const Icon(Icons.my_location, color: MyColors.primary, size: 16),
            title: Text(
              "Use your Current Location",
              style: MyTexts.regular16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class CategoryItem {
  final String name;
  final String imagePath;

  CategoryItem(this.name, this.imagePath);
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Selected: ${category.name}");
      },
      child: Column(
        children: [
          SizedBox(
            width: 68,
            child:Image.asset(category.imagePath) ,
          ),
          const SizedBox(height: 6),
            Flexible(
            child: Text(
              category.name,
              maxLines: 1, // only one line
              overflow: TextOverflow.ellipsis, // cut off with "..."
              softWrap: false, // prevent wrapping to next line
              style: MyTexts.medium12.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
              textAlign: TextAlign.center,
            ),
          ),
       
        ],
      ),
    );
  }
}

