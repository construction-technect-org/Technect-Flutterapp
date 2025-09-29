import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/AddTeam/controllers/add_team_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/components/delete_team_dialog.dart';

class AddTeamView extends GetView<AddTeamController> {
  const AddTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            title: Text(controller.isEdit.value ? "EDIT TEAM" : "ADD TEAM"),
            isCenter: false,
            action: controller.isEdit.value
                ? [
                    IconButton(
                      onPressed: () {
                        DeleteTeamDialog.showDeleteTeamDialog(
                          context,
                          controller.teamDetailsModel.value,
                          () {
                            controller.deleteTeamMember(
                              controller.teamDetailsModel.value.id!,
                            );
                            Get.back();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: MyColors.red,
                        size: 24,
                      ),
                    ),
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => controller.pickImageBottomSheet(context),
                    child: Obx(() {
                      if (controller.selectedImage.value != null) {
                        return ClipOval(
                          child: Image.file(
                            controller.selectedImage.value!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }

                      final imagePath =
                          controller.teamDetailsModel.value.profilePhotoUrl ?? "";
                      final imageUrl = imagePath.isNotEmpty
                          ? "${APIConstants.bucketUrl}$imagePath"
                          : null;

                      if (imageUrl == null) {
                        return const Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.grey,
                        );
                      }

                      return ClipOval(
                        child: getImageView(
                          finalUrl: imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.pickImageBottomSheet(context),
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label:  Text(
                      controller.isEdit.value ?
                      "Change Photo":"Upload Photo",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary, // or Colors.blue
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  hintText: "Enter your First name",
                  headerText: 'First Name',
                  controller: controller.fNameController,
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  hintText: "Enter your Last name",
                  headerText: 'Last Name',
                  controller: controller.lNameController,
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  hintText: "Enter your email address",
                  headerText: 'Email ID',
                  controller: controller.emialIdController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 2.h),
                CommonTextField(
                  hintText: "Enter your phone number",
                  headerText: 'Phone number',
                  controller: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),

                SizedBox(height: 2.h),

                Row(
                  children: [
                    Text(
                      'User Role',
                      style: MyTexts.light16.copyWith(
                        color: MyColors.lightBlue,
                      ),
                    ),
                    Text(
                      '*',
                      style: MyTexts.regular16.copyWith(color: Colors.red),
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

                SizedBox(height: 4.h),
                Center(
                  child: Obx(
                    () => RoundedButton(
                      buttonName: controller.isEdit.value ? "UPDATE" : 'ADD',
                      onTap: () {
                        controller.filedValidation();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
