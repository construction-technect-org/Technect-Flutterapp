import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/controller/edit_profile_controller.dart';
import 'package:gap/gap.dart';

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
  EditProfileView({super.key});

  final formKey = GlobalKey<FormState>();

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
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.image.value.isEmpty) {
                      if (controller.selectedImage.value == null) {
                        SnackBars.errorSnackBar(
                          content: "Please upload business logo",
                        );
                        return;
                      }
                    }

                    controller.updateProfile();
                  }
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
                                  if (controller.selectedImage.value != null) {
                                    return ClipOval(
                                      child: Image.file(
                                        controller.selectedImage.value!,
                                        width: 78,
                                        height: 78,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }

                                  final imagePath = controller.image.value;
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
                          _buildBusinessDetailsStep(),
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

  /// Build Business Details Step
  Widget _buildBusinessDetailsStep() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            headerText: "Business Name",
            hintText: "Enter your business name",
            controller: controller.businessNameController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
              // NameInputFormatter(),
            ],
            validator: (value) =>
                validateName(value, fieldName: "business name"),
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            hintText: "Enter your website url",
            headerText: "Website",
            controller: controller.businessWebsiteController,
            keyboardType: TextInputType.text,
            validator: ValidationUtils.validateWebsiteUrl,
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            headerText: "Business Email",
            hintText: "adc12@business.com",
            controller: controller.businessEmailController,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationUtils.validateBusinessEmail,
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            hintText: "xxxxxxxxxxxxxx",
            headerText: "GSTIN Number",
            controller: controller.gstNumberController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
              UpperCaseTextFormatter(),
            ],
            validator: ValidationUtils.validateGSTINNumber,
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            hintText: "9292929929",
            headerText: "Business Contact Number",
            controller: controller.businessContactController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            validator: ValidationUtils.validateBusinessContactNumber,
          ),
        ],
      ),
    );
  }
}
