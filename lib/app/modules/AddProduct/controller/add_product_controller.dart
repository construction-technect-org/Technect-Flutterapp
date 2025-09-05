import 'package:construction_technect/app/core/utils/imports.dart';

class AddProductController extends GetxController {
  final productNameController = TextEditingController();
  final uomController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();

  final packageSizeController = TextEditingController();
  final shapeController = TextEditingController();
  final textureController = TextEditingController();
  final colorController = TextEditingController();
  final packageTypeController = TextEditingController();
  final grainSizeController = TextEditingController();
  final finenessModulusController = TextEditingController();
  final siltContentController = TextEditingController();
  final clayDustContentController = TextEditingController();
  final moistureContentController = TextEditingController();
  final specificGravityController = TextEditingController();
  final bulkDensityController = TextEditingController();
  final waterAbsorptionController = TextEditingController();
  final zoneController = TextEditingController();

  RxList<String> categories = <String>["Electronics", "Construction", "Furniture"].obs;
  RxList<String> subCategories = <String>[].obs;
  RxList<String> uomList = <String>["Kg", "Liters", "Pieces"].obs;
  RxList<String> mianCategory = <String>["!", "2", "3"].obs;

  // Nullable selections
  Rxn<String> selectedCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();
  Rxn<String> selectedmianCategory = Rxn<String>();

  RxBool showExtraFields = false.obs;
  RxString pickedFileName = "Img45.jpg".obs;

  @override
  void onClose() {
    productNameController.dispose();
    priceController.dispose();
    gstController.dispose();
    gstPriceController.dispose();
    termsController.dispose();
    super.onClose();
  }

  void submitProduct() {
    showExtraFields.value = true;
  }

  Future<void> pickFile() async {
    // TODO: Add File Picker logic
    pickedFileName.value = "MyNewFile.png";
  }

  void loadSubCategories(String? category) {
    if (category == null) {
      subCategories.clear();
      selectedSubCategory.value = null;
      return;
    }

    if (category == "Electronics") {
      subCategories.value = ["Wires", "Switches", "Bulbs"];
    } else if (category == "Construction") {
      subCategories.value = ["Cement", "Bricks", "Steel"];
    } else {
      subCategories.value = ["Chairs", "Tables", "Beds"];
    }
    selectedSubCategory.value = null; // reset on category change
  }

  RxBool isEnabled = false.obs;

  // If editing, you can set it from arguments
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null) {
      // For edit case → prefill
      isEnabled.value = args["isEnabled"] ?? false;
    }
  }
}
