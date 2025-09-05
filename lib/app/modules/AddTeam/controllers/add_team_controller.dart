// import 'package:construction_technect/app/core/utils/imports.dart';

// class AddTeamController extends GetxController {
//   final fullNameController = TextEditingController();
//   final emialIdController = TextEditingController();
//   // ignore: non_constant_identifier_names
//   final PhonenumberController = TextEditingController();
//   final addressController = TextEditingController();
//   final stateController = TextEditingController();
//   final cityController = TextEditingController();

//   final pinCodeController = TextEditingController();
//   final aadharCardController = TextEditingController();
//   final panCardController = TextEditingController();

//   RxList<String> categories = <String>["PanCard", "AadharCard", "DrivingLicen"].obs;

//   // Nullable selections
//   Rxn<String> selectedCategory = Rxn<String>();
//   Rxn<String> selectedSubCategory = Rxn<String>();
//   Rxn<String> selectedUom = Rxn<String>();

//   RxBool showExtraFields = false.obs;
//   RxString pickedFileName = "Img45.jpg".obs;

//   @override
//   void onClose() {
//     fullNameController.dispose();
//     emialIdController.dispose();
//     PhonenumberController.dispose();
//     addressController.dispose();
//     stateController.dispose();
//     super.onClose();
//   }

//   void submitProduct() {
//     showExtraFields.value = true;
//   }

//   Future<void> pickFile() async {
//     // TODO: Add File Picker logic
//     pickedFileName.value = "MyNewFile.png";
//   }

//   void loadSubCategories(String? category) {
//     if (category == null) {
//       selectedSubCategory.value = null;
//       return;
//     }

//     selectedSubCategory.value = null; // reset on category change
//   }
// }



import 'dart:io';
import 'package:construction_technect/app/modules/AddTeam/service/AddTeamService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class AddTeamController extends GetxController {
  // ✅ Text Controllers
  final fullNameController = TextEditingController();
  final emialIdController = TextEditingController();
  final PhonenumberController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final aadharCardController = TextEditingController();
  final panCardController = TextEditingController();

  // ✅ Dropdowns
  final categories = ["Admin", "Manager", "Staff"].obs; // Example
Rxn<String> selectedCategory = Rxn<String>();
RxBool isActive = true.obs; // default active

  // ✅ Files
  RxString pickedFileName = "".obs;
  File? profilePhoto;
  File? aadharCardPhoto;
  File? panCardPhoto;

  // ✅ Loading
  RxBool isLoading = false.obs;

  Future<void> pickFile({required String type}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final File file = File(result.files.single.path!);
      pickedFileName.value = result.files.single.name;

      if (type == "profile") {
        profilePhoto = file;
      } else if (type == "aadhar") {
        aadharCardPhoto = file;
      } else if (type == "pan") {
        panCardPhoto = file;
      }
    }
  }

  Future<void> createTeamMember() async {
    try {
      isLoading.value = true;

      final int roleId = categories.indexOf(selectedCategory.value) + 1; // Example mapping
      final response = await AddTeamService.createTeamMember(
        fullName: fullNameController.text.trim(),
        emailId: emialIdController.text.trim(),
        phoneNumber: PhonenumberController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        city: cityController.text.trim(),
        pincode: pinCodeController.text.trim(),
        aadharCardNumber: aadharCardController.text.trim(),
        panCardNumber: panCardController.text.trim(),
        teamRoleId: roleId,
        isActive: true,
        profilePhoto: profilePhoto,
        aadharCardPhoto: aadharCardPhoto,
        panCardPhoto: panCardPhoto,
      );

      Get.snackbar("Success", response.message, snackPosition: SnackPosition.TOP);
      Get.back(result: response.data);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP, backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
