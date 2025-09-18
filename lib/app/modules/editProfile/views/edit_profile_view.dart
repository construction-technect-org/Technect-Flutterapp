import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/editProfile/controller/edit_profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
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
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: CommonAppBar(
            isCenter: false,
            title: Text("EDIT BUSINESS METRICS".toUpperCase()),
          ),
          backgroundColor: MyColors.white,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Row(
                  children: [
                    if (controller.currentStep.value > 1) ...[
                      Expanded(
                        child: RoundedButton(
                          buttonName: 'BACK',
                          onTap: () {
                            controller.previousStep();
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                    Expanded(
                      child: RoundedButton(
                        buttonName: controller.currentStep.value == 1
                            ? 'NEXT'
                            : 'UPDATE',
                        onTap: () {
                          controller.updateProfile();
                        },
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 30, right: 20, left: 20),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                // Obx(
                //   () => Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       StepperEditProfileWidget(
                //         currentStep: controller.currentStep.value,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 2.h),
                SizedBox(height: 0.6.h),
                Text("Update your Business Details",
                  style: MyTexts.medium16.copyWith(
                      color: MyColors.greyDetails,
                      fontFamily: MyTexts.Roboto
                  ),
                ),
                // Obx(() {
                //   return controller.currentStep.value == 1
                //       ? const SizedBox.shrink()
                //       : SizedBox(height: 3.h);
                // }),

                // Row(
                //   children: [
                //     Obx(
                //       () => controller.currentStep.value == 1
                //           ? const SizedBox.shrink()
                //           : SvgPicture.asset(
                //               Asset.certificateIcon,
                //               width: 20,
                //               height: 20,
                //             ),
                //     ),
                //
                //     SizedBox(width: 1.w),
                //     Obx(
                //       () => Text(
                //         controller.currentStep.value == 1
                //             ? ""
                //             : "Certifications & Licenses",
                //         style: MyTexts.medium16.copyWith(
                //           color: MyColors.black,
                //           fontFamily: MyTexts.Roboto,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 2.h),
                //
                // // Step 1: Business Details
                const Gap(20),
                Obx(
                  () => controller.currentStep.value == 1
                      ? _buildBusinessDetailsStep()
                      : _buildCertificationsStep(),
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build Business Details Step
  Widget _buildBusinessDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          headerText: "Business Name",
          hintText: "Enter your business name",
          controller: controller.businessNameController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
        ),
        SizedBox(height: 2.h),
        CommonTextField(
          hintText: "Enter your website url",
          headerText: "Website",
          controller: controller.businessWebsiteController,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 2.h),
        CommonTextField(
          headerText: "Business Email",
          hintText: "adcdef@gmail.com",
          controller: controller.businessEmailController,
          keyboardType: TextInputType.emailAddress,
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
        ),
        SizedBox(height: 2.h),
        CommonTextField(
          hintText: "+91 9292929929",

          headerText: "Business Contact Number",
          controller: controller.businessContactController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        SizedBox(height: 2.h),
        CommonTextField(
          headerText: "Years in Business",
          controller: controller.yearsInBusinessController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
        ),
        SizedBox(height: 2.h),
        CommonTextField(
          headerText:  'Projects Completed',
          controller: controller.projectsCompletedController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
        ),

        SizedBox(height: 2.h),
        // Obx(
        //   () => Container(
        //     padding: const EdgeInsets.all(16),
        //     decoration: BoxDecoration(
        //       color: MyColors.oldLace,
        //       borderRadius: BorderRadius.circular(12),
        //
        //       border: Border.all(
        //         color: controller.businessHoursData.isEmpty
        //             ? MyColors.textFieldBorder
        //             : MyColors.primary.withValues(alpha: 0.3),
        //       ),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             const Icon(
        //               Icons.access_time,
        //               color: MyColors.warning,
        //               size: 20,
        //             ),
        //             const SizedBox(width: 12),
        //             Expanded(
        //               child: Row(
        //                 children: [
        //                   Text(
        //                     'Business Hours',
        //                     style: MyTexts.bold16.copyWith(
        //                       color: MyColors.warning,
        //                     ),
        //                   ),
        //                   Text(
        //                     '*',
        //                     style: MyTexts.light16.copyWith(
        //                       color: MyColors.red,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             // GestureDetector(
        //             //   onTap: () async {
        //             //     // Pass previous business hours data if available
        //             //     final previousData = controller.businessHoursData
        //             //         .toList();
        //             //     final result = await Get.toNamed(
        //             //       Routes.BUSINESS_HOURS,
        //             //       arguments: previousData.isNotEmpty
        //             //           ? previousData
        //             //           : null,
        //             //     );
        //             //     if (result != null &&
        //             //         result is List<Map<String, dynamic>>) {
        //             //       controller.handleBusinessHoursData(result);
        //             //     }
        //             //   },
        //             //   child: Column(
        //             //     mainAxisSize: MainAxisSize.min,
        //             //     children: [
        //             //       Text(
        //             //         controller.businessHoursData.isEmpty
        //             //             ? "+ADD"
        //             //             : "+EDIT",
        //             //         style: MyTexts.bold16.copyWith(
        //             //           color: MyColors.warning,
        //             //           decoration: TextDecoration.none,
        //             //         ),
        //             //         textAlign: TextAlign.center,
        //             //       ),
        //             //       const SizedBox(height: 1),
        //             //       Container(
        //             //         height: 1,
        //             //         width: 50,
        //             //         color: MyColors.warning,
        //             //       ),
        //             //     ],
        //             //   ),
        //             // ),
        //           ],
        //         ),
        //         if (controller.businessHoursData.isNotEmpty) ...[
        //           const SizedBox(height: 12),
        //           Container(
        //             padding: const EdgeInsets.all(12),
        //             decoration: BoxDecoration(
        //               color: MyColors.white,
        //               borderRadius: BorderRadius.circular(8),
        //               border: Border.all(
        //                 color: MyColors.textFieldBorder.withValues(alpha: 0.3),
        //               ),
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: controller.businessHoursData.map((dayData) {
        //                 final dayName = dayData['day_name'] ?? '';
        //                 final isOpen = dayData['is_open'] == true;
        //                 final openTime = dayData['open_time'] ?? '';
        //                 final closeTime = dayData['close_time'] ?? '';
        //
        //                 return Padding(
        //                   padding: const EdgeInsets.only(bottom: 6.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Expanded(
        //                         flex: 2,
        //                         child: Text(
        //                           dayName,
        //                           style: MyTexts.regular14.copyWith(
        //                             color: MyColors.fontBlack,
        //                           ),
        //                         ),
        //                       ),
        //                       Expanded(
        //                         flex: 3,
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.end,
        //                           children: [
        //                             if (isOpen) ...[
        //                               const Icon(
        //                                 Icons.access_time,
        //                                 size: 14,
        //                                 color: MyColors.primary,
        //                               ),
        //                               const SizedBox(width: 4),
        //                             ],
        //                             Text(
        //                               isOpen
        //                                   ? '$openTime - $closeTime'
        //                                   : 'Closed',
        //                               style: MyTexts.regular14.copyWith(
        //                                 color: isOpen
        //                                     ? MyColors.fontBlack
        //                                     : MyColors.grey,
        //                                 fontWeight: isOpen
        //                                     ? FontWeight.w500
        //                                     : FontWeight.normal,
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               }).toList(),
        //             ),
        //           ),
        //         ],
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildCertificationsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCertificationItem('GST', 'Select File you want to upload '),
        SizedBox(height: 1.7.h),
        _buildCertificationItem('UDYAM', 'Select File you want to upload'),
      ],
    );
  }

  Widget _buildCertificationItem(String title, String organization) {
    return Obx(() {
      final isSelected = controller.isDocumentSelected(title);
      final fileName = controller.getSelectedDocumentName(title);

      return GestureDetector(
        onTap: () {
          controller.pickFile(title);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          color: isSelected ? MyColors.primary : const Color(0xFF8C8C8C),
          dashPattern: const [5, 5],
          child: Stack(
            children: [
              /// Main card content
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9F0FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          Asset.certificateIcon,
                          colorFilter: const ColorFilter.mode(
                            MyColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.w),

                    /// Title + Organization/File
                    Text(
                      title,
                      style: MyTexts.medium22.copyWith(
                        color: MyColors.black,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    Text(
                      (isSelected && fileName != null)
                          ? fileName
                          : organization,
                      style: MyTexts.regular14.copyWith(
                        color: const Color(0xFF717171),
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                ),
              ),
              /// Top-right action icons
              Positioned(
                right: 20,
                top: 20,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: SvgPicture.asset(Asset.eyeIcon, width: 26, height: 20),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {

                      },
                      child: SvgPicture.asset(
                        Asset.delete,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
