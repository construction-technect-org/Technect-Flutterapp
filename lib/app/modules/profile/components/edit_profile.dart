import 'dart:io';

import 'package:construction_technect/app/core/utils/CommonConstant.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final controller = Get.find<HomeController>();
  final eController = Get.put<EditProfileController>(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: eController.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          appBar: CommonAppBar(
            isCenter: false,
            title: const Text("Edit Profile"),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Obx(() {
                  print(controller.profileData.value.data?.user?.image);
                  if (eController.selectedImage.value != null) {
                    return ClipOval(
                      child: Image.file(
                        eController.selectedImage.value!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  final imagePath = controller.profileData.value.data?.user?.image;
                  final imageUrl = imagePath != null && imagePath.isNotEmpty
                      ? "${APIConstants.bucketUrl}$imagePath"
                      : null;

                  if (imagePath == null) {
                    return const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.grey,
                    );
                  }
                  return ClipOval(
                    child: getImageView(finalUrl: imageUrl??"",height: 100,width: 100,fit: BoxFit.cover)
                  );
                }),
                const Gap(8),
                ElevatedButton.icon(
                  onPressed: () => eController.pickImageBottomSheet(context),
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text(
                    "Change Photo",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary, // or Colors.blue
                  ),
                ),
                Gap(2.h),
                CommonTextField(
                  hintText: "Enter your first name",
                  headerText: "First Name",
                  controller: eController.fNameController,
                ),
                Gap(2.h),
                CommonTextField(
                  hintText: "Enter your last name",
                  headerText: "Last Name",
                  controller: eController.lNameController,
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: RoundedButton(
              buttonName: "Update",
              onTap: () {
                if (eController.fNameController.text.isEmpty) {
                  SnackBars.errorSnackBar(content: "Please fill first name");
                  return;
                }
                if (eController.lNameController.text.isEmpty) {
                  SnackBars.errorSnackBar(content: "Please fill last name");
                  return;
                }
                eController.updateProfile();
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
  final pController = Get.find<ProfileController>();
  final hController = Get.find<HomeController>();

  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    lNameController.text = pController.userData?.lastName ?? "";
    fNameController.text = pController.userData?.firstName ?? "";
    emailController.text = pController.userData?.email ?? "";
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
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
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
    final file = File(pickedFile.path);
    final compressedFile = await CommonConstant().compressImage(File(pickedFile.path));
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

      // Handle success
      await hController.fetchProfileData();
      Get.back();
      SnackBars.successSnackBar(content: "Profile updated successfully!");
    } catch (e, st) {
      SnackBars.errorSnackBar(content: "Update failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
