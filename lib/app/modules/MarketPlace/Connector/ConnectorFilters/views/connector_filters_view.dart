import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorFilters/controllers/connector_filter_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';
import 'package:gap/gap.dart';

class ConnectorFiltersView extends StatefulWidget {
  const ConnectorFiltersView({super.key});

  @override
  State<ConnectorFiltersView> createState() => _ConnectorFiltersViewState();
}

class _ConnectorFiltersViewState extends State<ConnectorFiltersView> {
  final controller = Get.find<ConnectorFilterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(title: const Text("Filters")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: RoundedButton(
                color: Colors.white,
                borderColor: MyColors.primary,
                style: MyTexts.bold16.copyWith(color: MyColors.primary),
                buttonName: "Clear All",
                onTap: () {
                  controller.selectedFilters.clear();
                  controller.multiSelectValues.clear();
                  controller.initFilterControllers();
                },
              ),
            ),
            const Gap(16),
            Expanded(
              child: RoundedButton(
                buttonName: "Apply",
                onTap: () async {
                  final filtersData = controller.getFinalFilterData();

                  await Get.find<ConnectorSelectedProductController>()
                      .getAllProducts(filter: true, filtersData: filtersData);

                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),

      body: Obx(() {
        if (controller.isLoad.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filters.length,
          itemBuilder: (context, index) {
            final filter = controller.filters[index];
            final isExpanded = controller.expandedSection.contains(
              filter.filterName,
            );

            return Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        filter.label ?? '',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.fontBlack,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: MyColors.grey,
                      ),
                      onTap: () {
                        if (controller.expandedSection.contains(
                          filter.filterName,
                        )) {
                          controller.expandedSection.remove(
                            filter.filterName ?? '',
                          );
                        } else {
                          controller.expandedSection.add(
                            filter.filterName ?? '',
                          );
                        }

                        setState(() {});
                      },
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: _buildFilterBody(filter),
                      ),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildFilterBody(ConnectorFilterModel filter) {
    switch (filter.filterType) {
      case 'number':
        final range = controller.rangeValues[filter.filterName]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RangeSlider(
              values: range.value,
              min: filter.min ?? 0,
              max: filter.max ?? 100,
              divisions: 10,
              activeColor: MyColors.primary,
              onChanged: (val) => range.value = val,
            ),
            Text(
              "From ${range.value.start.toStringAsFixed(1)} to ${range.value.end.toStringAsFixed(1)}",
              style: MyTexts.regular14.copyWith(color: MyColors.grey),
            ),
          ],
        );
      case 'dropdown':
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              filter.options?.map((opt) {
                final selected =
                    controller.selectedFilters[filter.filterName]?.value == opt;
                return FilterChip(
                  label: Text(
                    opt,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  backgroundColor: Colors.white,
                  selectedColor: MyColors.primary,
                  surfaceTintColor: Colors.transparent,
                  checkmarkColor: Colors.white,
                  onSelected: (val) {
                    if (val) {
                      controller.selectedFilters[filter.filterName]?.value =
                          opt;
                    } else {
                      controller.selectedFilters[filter.filterName]?.value = '';
                    }
                    setState(() {});
                  },
                );
              }).toList() ??
              [],
        );

      case 'dropdown_multiple':
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              filter.options?.map((opt) {
                final list = controller.multiSelectValues[filter.filterName]!;
                final selected = list.contains(opt);
                return FilterChip(
                  label: Text(
                    opt,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  backgroundColor: Colors.white,
                  selectedColor: MyColors.primary,
                  checkmarkColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  onSelected: (val) {
                    if (val) {
                      list.add(opt);
                    } else {
                      list.remove(opt);
                    }
                    setState(() {});
                  },
                );
              }).toList() ??
              [],
        );

      default:
        return const SizedBox();
    }
  }
}
