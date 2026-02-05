import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PointOfContactController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();
  final alternativeNumberController = TextEditingController();

  DashBoardController get dashboardController =>
      Get.find<DashBoardController>();
  final HomeService _homeService = Get.find<HomeService>();

  // Email validation state
  RxString emailError = "".obs;
  RxBool isEmailValidating = false.obs;
  RxString countryCode = "+91".obs;
  RxString numberError = "".obs;
  Rx<POC?>? pointOfContact = Rx<POC?>(null);
  @override
  void onInit() {
    super.onInit();
    pointOfContact?.value = storage.pocDetails;
    fNameController.text = pointOfContact?.value?.pocName ?? "";
    emailController.text = pointOfContact?.value?.pocEmail ?? "";
    designationController.text = pointOfContact?.value?.pocDesignation ?? "";
    numberController.text = pointOfContact?.value?.pocPhone ?? "";
    alternativeNumberController.text =
        pointOfContact?.value?.pocAlternatePhone ?? "";
  }

  RxBool isLoading = false.obs;
  Future<void> validateEmailAvailability(String email) async {
    final formatError = Validate.validateEmail(email);
    if (formatError != null) {
      emailError.value = "";
      isEmailValidating.value = false;
      return;
    }
    // isEmailValidating.value = true;
    // final apiError = await Validate.validateEmailAsync(email);
    // emailError.value = apiError ?? "";
    //isEmailValidating.value = false;
  }

  Future<void> validateNumberAvailability(String number) async {
    final formatError = ValidationUtils.validateBusinessContactNumber(number);
    if (formatError != null) {
      numberError.value = formatError;
      return;
    }
    /* final error = await Validate.validateMobileNumberAsync(
      number,
      countryCode: countryCode.value,
    );
    numberError.value = error ?? ""; */
  }

  Future<void> updatePointOfContact() async {
    isLoading.value = true;

    try {
      final response = await _homeService.updatePOCDetails(
        profileID: storage.merchantID,
        pocName: fNameController.text.trim(),
        pocDesignation: designationController.text.trim(),
        pocPhone: numberController.text.trim(),
        pocAlternatePhone: alternativeNumberController.text.trim(),
        pocEmail: emailController.text.trim(),
      );

      if (response) {
        SnackBars.successSnackBar(
          content: "Successfully updated Point of Contact",
        );
        pointOfContact?.value?.pocName = fNameController.text.trim();
        pointOfContact?.value?.pocDesignation = designationController.text
            .trim();
        pointOfContact?.value?.pocPhone = numberController.text.trim();
        pointOfContact?.value?.pocAlternatePhone = alternativeNumberController
            .text
            .trim();
        pointOfContact?.value?.pocEmail = emailController.text.trim();
        await storage.setPOC(pointOfContact?.value);
      } else {
        SnackBars.errorSnackBar(content: "Point of Contact updation Failed");
      }

      Get.back();
    } catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: "Point of Contact updation Failed");
      // ignore: avoid_print
    } finally {
      isLoading.value = false;
    }
  }
}
