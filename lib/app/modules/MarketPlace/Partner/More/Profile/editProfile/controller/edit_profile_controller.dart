import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final businessNameController = TextEditingController();
  final businessWebsiteController = TextEditingController();
  final gstNumberController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessContactController = TextEditingController();
  final alternativeContactController = TextEditingController();
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
        Get.find<ProfileController>().image.value = merchantProfile.merchantLogo ?? "";
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

      if ((Get.find<ProfileController>().businessModel.value.gstinNumber ?? "")
          .isNotEmpty) {
        businessNameController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessName??"";
        gstNumberController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .gstinNumber
            ??"";
        businessEmailController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessEmail
            ??"";
        businessWebsiteController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .website
            ??"";
        businessContactController.text = Get.find<ProfileController>()
            .businessModel
            .value
            .businessContactNumber
            ??"";
      }
    } catch (e) {
      Get.printError(info: 'Error populating existing data: $e');
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
      image: Get.find<ProfileController>().selectedImage.value!=null? Get.find<ProfileController>().selectedImage.value?.path: Get.find<ProfileController>().image.value,
    );
    Get.find<ProfileController>().businessModel.refresh();
    Get.back();
  }

  void updateProfile() {
    nextStep();
  }


  void pickImageBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: MyColors.gray2E),
              title: Text(
                "Camera",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: MyColors.gray2E),
              title: Text(
                "Gallery",
                style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
              ),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await Get.find<ProfileController>().picker.pickImage(source: source);
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(
      File(pickedFile.path),
    );
    Get.find<ProfileController>().selectedImage.value = File(compressedFile.path);
  }

}
