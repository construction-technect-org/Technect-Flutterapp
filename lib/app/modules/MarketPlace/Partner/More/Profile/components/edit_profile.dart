import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final eController = Get.put<EditProfileController>(EditProfileController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: eController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Asset.moreIBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Edit profile information'),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(16),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  GestureDetector(
                                    onTap: () => eController
                                        .pickImageBottomSheet(context),
                                    child: Obx(() {
                                      if (eController.selectedImage.value !=
                                          null) {
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
                                      final imageUrl = imagePath.isNotEmpty
                                          ? "${APIConstants.bucketUrl}$imagePath"
                                          : null;
                                      if (imageUrl == null) {
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundColor: MyColors.grayEA,
                                          child: SvgPicture.asset(
                                            Asset.add,
                                            height: 24,
                                            width: 24,
                                          ),
                                        );
                                      }

                                      return ClipOval(
                                        child: getImageView(
                                          finalUrl: imageUrl,
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
                                      onTap: () => eController
                                          .pickImageBottomSheet(context),
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
                                validator: (value) => validateName(
                                  value,
                                  fieldName: "first name",
                                ),
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
                                validator: (value) =>
                                    validateName(value, fieldName: "last name"),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                readOnly: true,
                                hintText: "Enter your email address",
                                headerText: "Email",
                                controller: eController.emailController,
                              ),
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: "Update",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  eController.updateProfile();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileController extends GetxController {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  RxString image = "".obs;

  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    if (myPref.getRole() == "partner") {
      final pController = Get.find<ProfileController>();
      lNameController.text = pController.userData?.lastName ?? "";
      fNameController.text = pController.userData?.firstName ?? "";
      emailController.text = pController.userData?.email ?? "";
      image.value = pController.userData?.image ?? "";
    } else {
      final pController = Get.find<HomeController>();
      lNameController.text =
          pController.profileData.value.data?.user?.lastName ?? "";
      fNameController.text =
          pController.profileData.value.data?.user?.firstName ?? "";
      emailController.text =
          pController.profileData.value.data?.user?.email ?? "";
      image.value = pController.profileData.value.data?.user?.image ?? "";
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
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    final compressedFile = await CommonConstant().compressImage(
      File(pickedFile.path),
    );
    selectedImage.value = File(compressedFile.path);
  }

  ApiManager apiManager = ApiManager();
  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      // Fields to send
      final Map<String, dynamic> fields = {
        'first_name': fNameController.text,
        'last_name': lNameController.text,
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
      await Get.find<HomeController>().fetchProfileData();

      Get.back();
      SnackBars.successSnackBar(content: "Profile updated successfully!");
    } catch (e) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
