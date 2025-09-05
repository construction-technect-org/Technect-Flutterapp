import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddRole/controllers/add_role_controller.dart';

class AddRoleView extends GetView<AddRoleController> {
  const AddRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 6.h, left: 16, right: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(50),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.isEdit ? "EDIT ROLE" : "ADD ROLE",
                style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Role Title',
                style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
              ),
              CustomTextField(controller: controller.roleController),
              SizedBox(height: 2.h),

              Text(
                'Role Description',
                style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
              ),
              SizedBox(height: 1.h),
              CustomTextField(controller: controller.roleDescription, maxLines: 3),
              SizedBox(height: 2.h),
              Text(
                'Functionalities',
                style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
              ),
              SizedBox(height: 1.h),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildChip(
                    label: "Approvals",
                    icon: Icons.check_circle,
                    color: MyColors.green,
                    controller: controller,
                  ),
                  _buildChip(
                    label: "Management",
                    icon: Icons.waves,
                    color: MyColors.warning,
                    controller: controller,
                  ),
                  _buildChip(
                    label: "Operations",
                    icon: Icons.warning,
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
                        : controller.isEdit
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
}

// class AddRoleView extends GetView<AddRoleController> {
//   const AddRoleView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         flexibleSpace: Padding(
//           padding: EdgeInsets.only(top: 6.h, left: 16, right: 16),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () => Get.back(),
//                 borderRadius: BorderRadius.circular(50),
//                 child: const Icon(
//                   Icons.arrow_back_rounded,
//                   size: 24,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 "ADD ROLE",
//                 style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Role Title',
//                   style: MyTexts.light16.copyWith(color: MyColors.lightBlue)),
//               CustomTextField(controller: controller.roleController),
//               SizedBox(height: 2.h),

//               Text('Role Description',
//                   style: MyTexts.light16.copyWith(color: MyColors.lightBlue)),
//               SizedBox(height: 1.h),
//               CustomTextField(
//                 controller: controller.roleDescription,
//                 maxLines: 3,
//               ),
//               SizedBox(height: 2.h),

//               Text('Functionalities',
//                   style: MyTexts.regular16
//                       .copyWith(color: MyColors.darkSilver)),
//               SizedBox(height: 1.h),

//               Wrap(
//                 spacing: 16,
//                 runSpacing: 16,
//                 children: [
//                   _buildChip(
//                       label: "Approvals",
//                       icon: Icons.check_circle,
//                       color: MyColors.green,
//                       controller: controller),
//                   _buildChip(
//                       label: "Management",
//                       icon: Icons.waves,
//                       color: MyColors.warning,
//                       controller: controller),
//                   _buildChip(
//                       label: "Operations",
//                       icon: Icons.warning,
//                       color: MyColors.red,
//                       controller: controller),
//                 ],
//               ),

//               const Spacer(),

//               Center(
//                 child: Obx(() {
//                   return RoundedButton(
//                     buttonName: controller.isLoading.value
//                         ? 'Loading...'
//                         : 'SUBMIT',
//                     onTap: controller.isLoading.value
//                         ? null
//                         : () => controller.createRole(),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

Widget _buildChip({
  required String label,
  required IconData icon,
  required Color color,
  required AddRoleController controller,
}) {
  return Obx(() {
    final isSelected = controller.selectedFunctionalities.contains(label);
    return InkWell(
      onTap: () => controller.toggleFunctionality(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: MyTexts.regular16.copyWith(
                color: isSelected ? color : MyColors.darkSilver,
              ),
            ),
          ],
        ),
      ),
    );
  });
}
