import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final designationController = TextEditingController();

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final designationFocus = FocusNode();

  final isButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();

    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
    designationController.addListener(_validateForm);
  }

  void _validateForm() {
    isButtonEnabled.value =
        firstNameController.text.trim().isNotEmpty &&
            lastNameController.text.trim().isNotEmpty &&
            designationController.text.trim().isNotEmpty;
  }

  Future<void> onContinue() async {
    if (formKey.currentState!.validate()) {

      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
      }

      Get.bottomSheet(
        const SignUpDetailsView(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      );
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    designationController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    designationFocus.dispose();
    super.onClose();
  }
}