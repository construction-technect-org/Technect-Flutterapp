import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddTeam/controllers/add_team_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/components/delete_team_dialog.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';

class AddTeamView extends GetView<AddTeamController> {
  AddTeamView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
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
                    title: Text(
                      controller.isEdit.value ? "Edit Team" : "Add Team",
                    ),
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
                    action: controller.isEdit.value
                        ? [
                            GestureDetector(
                              onTap: () {
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
                              behavior: HitTestBehavior.translucent,
                              child: SvgPicture.asset(Asset.remove),
                            ),
                          ]
                        : null,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    hideKeyboard();
                                    controller.pickImageBottomSheet(context);
                                  },
                                  child: Obx(() {
                                    if (controller.selectedImage.value !=
                                        null) {
                                      return ClipOval(
                                        child: Image.file(
                                          controller.selectedImage.value!,
                                          width: 78,
                                          height: 78,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }

                                    final imagePath =
                                        controller
                                            .teamDetailsModel
                                            .value
                                            .profilePhotoUrl ??
                                        "";
                                    final imageUrl = imagePath.isNotEmpty
                                        ? imagePath
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
                                    onTap: () {
                                      hideKeyboard();
                                      controller.pickImageBottomSheet(context);
                                    },
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
                            SizedBox(height: 2.h),
                            CommonTextField(
                              hintText: "Enter your first name",
                              headerText: 'First Name',
                              controller: controller.fNameController,
                              autofillHints: const [AutofillHints.givenName],
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                NameInputFormatter(),
                              ],
                              validator: (value) =>
                                  validateName(value, fieldName: "first name"),
                            ),
                            SizedBox(height: 2.h),
                            CommonTextField(
                              hintText: "Enter your last name",
                              headerText: 'Last Name',
                              controller: controller.lNameController,
                              autofillHints: const [AutofillHints.familyName],
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                NameInputFormatter(),
                              ],
                              validator: (value) =>
                                  validateName(value, fieldName: "last name"),
                            ),
                            SizedBox(height: 2.h),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  final email =
                                      controller.emialIdController.text;
                                  controller.validateEmailAvailability(email);
                                }
                              },
                              child: CommonTextField(
                                hintText: "Enter your email address",
                                headerText: 'Email ID',
                                controller: controller.emialIdController,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(150),
                                  EmailInputFormatter(),
                                ],
                                validator: (value) =>
                                    Validate.validateEmail(value),
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
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                            SizedBox(height: 2.h),
                            CommonTextField(
                              hintText: "Enter your phone number",
                              headerText: 'Phone number',
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (val) =>
                                  Validate.validateMobileNumber(val),
                            ),

                            SizedBox(height: 2.h),
                            Obx(
                              () => controller.roles.isNotEmpty
                                  ? CommonDropdown<GetAllRole>(
                                      headerText: 'User Role',
                                      hintText: "Select User Role",
                                      items: controller.roles,
                                      validator: (val) {
                                        if (val == null) {
                                          return "Please select role";
                                        }
                                        return null;
                                      },
                                      selectedValue: controller.selectedRole!,
                                      itemLabel: (item) => item.roleTitle ?? '',
                                    )
                                  : const SizedBox.shrink(),
                            ),

                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(
              () => RoundedButton(
                buttonName: controller.isEdit.value ? "Update" : 'Add',
                onTap: () {
                  if (!formKey.currentState!.validate()) return;
                  if (controller.emailError.value.isNotEmpty) return;
                  controller.validateEmailAvailability(
                    controller.emialIdController.text,
                  );
                  controller.filedValidation();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
