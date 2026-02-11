import 'dart:developer';
import 'dart:io';
import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/SignUpService/SignUpService.dart';
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
      final homeController = Get.find<CommonController>();
      // final merchantProfile = homeController.profileData.value.data?.merchantProfile;
      final merProfile = storage.bizMetrics;

      if (merProfile != null) {
        filePath.value = merProfile["image"] ?? "";
        businessNameController.text = merProfile["businessName"] ?? '';
        gstNumberController.text = storage.getNumber ?? '';
        businessEmailController.text = merProfile["businessEmail"] ?? '';
        businessWebsiteController.text = merProfile["businessWebsite"] ?? '';
        alternativeContactController.text =
            merProfile["alternateBusinessPhone"] ?? '';
        businessContactController.text = merProfile['businessPhone'] ?? '';
        yearsInBusinessController.text = merProfile['yearOfEstablish'] ?? '';
        //projectsCompletedController.text =
        //  merchantProfile.projectsCompleted?.toString() ?? '';

        /*  if (merchantProfile.businessHours?.isNotEmpty == true) {
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
        } */
      }
      final cont = Get.find<ProfileController>();

      if ((cont.businessModel.value.gstinNumber ?? "").isNotEmpty) {
        businessNameController.text =
            cont.businessModel.value.businessName ?? "";
        gstNumberController.text = cont.businessModel.value.gstinNumber ?? "";
        businessEmailController.text =
            cont.businessModel.value.businessEmail ?? "";
        businessWebsiteController.text = cont.businessModel.value.website ?? "";
        businessContactController.text =
            cont.businessModel.value.businessContactNumber ?? "";
        alternativeContactController.text =
            cont.businessModel.value.alternativeBusinessEmail ?? "";
        yearsInBusinessController.text = cont.businessModel.value.year ?? "";
      }
    } catch (e) {
      // ignore: avoid_print
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
      log(
        "AlternativeContactController : ${alternativeContactController.text}",
      );
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
    final pickedFile = await Get.find<ProfileController>().picker.pickImage(
      source: source,
    );
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(
      File(pickedFile.path),
    );
    Get.find<ProfileController>().selectedImage.value = File(
      compressedFile.path,
    );
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
    final website = businessWebsiteController.text;

    final bool isAvailable = await SignUpService().checkAvailability(
      website: website,
    );
    if (!isAvailable) {
      websiteError.value = "Website url is already connect with other business";
    } else {
      websiteError.value = "";
    }
  }

  final HomeService _homeService = Get.find<HomeService>();
  Future<void> updateMetrcis() async {
    try {
      print(basename(filePath.value));
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
      } else {
        SnackBars.errorSnackBar(content: 'Error in metrics update');
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    }
  }
}
