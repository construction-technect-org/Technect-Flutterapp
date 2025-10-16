import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorSelectedProduct/controllers/connector_selected_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/models/get_filter_model.dart';

class ConnectorFilterController extends GetxController {
  RxList<ConnectorFilterModel> filters = <ConnectorFilterModel>[].obs;
  RxMap<String, dynamic> selectedFilters = <String, dynamic>{}.obs;
  Map<String, Rx<RangeValues>> rangeValues = {};
  Map<String, RxList<String>> multiSelectValues = {};
  RxBool isLoad = false.obs;


  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final otherFilters =
          Get.find<ConnectorSelectedProductController>().filters;

      filters.assignAll(
        otherFilters.map(
          (f) => ConnectorFilterModel(
            filterName: f.filterName,
            filterType: f.filterType,
            min: double.tryParse(f.minValue ?? '0'),
            max: double.tryParse(f.maxValue ?? '100'),
            options: f.dropdownList,
            label: f.filterLabel,
          ),
        ),
      );

      initFilterControllers();
      isLoad.value = false;
    });
  }


  void initFilterControllers() {
    for (final filter in filters) {
      if (filter.filterType == 'number') {
        rangeValues[filter.filterName ?? ''] = RangeValues(
          filter.min ?? 0,
          filter.max ?? 0,
        ).obs;
      } else if (filter.filterType == 'dropdown_multiple') {
        multiSelectValues[filter.filterName ?? ''] = <String>[].obs;
      } else if (filter.filterType == 'dropdown') {
        selectedFilters[filter.filterName ?? ''] = ''.obs;
      } else {
        selectedFilters[filter.filterName ?? ''] = ''.obs;
      }
    }
  }

  RxList<String> expandedSection = <String>[].obs;

  Map<String, dynamic> getFinalFilterData() {
    final filtersMap = <String, dynamic>{};

    for (final filter in filters) {
      final name = filter.filterName ?? '';

      switch (filter.filterType) {
        case 'number':
          final range = rangeValues[name]?.value;
          if (range != null) {
            filtersMap[name] = {
              "type": "range",
              "filter_type": "number",
              "min": range.start,
              "max": range.end,
            };
          }
          break;

        case 'dropdown_multiple':
          final list = multiSelectValues[name]?.toList() ?? [];
          filtersMap[name] = {
            "type": "list",
            "filter_type": "dropdown_multiple",
            "list": list,
          };
          break;

        case 'dropdown':
          final selectedValue = selectedFilters[name]?.value;
          if (selectedValue != null && selectedValue.isNotEmpty == true) {
            filtersMap[name] = {
              "type": "list",
              "filter_type": "dropdown",
              "list": [selectedValue],
            };
          }
          break;

        default:
          final selected = selectedFilters[name]?.value ?? '';
          if (selected.isNotEmpty == true) {
            filtersMap[name] = {
              "type": "list",
              "filter_type": filter.filterType ?? 'dropdown',
              "list": [selected],
            };
          }
          break;
      }
    }

    print("✅ Final Filter Data (for API): $filtersMap");
    return filtersMap;
  }
}
