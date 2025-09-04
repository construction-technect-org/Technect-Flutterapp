import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/core/widgets/stepper_edit_profile_widget.dart';
import 'package:construction_technect/app/modules/editProfile/controller/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [StepperEditProfileWidget(currentStep: 1)],
              ),
              SizedBox(height: 2.h),
              Column(
                key: controller.titleKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EDIT PROFILE",
                    style: MyTexts.light22.copyWith(color: MyColors.textFieldBackground),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Update your Business Details",
                    style: MyTexts.light16.copyWith(color: MyColors.greyDetails),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

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
              // New Password
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
              // New Password
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
              // New Password
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
              // New Password
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
              // New Password

              /// Business Hours
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: MyColors.oldLace,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.businessHours.value.isEmpty
                              ? "Business Hours*"
                              : controller.businessHours.value,
                          style: MyTexts.bold16.copyWith(color: MyColors.progressFill),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.BUSINESS_HOURS);
                          // controller.addBusinessHours("9:00 AM - 6:00 PM");
                        },
                        child: Text(
                          "+ADD",
                          style: MyTexts.bold16.copyWith(
                            color: MyColors.progressFill,

                            decoration: TextDecoration.underline, // underline ON
                            decorationColor: MyColors.progressFill, // underline color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 4.h),
              RoundedButton(
                buttonName: 'UPDATE',
                onTap: () {
                  // controller.completeSignUp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
