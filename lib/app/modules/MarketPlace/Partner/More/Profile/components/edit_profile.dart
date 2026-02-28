import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  final EditProfileController eController = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: eController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.moreIBg), fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Edit profile information'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: eController.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(16),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  GestureDetector(
                                    onTap: () => eController.pickImageBottomSheet(context),
                                    child: Obx(() {
                                      if (eController.selectedImage.value != null) {
                                        return ClipOval(
                                          child: Image.file(
                                            eController.selectedImage.value!,
                                            width: 78,
                                            height: 78,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }

                                      final imagePath = eController.image.value;
                                      if (imagePath.isEmpty) {
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundColor: MyColors.grayEA,
                                          child: SvgPicture.asset(Asset.add, height: 24, width: 24),
                                        );
                                      }

                                      return ClipOval(
                                        child: getImageView(
                                          finalUrl: imagePath.startsWith('http')
                                              ? imagePath
                                              : "${APIConstants.bucketUrl}$imagePath",
                                          height: 78,
                                          width: 78,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => eController.pickImageBottomSheet(context),
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SvgPicture.asset(
                                            Asset.edit,
                                            height: 12,
                                            width: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(3.h),
                              CommonTextField(
                                hintText: "Enter your first name",
                                headerText: "First Name",
                                controller: eController.fNameController,
                                autofillHints: const [AutofillHints.givenName],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  NameInputFormatter(),
                                ],
                                validator: (value) => validateName(value, fieldName: "first name"),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "Enter your last name",
                                headerText: "Last Name",
                                controller: eController.lNameController,
                                autofillHints: const [AutofillHints.familyName],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  NameInputFormatter(),
                                ],
                                validator: (value) => validateName(value, fieldName: "last name"),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                hintText: "Enter your email address",
                                headerText: "Email",
                                controller: eController.emailController,
                                validator: (value) => Validate.validateEmail(value),
                              ),
                              Gap(2.h),
                              Text(
                                "Designation",
                                style: MyTexts.medium14.copyWith(color: MyColors.grayA5),
                              ),
                              const Gap(8),
                              Obx(() {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: MyColors.grayEA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: eController.designation.value,
                                          isExpanded: true,
                                          items: eController.designations
                                              .map(
                                                (e) => DropdownMenuItem(value: e, child: Text(e)),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              eController.designation.value = value;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    if (eController.designation.value == "Others...") ...[
                                      const Gap(16),
                                      CommonTextField(
                                        hintText: "Enter your designation",
                                        headerText: "Custom Designation",
                                        controller: eController.othersController,
                                        validator: (value) {
                                          if (eController.designation.value == "Others..." &&
                                              (value == null || value.isEmpty)) {
                                            return "Please enter your designation";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ],
                                );
                              }),
                              const Gap(24),
                              RoundedButton(
                                buttonName: "Update",
                                onTap: () {
                                  if (eController.formKey.currentState!.validate()) {
                                    eController.updateProfile();
                                  }
                                },
                              ),
                              const Gap(40), // Extra space to scroll above keyboard
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final othersController = TextEditingController();
  RxString image = "".obs;

  final List<String> designations = [
    "Manufacturer",
    "Architect",
    "Designer",
    "Company",
    "Contractors",
    "Civil engineer",
    "House owner",
    "Others",
  ];

  RxString designation = "Manufacturer".obs;

  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final pController = Get.find<ProfileController>();

    lNameController.text = pController.userLastName;
    fNameController.text = pController.userFirstName;
    emailController.text = pController.userEmail;
    image.value = pController.userImage;

    final existingDesignation = pController.userDesignation;
    if (existingDesignation.isNotEmpty) {
      if (designations.contains(existingDesignation)) {
        designation.value = existingDesignation;
      } else {
        designation.value = "Others...";
        othersController.text = existingDesignation;
      }
    } else {
      designation.value = "Manufacturer";
    }
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
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(File(pickedFile.path));
    selectedImage.value = File(compressedFile.path);
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      final actualDesignation = designation.value == "Others..."
          ? othersController.text
          : designation.value;

      // Update selected value in ProfileController as well
      Get.find<ProfileController>().selectedValue.value = actualDesignation;

      // Fields to send
      final Map<String, dynamic> fields = {
        'first_name': fNameController.text,
        'last_name': lNameController.text,
        'email': emailController.text,
        'designation': actualDesignation,
      };

      Map<String, String>? files;
      if (selectedImage.value != null) {
        files = {'profile_image': selectedImage.value!.path};
      }
      final _ = await apiManager.putMultipart(
        url: APIConstants.updateProfile,
        fields: fields,
        files: files,
      );
      if (myPref.getRole() == "partner") {
        await Get.find<CommonController>().fetchProfileData();
      } else {
        await Get.find<CommonController>().fetchProfileDataM();
      }

      Get.back();
      SnackBars.successSnackBar(content: "Profile updated successfully!");
    } catch (e) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
