import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/controller/edit_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/views/widget/business_details_step_widget.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: MyColors.white,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedButton(
                buttonName: 'Update',
                onTap: () async {
                  if (!controller.formKey.currentState!.validate()) return;

                  await controller.validateEmailAvailability();
                  if (controller.emailError.value != '') {
                    return;
                  }
                  controller.updateProfile();
                },
              ).paddingOnly(bottom: 30, right: 20, left: 20),
            ],
          ),
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
                    title: const Text("Edit Business Metrics"),
                    isCenter: false,
                    leading: GestureDetector(
                      onTap: () => Get.back(),
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
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(16),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    controller.pickImageBottomSheet(context),
                                child: Obx(() {
                                  if (Get.find<ProfileController>()
                                          .selectedImage
                                          .value !=
                                      null) {
                                    return ClipOval(
                                      child: Image.file(
                                        Get.find<ProfileController>()
                                            .selectedImage
                                            .value!,
                                        width: 78,
                                        height: 78,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  final imagePath =
                                      Get.find<ProfileController>().image.value;
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
                                  onTap: () =>
                                      controller.pickImageBottomSheet(context),
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

                          BusinessDetailsStep(
                            controller: controller,
                            formKey: controller.formKey,
                          ),
                          SizedBox(height: 4.h),
                        ],
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
