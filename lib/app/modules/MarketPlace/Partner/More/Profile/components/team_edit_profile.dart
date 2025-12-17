import 'dart:io';
import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:image_picker/image_picker.dart';

class TeamEditProfile extends StatelessWidget {
  final TeamEditProfileController eController = Get.put(TeamEditProfileController());

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
                                      final imageUrl = imagePath.isNotEmpty
                                          ? "${APIConstants.bucketUrl}$imagePath"
                                          : null;
                                      if (imageUrl == null) {
                                        return CircleAvatar(
                                          radius: 50,
                                          backgroundColor: MyColors.grayEA,
                                          child: SvgPicture.asset(Asset.add, height: 24, width: 24),
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
                                readOnly: true,
                                hintText: "Enter your email address",
                                headerText: "Email",
                                controller: eController.emailController,
                                validator: (value) => Validate.validateEmail(value),
                              ),
                              Gap(2.h),
                              CommonTextField(
                                readOnly: true,
                                hintText: "Enter your mobile number",
                                headerText: "Mobile Number",
                                controller: eController.mobileController,
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
                if (eController.formKey.currentState!.validate()) {
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

class TeamEditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  RxString image = "".obs;

  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    lNameController.text =
        Get.find<CommonController>().profileData.value.data?.teamMember?.lastName ?? "";
    fNameController.text =
        Get.find<CommonController>().profileData.value.data?.teamMember?.firstName ?? "";
    emailController.text =
        Get.find<CommonController>().profileData.value.data?.teamMember?.email ?? "";
    mobileController.text =
        Get.find<CommonController>().profileData.value.data?.teamMember?.mobileNumber ?? "";
    image.value = Get.find<CommonController>().profileData.value.data?.teamMember?.profilePhoto ?? "";
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
      final Map<String, dynamic> fields = {
        'firstName': fNameController.text,
        'lastName': lNameController.text,
      };

      Map<String, String>? files;
      if (selectedImage.value != null) {
        files = {'profile_photo': selectedImage.value!.path};
      }
      final _ = await apiManager.putMultipart(
        url: APIConstants.teamProfile,
        fields: fields,
        files: files,
      );
      await Get.find<CommonController>().fetchProfileData();

      Get.back();
      SnackBars.successSnackBar(content: "Profile updated successfully!");
    } catch (e) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
