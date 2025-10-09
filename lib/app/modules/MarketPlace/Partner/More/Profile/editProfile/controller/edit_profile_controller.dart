import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final businessNameController = TextEditingController();
  final businessWebsiteController = TextEditingController();
  final gstNumberController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessContactController = TextEditingController();
  final yearsInBusinessController = TextEditingController();
  final projectsCompletedController = TextEditingController();
  final addressContoller = TextEditingController();

  final scrollController = ScrollController();
  final titleKey = GlobalKey();

  final isLoading = false.obs;

  RxString businessHours = "".obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    _populateExistingData();
  }

  void _populateExistingData() {
    try {
      final homeController = Get.find<HomeController>();
      final merchantProfile = homeController.profileData.value.data?.merchantProfile;

      if (merchantProfile != null) {
        // Populate text fields
        businessNameController.text = merchantProfile.businessName ?? '';
        gstNumberController.text = merchantProfile.gstinNumber ?? '';
        businessEmailController.text = merchantProfile.businessEmail ?? '';
        businessWebsiteController.text = merchantProfile.website ?? '';
        businessContactController.text = merchantProfile.businessContactNumber ?? '';
        yearsInBusinessController.text =
            merchantProfile.yearsInBusiness?.toString() ?? '';
        projectsCompletedController.text =
            merchantProfile.projectsCompleted?.toString() ?? '';

        // Populate business hours
        if (merchantProfile.businessHours?.isNotEmpty == true) {
          final hoursList = merchantProfile.businessHours!
              .map(
                (hour) => {
                  'day_of_week': hour.dayOfWeek,
                  'day_name': hour.dayName,
                  'is_open': hour.isOpen,
                  'open_time': hour.openTime,
                  'close_time': hour.closeTime,
                },
              )
              .toList();
          businessHoursData.value = hoursList;
        }
      }

      if ((Get.find<ProfileController>().businessModel.value.businessEmail ?? "")
          .isNotEmpty) {
        businessNameController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessName
            .toString();
        gstNumberController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .gstinNumber
            .toString();
        businessEmailController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessEmail
            .toString();
        businessWebsiteController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .website
            .toString();
        businessContactController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessContactNumber
            .toString();
      }
    } catch (e) {
      Get.printError(info: 'Error populating existing data: $e');
    }
  }

  void addBusinessHours(String hours) {
    businessHours.value = hours;
  }

  void handleBusinessHoursData(List<Map<String, dynamic>> data) {
    businessHoursData.value = data;
  }

  void scrollToTitle() {
    final context = titleKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextStep() {
    Get.find<ProfileController>().businessModel.value = BusinessModel(
      businessContactNumber: businessContactController.text,
      businessEmail: businessEmailController.text,
      businessName: businessNameController.text,
      gstinNumber: gstNumberController.text,
      website: businessWebsiteController.text,
      address: addressContoller.text,
    );
    Get.find<ProfileController>().businessModel.refresh();
    Get.back();
  }

  void updateProfile() {
    if (_validateBusinessDetails()) {
      nextStep();
    }
  }

  bool _validateBusinessDetails() {
    final businessNameError = ValidationUtils.validateName(
      businessNameController.text,
      "business name",
    );
    if (businessNameError != null) {
      SnackBars.errorSnackBar(content: businessNameError);
      return false;
    }
    final websiteError = ValidationUtils.validateWebsiteUrl(
      businessWebsiteController.text,
    );
    if (websiteError != null) {
      SnackBars.errorSnackBar(content: websiteError);
      return false;
    }
    final emailError = ValidationUtils.validateBusinessEmail(
      businessEmailController.text,
    );
    if (emailError != null) {
      SnackBars.errorSnackBar(content: emailError);
      return false;
    }

    final gstError = ValidationUtils.validateGSTINNumber(gstNumberController.text);
    if (gstError != null) {
      SnackBars.errorSnackBar(content: gstError);
      return false;
    }
    final contactError = ValidationUtils.validateBusinessContactNumber(
      businessContactController.text,
    );
    if (contactError != null) {
      SnackBars.errorSnackBar(content: contactError);
      return false;
    }
    return true;
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToTitle();
    });
  }
}
