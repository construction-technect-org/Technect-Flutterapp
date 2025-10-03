import 'package:construction_technect/app/core/utils/imports.dart';

class ConnectorFilterController extends GetxController {
  /// Search text field
  final TextEditingController searchController = TextEditingController();

  /// Selected values
  RxnString selectedBrand = RxnString('Jeevan Brand');
  RxnString selectedUOM = RxnString();
  RxnString selectedShape = RxnString();
  RxnString selectedTexture = RxnString();
  RxnString selectedSize = RxnString();
  RxnString selectedWeight = RxnString();

  /// Options
  final List<String> brands = ['Tejas Brand', 'Ambuja Brand', 'Jeevan Brand'];
  final List<String> uoms = ['Kg', 'Ton', 'Bag'];
  final List<String> shapes = ['Round', 'Square', 'Rectangle'];
  final List<String> textures = ['Smooth', 'Rough', 'Matte'];
  final List<String> sizes = ['Small', 'Medium', 'Large'];
  final List<String> weights = ['Light', 'Medium', 'Heavy'];

  /// Track which section is currently expanded
  RxString expandedSection = ''.obs; // empty means none expanded

  /// Reset filters
  void clear() {
    searchController.clear();
    selectedBrand.value = null;
    selectedUOM.value = null;
    selectedShape.value = null;
    selectedTexture.value = null;
    selectedSize.value = null;
    selectedWeight.value = null;
    expandedSection.value = '';
  }

  /// Apply filters
  void apply(BuildContext context) {
    final filters = {
      'search': searchController.text,
      'brand': selectedBrand.value,
      'uom': selectedUOM.value,
      'shape': selectedShape.value,
      'texture': selectedTexture.value,
      'size': selectedSize.value,
      'weight': selectedWeight.value,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Applied: $filters')),
    );

    // Or use: Get.back(result: filters);
  }
}
