import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';

class ConnectorFiltersView extends GetView<ConnectorFilterController> {
  const ConnectorFiltersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(color: MyColors.backgroundColor),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back_ios_new, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "Filters",
                              style: MyTexts.medium20.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.Roboto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 🔍 Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(22.5),
                          border: Border.all(color: MyColors.chineseSilver),
                        ),
                        child: TextFormField(
                          controller: controller.searchController,
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
                            hintText: 'Search “filter or type”',
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
                          ),
                        ),
                      ),
                    ),

                    // ListView with filters
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        children: [
                          SizedBox(height: 0.6.h),
                          // Brand section
                          _expandableSection(
                            "Brand",
                            controller.brands,
                            controller.selectedBrand,
                          ),
                          _expandableSection(
                            "UOM",
                            controller.uoms,
                            controller.selectedUOM,
                          ),
                          _expandableSection(
                            "Shape",
                            controller.shapes,
                            controller.selectedShape,
                          ),
                          _expandableSection(
                            "Texture",
                            controller.textures,
                            controller.selectedTexture,
                          ),
                          _expandableSection(
                            "Size",
                            controller.sizes,
                            controller.selectedSize,
                          ),
                          _expandableSection(
                            "Weight",
                            controller.weights,
                            controller.selectedWeight,
                          ),
                        ],
                      ),
                    ),

                    // Bottom buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: controller.clear,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red.shade200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Clear',
                                style: MyTexts.medium18.copyWith(
                                  color: MyColors.red,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: MyColors.primary,
                              ),
                              child: Text(
                                'Apply',
                                style: MyTexts.medium18.copyWith(
                                  color: MyColors.white,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section header text
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: MyTexts.medium16.copyWith(
          color: MyColors.fontBlack,
          fontFamily: MyTexts.Roboto,
        ),
      ),
    );
  }

  /// Expandable section with radio list
  Widget _expandableSection(String title, List<String> options, RxnString selectedValue) {
    return Obx(() {
      final isExpanded = controller.expandedSection.value == title;
      return Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Geometric,
              ),
            ),
            onTap: () {
              if (isExpanded) {
                controller.expandedSection.value = ''; // collapse if same clicked
              } else {
                controller.expandedSection.value = title; // open new section
              }
            },
          ),
          if (isExpanded)
            Column(
              children: options.map((o) {
                return RadioListTile<String>(
                  value: o,
                  groupValue: selectedValue.value,
                  onChanged: (val) => selectedValue.value = val,
                  title: Text(
                    o,
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Geometric,
                    ),
                  ),
                  activeColor: MyColors.primary,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: const EdgeInsets.only(left: 8),
                );
              }).toList(),
            ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Divider()),
        ],
      );
    });
  }
}
