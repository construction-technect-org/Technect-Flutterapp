import 'package:construction_technect/app/core/utils/common_button.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddRole/controllers/add_role_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                "ADD ROLE",
                style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          children: [
            // -------- Page 1 --------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Role Title
                  Text(
                    'Role Title',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  CustomTextField(
                    controller: controller.roleController,
                  ),
                  SizedBox(height: 2.h),

                  // Role Description
                  Text(
                    'Role Description',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: controller.roleDescription,
                    maxLines: 3,
                  ),
                  SizedBox(height: 2.h),

                  // Permissions section title
                  Text(
                    'Functionalities',
                    style: MyTexts.regular16.copyWith(color: MyColors.darkSilver),
                  ),
                  SizedBox(height: 1.h),

                  // Chips
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildChip(
                        label: "Approvals",
                        icon: Icons.check_circle,
                        color: MyColors.green,
                      ),
                      _buildChip(
                        label: "Management",
                        icon: Icons.waves,
                        color: MyColors.warning,
                      ),
                      _buildChip(
                        label: "Operations",
                        icon: Icons.warning,
                        color: MyColors.red,
                      ),
                    ],
                  ),

                  const Spacer(),

                  // NEXT button
                  Center(
                    child: RoundedButton(
                      buttonName: 'SUBMIT',
                      onTap: () {
                      
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget _buildChip({
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: color,),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          label,
          style: MyTexts.regular16.copyWith(color: color),

        ),
      ],
    ),
  );
}
