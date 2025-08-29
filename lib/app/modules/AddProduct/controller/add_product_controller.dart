// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  // Existing
  final productNameController = TextEditingController();
  final uomController = TextEditingController();
  final priceController = TextEditingController();
  final gstController = TextEditingController();
  final gstPriceController = TextEditingController();
  final termsController = TextEditingController();

  // New controllers
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


  @override
  void onClose() {
    productNameController.dispose();
    priceController.dispose();
    gstController.dispose();
    gstPriceController.dispose();
    termsController.dispose();
    super.onClose();
  }

  // Control stepper/slider state
  RxBool showExtraFields = false.obs;
    RxString selectedCategory = "Fine Aggregate".obs;
  RxString selectedSubCategory = "Sand".obs;
  Rxn<String> selectedUom = Rxn<String>();

  void submitProduct() {
    showExtraFields.value = true; // show new section instead of navigation
  }

  RxString pickedFileName = "Img45.jpg".obs;

    Future<void> pickFile() async {
    // TODO: Add File Picker logic
    pickedFileName.value = "MyNewFile.png";
  }


  void loadSubCategories(String category) {
  if (category == "Electronics") {
    subCategories.value = ["Wires", "Switches", "Bulbs"];
  } else if (category == "Construction") {
    subCategories.value = ["Cement", "Bricks", "Steel"];
  } else {
    subCategories.value = ["Chairs", "Tables", "Beds"];
  }
  selectedSubCategory.value = "";
}

}

