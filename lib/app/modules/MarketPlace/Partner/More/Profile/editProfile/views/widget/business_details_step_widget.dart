import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/utils/validation_utils.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/editProfile/controller/edit_profile_controller.dart';
import 'package:flutter/cupertino.dart';

class BusinessDetailsStep extends StatelessWidget {
  final EditProfileControllerr controller;
  final GlobalKey<FormState> formKey;

  const BusinessDetailsStep({
    super.key,
    required this.controller,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
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
              LengthLimitingTextInputFormatter(150),
              // NameInputFormatter(),
            ],
            validator: (value) =>
                Validate.validateBusinessName(value, fieldName: "company name"),
          ),
          SizedBox(height: 2.h),
          Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus) {
                final web = controller.businessWebsiteController.text;
                // if (Get.find<ProfileController>().businessModel.value.website ==
                //     web) {
                //   controller.websiteError.value = "";
                //   return;
                // }
                final formatError = ValidationUtils.validateWebsiteUrl(web);
                if (formatError == null) {
                  await controller.validateUrlAvailability();
                } else {
                  controller.websiteError.value = "";
                }
              }
            },
            child: CommonTextField(
              hintText: "Enter your website url",
              headerText: "Website",
              controller: controller.businessWebsiteController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: ValidationUtils.validateWebsiteUrl,
            ),
          ),
          Obx(() {
            if (controller.websiteError.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  controller.websiteError.value,
                  style: MyTexts.medium13.copyWith(color: MyColors.red33),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(height: 2.h),
          Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                final email = controller.businessEmailController.text;
                final formatError = Validate.validateEmail(email);
                if (formatError == null) {
                  controller.validateEmailAvailability();
                } else {
                  controller.emailError.value = "";
                }
              }
            },
            child: CommonTextField(
              headerText: "Business Email",
              hintText: "adc12@business.com",
              controller: controller.businessEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validate.validateEmail(value),
              onChange: (value) {
                controller.emailError.value = "";
              },
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
            enable: false,
            readOnly: true,
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
                final num = controller.businessContactController.text;
                final formatError = Validate.validateMobileNumber(num);
                if (formatError == null) {
                  controller.validateNumAvailability();
                } else {
                  controller.numberError.value = "";
                }
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
              validator: (val) => Validate.validateMobileNumber(val),
              onChange: (value) {
                controller.numberError.value = "";
              },
            ),
          ),
          Obx(() {
            //6586568469
            if (controller.numberError.value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  controller.numberError.value,
                  style: TextStyle(color: Colors.red[800], fontSize: 12),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
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
            validator: (val) =>
                Validate.validateMobileNumber(val, isOptional: true),
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
            validator: (val) {
              if ((val ?? "").isEmpty) {
                return "Please select year of establish";
              }
              return null;
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
