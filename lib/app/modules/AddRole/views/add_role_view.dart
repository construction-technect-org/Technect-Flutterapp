import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddRole/controllers/add_role_controller.dart';

class AddRoleView extends GetView<AddRoleController> {
  const AddRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: Text(controller.isEdit.value ? "EDIT ROLE" : "ADD ROLE"),
          isCenter: false,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                headerText: 'Role Title',
                hintText: "Please add role tile",
                controller: controller.roleController,
              ),
              SizedBox(height: 2.h),

              CommonTextField(
                headerText: 'Role Description',
                hintText: "Please add role description",
                maxLine: 3,
                controller: controller.roleDescription,
              ),
              SizedBox(height: 2.h),
              Text(
                'Functionalities',
                style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
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
              const Spacer(),
              Center(
                child: Obx(() {
                  return RoundedButton(
                    buttonName: controller.isLoading.value
                        ? 'Loading...'
                        : controller.isEdit.value
                        ? 'UPDATE'
                        : 'SUBMIT',
                    onTap: controller.isLoading.value
                        ? null
                        : () => controller.saveRole(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildChip({
    required String label,
    required String assetImage,
    required Color color, // active color
    required AddRoleController controller,
  }) {
    return Obx(() {
      final isSelected = controller.selectedFunctionalities.value == label;
      const Color defaultColor = MyColors.darkSilver;

      return InkWell(
        onTap: () => controller.selectedFunctionalities.value = label,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
            border: Border.all(color: isSelected ? color : defaultColor),
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
                style: MyTexts.regular16.copyWith(
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

