import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/AddRole/controllers/add_role_controller.dart';

class AddRoleView extends GetView<AddRoleController> {
  AddRoleView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    controller.isEdit.value ? "Edit Role" : "Add  Role",
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              headerText: 'Role Title',
                              hintText: "Enter the role",
                              controller: controller.roleController,
                              validator: (val) {
                                if ((val ?? "").isEmpty) {
                                  return "Please enter the role";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 2.h),
                            CommonTextField(
                              headerText: 'Role Description',
                              hintText: "Please add description",
                              maxLine: 4,
                              validator: (val) {
                                if ((val ?? "").isEmpty) {
                                  return "Please enter the description";
                                }
                                return null;
                              },
                              controller: controller.roleDescription,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Functionalities',
                              style: MyTexts.medium15.copyWith(
                                color: MyColors.gray2E,
                              ),
                            ),
                            SizedBox(height: 1.2.h),
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                _buildChip(
                                  label: "Approvals",
                                  assetImage: Asset.approvals,
                                  color: MyColors.green,
                                  controller: controller,
                                ),
                                _buildChip(
                                  label: "Management",
                                  assetImage: Asset.management,
                                  color: MyColors.warning,
                                  controller: controller,
                                ),
                                _buildChip(
                                  label: "Operations",
                                  assetImage: Asset.operations,
                                  color: MyColors.red,
                                  controller: controller,
                                ),
                              ],
                            ),
                          ],
                        ),
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
          child: Obx(() {
            return RoundedButton(
              buttonName: controller.isEdit.value ? 'Update' : 'Add',
              onTap: controller.isLoading.value
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        controller.saveRole();
                      }
                    },
            );
          }),
        ),
      ),
    );
  }
  Widget _buildChip({
    required String label,
    required String assetImage,
    required Color color,
    required AddRoleController controller,
  }) {
    return Obx(() {
      final isSelected = controller.selectedFunctionalities.value == label;
      const Color defaultColor = MyColors.darkSilver;

      final bool isEditMode = controller.isEdit.value;

      return InkWell(
        onTap: isEditMode
            ? null
            : () => controller.selectedFunctionalities.value = label,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isEditMode ? color.withOpacity(0.05) : color.withOpacity(0.1))
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? (isEditMode ? color.withOpacity(0.5) : color)
                  : defaultColor,
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetImage,
                height: 20,
                width: 20,
                color: isSelected ? color : defaultColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: MyTexts.medium15.copyWith(
                  color: isSelected ? color : defaultColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}
