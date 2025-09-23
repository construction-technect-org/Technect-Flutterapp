import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorSelectLocation/controllers/connector_select_location_controller.dart';

class ConnectorSelectLocationView extends GetView<ConnectorSelectLocationController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Stack(
        children: [
          /// ✅ Main Screen
          Scaffold(
            appBar: AppBar(
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
                          const SizedBox(width: 4),
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
                  _topIcon(Asset.notifications, true),
                  SizedBox(width: 0.8.h),
                  _topIcon(Asset.warning, true),
                ],
              ),
            ),
            backgroundColor: MyColors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔍 Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                    child: _searchBar(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Features",
                      style: MyTexts.extraBold18.copyWith(
                        color: MyColors.black,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  /// ✅ Grid expands proportionally
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greyE5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth = (constraints.maxWidth - (3 * 10)) / 3;
                        final double itemHeight = itemWidth + 10;
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.features.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: itemWidth / itemHeight,
                          ),
                          itemBuilder: (context, index) {
                            final item = controller.features[index];
                            return Obx(() {
                              final isSelected = controller.selectedIndex.value == index;
                              return _buildFeatureCard(
                                controller: controller,
                                isSelected: isSelected,
                                item: item,
                                itemWidth: itemWidth,
                                onTap: () {
                                  if (index == 0) {
                                    controller.selectedIndex.value = index;
                                  } else {
                                    SnackBars.successSnackBar(
                                      content: 'This feature will come soon',
                                    );
                                  }
                                },
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 1.h),

                  /// Location Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Select your location ",
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Select a location to see connectors ",
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.darkSilver,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  /// Two Cards
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: _locationCard(
                            "3VR7+34 Mumbai,\nMaharashtra,460017",
                            "Site 1",
                            false,
                          ),
                        ),
                        Expanded(child: _locationCard("", "Site 2", true)),
                      ],
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
                              "Delivery Radius",
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

                  /// Bottom Section
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Center(child: _bottomOptions()),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ✅ Overlay
          Positioned.fill(bottom: 410, child: Container(color: const Color(0x99FFFFFF))),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(22.5),
        border: Border.all(color: MyColors.grayD4),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 8),
            child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          hintText: 'Search',
          hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
          ),
        ),
      ),
    );
  }

  Widget _topIcon(String asset, bool showBadge) {
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
          if (showBadge)
            Positioned(
              right: 0,
              top: 3,
              child: Container(
                width: 6,
                height: 6,
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

  Widget _locationCard(String text, String label, bool highlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 140,
        width: 144,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: highlight ? MyColors.primary : MyColors.grayD4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
          child: Stack(
            children: [
              if (highlight)
                const Icon(Icons.my_location, size: 14, color: MyColors.primary),
              Positioned(
                left: highlight ? 20 : 0,
                top: 0,
                right: 0,
                bottom: 40,
                child: Text(
                  text,
                  style: MyTexts.regular14.copyWith(
                    color: MyColors.fontBlack,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: highlight ? MyColors.greyFour : MyColors.primary,
                  ),
                  child: Text(
                    label,
                    style: MyTexts.regular14.copyWith(
                      color: highlight ? MyColors.fontBlack : MyColors.white,
                      fontFamily: MyTexts.Roboto,
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
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to new screen
              Get.toNamed(Routes.CONNECTOR_ADD_LOCATION);
            },
          ),

          Divider(height: 0.8, color: MyColors.gray5D.withValues(alpha: 0.1)),
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

class _buildFeatureCard extends StatelessWidget {
  const _buildFeatureCard({
    super.key,
    required this.controller,
    required this.isSelected,
    required this.item,
    required this.itemWidth,
    required this.onTap,
  });

  final ConnectorSelectLocationController controller;
  final bool isSelected;
  final Map<String, String> item;
  final double itemWidth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? MyColors.primary : MyColors.grayD4,
                ),
                color: isSelected ? MyColors.yellow : MyColors.greyE5,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon']!,
                    color: isSelected ? MyColors.primary : MyColors.grey,
                    height: itemWidth * 0.35,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item["title"]!,
                    textAlign: TextAlign.center,
                    style: MyTexts.medium13.copyWith(color: MyColors.fontBlack),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 20,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
