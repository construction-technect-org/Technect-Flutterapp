import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/AddTeam/controllers/add_team_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';

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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                    ),
                    Text('*', style: MyTexts.regular16.copyWith(color: Colors.red)),
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
