import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/controller/edit_profile_controller.dart';
import 'package:flutter/cupertino.dart';
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
                onTap: () async {
                  await controller.validateEmailAvailability();
                  if (formKey.currentState!.validate() &&
                      controller.emailError.value == '') {
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
                          _buildBusinessDetailsStep(context),
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
  Widget _buildBusinessDetailsStep(context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            headerText: "Company Name",
            hintText: "Enter your company name",
            controller: controller.businessNameController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
              // NameInputFormatter(),
            ],
            validator: (value) =>
                Validate().validateName(value, fieldName: "company name"),
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            hintText: "Enter your website url",
            headerText: "Website",
            controller: controller.businessWebsiteController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: ValidationUtils.validateWebsiteUrl,
          ),
          SizedBox(height: 2.h),
          Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                controller.validateEmailAvailability();
              }
            },
            child: CommonTextField(
              headerText: "Business Email",
              hintText: "adc12@business.com",
              controller: controller.businessEmailController,
              keyboardType: TextInputType.emailAddress,
              // validator: ValidationUtils.validateBusinessEmail,
            ),
          ),
          Obx(() {
            if (controller.emailError.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  controller.emailError.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
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
          Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                controller.validateEmailAvailability();
              }
            },
            child: CommonTextField(
              hintText: "9292929929",
              headerText: "Business Contact Number",
              controller: controller.businessContactController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: ValidationUtils.validateIndianMobileNumber,
            ),
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            hintText: "9292929929",
            headerText: "Alternative Business Contact Number (Optional)",
            controller: controller.alternativeContactController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          SizedBox(height: 2.h),
          CommonTextField(
            onTap: () async {
              FocusScope.of(context).unfocus();

              final int currentYear = DateTime.now().year;
              int selectedYear = currentYear;

              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: 300,
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        // Header with Done button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Select Year of Establishment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.yearsInBusinessController.text =
                                    selectedYear.toString();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        const Divider(height: 1),
                        const Gap(16),
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: currentYear - 1900,
                            ),
                            itemExtent: 40,
                            onSelectedItemChanged: (int index) {
                              selectedYear = 1900 + index;
                            },
                            children: List<Widget>.generate(
                              currentYear - 1900 + 1,
                                  (int index) {
                                final year = 1900 + index;
                                return Center(
                                  child: Text(
                                    year.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            hintText: "2025",
            readOnly: true,
            validator: (val){
              if((val??"").isEmpty){
                return "Please select year of establish";
              }
            },
            headerText: "Years of Establish",
            controller: controller.yearsInBusinessController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
