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
      isLoad.value = true;

      final selectedProductId =
          Get.find<ConnectorSelectedProductController>().selectedProductId.value ?? "";

      await Get.find<ConnectorSelectedProductController>()
          .getFilter(selectedProductId);

      final otherFilters = Get.find<ConnectorSelectedProductController>().filters;

      filters.assignAll(
        otherFilters.map(
              (f) => ConnectorFilterModel(
            filterName: f.filterLabel,
            filterType: f.filterType,
            min: double.tryParse(f.minValue ?? '0'),
            max: double.tryParse(f.maxValue ?? '100'),
            options: f.dropdownList,
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
        rangeValues[filter.filterName ?? ''] =
            RangeValues(filter.min ?? 0, filter.max ?? 0).obs;
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
    final data = <String, dynamic>{};

    for (final filter in filters) {
      final name = filter.filterName ?? '';

      if (filter.filterType == 'number') {
        final range = rangeValues[name]?.value;
        if (range != null) {
          data[name] = {'min': range.start, 'max': range.end};
        }
      } else if (filter.filterType == 'dropdown_multiple') {
        data[name] = multiSelectValues[name]?.toList() ?? [];
      } else if (filter.filterType == 'dropdown') {
        data[name] = selectedFilters[name]?.value ?? '';
      } else {
        data[name] = selectedFilters[name]?.value ?? '';
      }
    }

    print("✅ Final Filter Data: $data");
    return data;
  }
}
