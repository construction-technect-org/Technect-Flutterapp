import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddTeam/controllers/add_team_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';

class AddTeamView extends GetView<AddTeamController> {
  const AddTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          leading: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(50),
            child: const Icon(Icons.arrow_back_rounded, size: 24, color: Colors.black),
          ),
          title: Obx(
            () => Text(
              controller.isEdit.value ? "EDIT TEAM" : "ADD TEAM",
              style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
            ),
          ),
          automaticallyImplyLeading: false, // remove default back button
          backgroundColor: MyColors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(), // user swipe disable
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Profile Photo",
                        style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => DashedCircle(
                            size: 81,
                            color: MyColors.grey,
                            strokeWidth: 1.2,
                            file: controller.pickedFileProfilePhotoPath.value,
                            assetImage: Asset.profil,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // File Picker
                        Obx(
                          () => Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 119,
                                  height: 31,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      controller.pickPhotoFromGallery('profile_photo');
                                    },
                                    child: Text(
                                      "Choose Photo",
                                      style: MyTexts.regular16.copyWith(
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.pickedFileProfilePhotoName.value,
                                  style: MyTexts.regular16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Full Name ',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.fullNameController),

                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          'Email ID',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.emialIdController),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Phone Number',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.PhonenumberController),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Address',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.addressController),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'State',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.stateController),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'City',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.cityController),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Pincode',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.pinCodeController),
                    SizedBox(height: 0.8.h),

                    Row(
                      children: [
                        Text(
                          'Documents',
                          style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'Aadhar Card',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.aadharCardController),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'PAN Card',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),
                    CustomTextField(controller: controller.panCardController),

                    SizedBox(height: 2.h),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Aadhar Card",
                        style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //details add kr
                        Obx(
                          () => DashedCircle(
                            size: 81,
                            color: MyColors.grey,
                            strokeWidth: 1.2,
                            file: controller.pickedFileAadhaarCardPhotoPath.value,
                            assetImage: Asset.profil,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // File Picker
                        Obx(
                          () => Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 119,
                                  height: 31,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      controller.pickPhotoFromGallery(
                                        'aadhar_card_photo',
                                      );
                                    },
                                    child: Text(
                                      "Choose Photo",
                                      style: MyTexts.regular16.copyWith(
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.pickedFileAadhaarCardPhotoName.value,
                                  style: MyTexts.regular16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3.h),

                    // Product Image
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "PAN Card",
                        style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => DashedCircle(
                            size: 81,
                            color: MyColors.grey,
                            strokeWidth: 1.2,
                            file: controller.pickedFilePanCardPhotoPath.value,
                            assetImage: Asset.profil,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // File Picker
                        Obx(
                          () => Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 119,
                                  height: 31,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      controller.pickPhotoFromGallery('pan_card_photo');
                                    },
                                    child: Text(
                                      "Choose Photo",
                                      style: MyTexts.regular16.copyWith(
                                        color: MyColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.pickedFilePanCardPhotoName.value,
                                  style: MyTexts.regular16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    const Divider(color: MyColors.veryLightGrey, indent: 5, endIndent: 5),

                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Text(
                          'User Role',
                          style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),
                    Obx(
                      () => controller.roles.isNotEmpty
                          ? CommonDropdown<GetAllRole>(
                              hintText: "Select User Role",
                              items: controller.roles,
                              selectedValue: controller.selectedRole!,
                              itemLabel: (item) => item.roleTitle ?? '',
                            )
                          : const SizedBox.shrink(),
                    ),

                    SizedBox(height: 3.h),

                    const Divider(color: MyColors.veryLightGrey, indent: 5, endIndent: 5),

                    SizedBox(height: 2.h),
                    Center(
                      child: Obx(
                        () => RoundedButton(
                          buttonName: 'NEXT',
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            controller.filedValidation();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
