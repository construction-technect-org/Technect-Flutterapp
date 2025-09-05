import 'package:construction_technect/app/core/utils/imports.dart';

class AddTeamController extends GetxController {
  final fullNameController = TextEditingController();
  final emialIdController = TextEditingController();
  // ignore: non_constant_identifier_names
  final PhonenumberController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final pinCodeController = TextEditingController();
  final aadharCardController = TextEditingController();
  final panCardController = TextEditingController();

  RxList<String> categories = <String>["PanCard", "AadharCard", "DrivingLicen"].obs;

  // Nullable selections
  Rxn<String> selectedCategory = Rxn<String>();
  Rxn<String> selectedSubCategory = Rxn<String>();
  Rxn<String> selectedUom = Rxn<String>();

  RxBool showExtraFields = false.obs;
  RxString pickedFileName = "Img45.jpg".obs;

  @override
  void onClose() {
    fullNameController.dispose();
    emialIdController.dispose();
    PhonenumberController.dispose();
    addressController.dispose();
    stateController.dispose();
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
      selectedSubCategory.value = null;
      return;
    }

    selectedSubCategory.value = null; // reset on category change
  }
}
