import 'package:construction_technect/app/core/utils/imports.dart';

class ConnectorProductDetailsController extends GetxController {
  /// Holds technical filter specifications
  final filterValues = <String, String>{}.obs;

  /// Example: call this when API data arrives
  void setFilterValues(Map<String, String> values) {
    filterValues.assignAll(values);
  }

  /// Clear the specifications
  void clearFilterValues() {
    filterValues.clear();
  }
}
