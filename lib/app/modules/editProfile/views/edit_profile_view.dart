import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/core/widgets/stepper_edit_profile_widget.dart';
import 'package:construction_technect/app/modules/editProfile/controller/edit_profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    buttonName: controller.currentStep.value == 1 ? 'NEXT' : 'UPDATE',
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StepperEditProfileWidget(currentStep: controller.currentStep.value),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => Column(
                  key: controller.titleKey,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EDIT PROFILE",
                      style: MyTexts.light22.copyWith(
                        color: MyColors.textFieldBackground,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.currentStep.value == 1
                          ? "Update your Business Details"
                          : "Update your Certifications",
                      style: MyTexts.light16.copyWith(color: MyColors.greyDetails),
                    ),
                    // Progress Bar
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Step 1: Business Details
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
    );
  }

  /// Build Business Details Step
  Widget _buildBusinessDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Business Name',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
          ],
        ),
        SizedBox(height: 1.h),
        CustomTextField(controller: controller.businessNameController),
        SizedBox(height: 2.h),

        Row(
          children: [
            Text(
              'Business Email',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
          ],
        ),
        SizedBox(height: 1.h),
        CustomTextField(controller: controller.businessEmailController),
        SizedBox(height: 2.h),

        Row(
          children: [
            Text(
              'Business Contact Number',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
          ],
        ),
        SizedBox(height: 1.h),
        CustomTextField(controller: controller.businessContactController),
        SizedBox(height: 2.h),

        Row(
          children: [
            Text(
              'Years in Business',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
          ],
        ),
        SizedBox(height: 1.h),
        CustomTextField(controller: controller.yearsInBusinessController),
        SizedBox(height: 2.h),

        Row(
          children: [
            Text(
              'Projects Completed',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
          ],
        ),
        SizedBox(height: 1.h),
        CustomTextField(controller: controller.projectsCompletedController),
        SizedBox(height: 2.h),
        Obx(
          () => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.oldLace,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: controller.businessHours.value.isEmpty
                    ? MyColors.textFieldBorder
                    : MyColors.primary.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.orange, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Business Hours*",
                        style: MyTexts.bold16.copyWith(color: MyColors.progressFill),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Pass previous business hours data if available
                        final previousData = controller.businessHoursData.toList();
                        final result = await Get.toNamed(
                          Routes.BUSINESS_HOURS,
                          arguments: previousData.isNotEmpty ? previousData : null,
                        );
                        if (result != null && result is List<Map<String, dynamic>>) {
                          controller.handleBusinessHoursData(result);
                        }
                      },
                      child: Text(
                        controller.businessHours.value.isEmpty ? "ADD" : "EDIT",
                        style: MyTexts.bold16.copyWith(color: MyColors.progressFill),
                      ),
                    ),
                  ],
                ),
                if (controller.businessHours.value.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.businessHours.value,
                        style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
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
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColors.primary.withOpacity(0.1)
                        : const Color(0xFFD9F0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      Asset.certificateIcon,
                      colorFilter: ColorFilter.mode(
                        isSelected ? MyColors.primary : MyColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.w),
                Column(
                  children: [
                    Text(
                      title,
                      style: MyTexts.medium22.copyWith(
                        color: MyColors.black,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    Text(
                      (isSelected && fileName != null) ? fileName : organization,
                      style: MyTexts.regular14.copyWith(
                        color: const Color(0xFF717171),
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
