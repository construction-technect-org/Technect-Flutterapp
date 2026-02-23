import 'dart:developer';
import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfileControllerr extends GetxController {
  final formKey = GlobalKey<FormState>();

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

  final isLoading = false.obs;
  RxString emailError = "".obs;
  RxString websiteError = "".obs;
  RxBool isEmailValidating = false.obs;
  RxBool isNumValidating = false.obs;
  RxString numberError = "".obs;

  RxString filePath = "".obs;
  RxString businessHours = "".obs;
  RxList<Map<String, dynamic>> businessHoursData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _populateExistingData();
  }

  void _populateExistingData() {
    try {
      final cont = Get.find<ProfileController>();
      final bm = cont.businessModel.value;

      filePath.value = bm.image ?? "";
      businessNameController.text = bm.businessName ?? "";
      gstNumberController.text = bm.gstinNumber ?? storage.getNumber;
      businessEmailController.text = bm.businessEmail ?? "";
      businessWebsiteController.text = bm.website ?? "";
      businessContactController.text = bm.businessContactNumber ?? "";
      alternativeContactController.text = bm.alternativeBusinessEmail ?? "";
      yearsInBusinessController.text = bm.year ?? "";
    } catch (e) {
      log("Error populating data: $e");
    }
  }

  void nextStep() {
    if (Get.find<ProfileController>().selectedImage.value != null ||
        Get.find<ProfileController>().image.value.isNotEmpty) {
      Get.find<ProfileController>().businessModel.value = BusinessModel(
        businessContactNumber: businessContactController.text.trim(),
        businessEmail: businessEmailController.text.trim(),
        businessName: businessNameController.text.trim(),
        year: yearsInBusinessController.text.trim(),
        alternativeBusinessEmail: alternativeContactController.text.trim(),
        gstinNumber: gstNumberController.text.trim(),
        website: businessWebsiteController.text.trim(),
        address: addressContoller.text.trim(),
        image: Get.find<ProfileController>().selectedImage.value != null
            ? Get.find<ProfileController>().selectedImage.value?.path
            : Get.find<ProfileController>().image.value,
      );
      log("AlternativeContactController : ${alternativeContactController.text}");
      Get.find<ProfileController>().businessModel.refresh();
      Get.back();
    } else {
      SnackBars.errorSnackBar(content: "Please add the Business Logo");
    }
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
              title: Text("Camera", style: MyTexts.medium15.copyWith(color: MyColors.gray2E)),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: MyColors.gray2E),
              title: Text("Gallery", style: MyTexts.medium15.copyWith(color: MyColors.gray2E)),
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
    final compressedFile = await CommonConstant().compressImage(File(pickedFile.path));
    Get.find<ProfileController>().selectedImage.value = File(compressedFile.path);
    filePath.value = compressedFile.path;
  }

  Future<void> validateEmailAvailability() async {
    final email = businessEmailController.text;

    isEmailValidating.value = true;
    emailError.value = await Validate.validateEmailAsync(email) ?? "";
    isEmailValidating.value = false;
  }

  Future<void> validateNumAvailability() async {
    final num = businessContactController.text;

    isNumValidating.value = true;
    numberError.value = await Validate.validateMobileNumberAsync(num) ?? "";
    isNumValidating.value = false;
  }

  Future<void> validateUrlAvailability() async {
    // final website = businessWebsiteController.text;

    // final bool isAvailable = await SignUpService().checkAvailability(website: website);
    // if (!isAvailable) {
    //   websiteError.value = "Website url is already connect with other business";
    // } else {
    //   websiteError.value = "";
    // }
  }

  final HomeService _homeService = Get.find<HomeService>();
  Future<String?> updateMetrcis() async {
    try {
      log(basename(filePath.value));
      final response = await _homeService.updateBizMetrics(
        profileID: storage.merchantID,
        bizName: businessNameController.text.trim(),
        bizType: "Manufacturer",
        bizEmail: businessEmailController.text.trim(),
        bizPhone: businessContactController.text.trim(),
        alternateBizPhone: alternativeContactController.text.trim(),
        businessWebsite: businessWebsiteController.text.trim(),
        yearOfEstablish: yearsInBusinessController.text.trim(),
        fileName: filePath.value,
      );
      if (response) {
        SnackBars.successSnackBar(content: 'Metrics update successful');
        // Refresh profile data so the summary screen reflects the new values
        await Get.find<CommonController>().fetchProfileDataM();
        Get.back();
      } else {
        SnackBars.errorSnackBar(content: 'Error in metrics update');
        return "Error in metrics update";
      }
    } catch (e) {
      log( 'Error fetching profile: $e');
    }
    return null;
  }
}
