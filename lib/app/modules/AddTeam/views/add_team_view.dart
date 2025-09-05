import 'package:construction_technect/app/core/utils/dashed_circle.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/AddTeam/controllers/add_team_controller.dart';

class AddTeamView extends GetView<AddTeamController> {
  const AddTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,

        automaticallyImplyLeading: false, // remove default back button
        backgroundColor: MyColors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: 6.h, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    "ADD TEAM",
                    style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                const DashedCircle(
                  size: 81,
                  color: MyColors.grey,
                  strokeWidth: 1.2,
                  dashLength: 6,
                  dashGap: 4,
                  assetImage: Asset.profil,
                ),
                const SizedBox(width: 12),

                // File Picker
                Obx(
                  () => Column(
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
                          onPressed: () async {
                            await controller.pickFile(type: "profile");
                          },
                          child: Text(
                            "Choose File",
                            style: MyTexts.regular16.copyWith(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.pickedFileName.value,
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                    ],
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
            SizedBox(height: 2.h),

Row(
  children: [
    Text(
      'Is Active',
      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
    ),
  ],
),

SizedBox(height: 1.h),
Obx(() => SwitchListTile(
      value: controller.isActive.value,
      onChanged: (val) => controller.isActive.value = val,
      activeColor: MyColors.primary,
      title: Text(
        controller.isActive.value ? "Active" : "Inactive",
        style: MyTexts.regular16.copyWith(
          color: MyColors.fontBlack,
        ),
      ),
    )),

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
                const DashedCircle(
                  size: 81,
                  color: MyColors.grey,
                  strokeWidth: 1.2,
                  dashLength: 6,
                  dashGap: 4,
                  assetImage: Asset.profil,
                ),
                const SizedBox(width: 12),

                // File Picker
                Obx(
                  () => Column(
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
                          onPressed: () async {
                            await controller.pickFile(type: "aadhar");
                          },
                          child: Text(
                            "Choose File",
                            style: MyTexts.regular16.copyWith(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.pickedFileName.value,
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                    ],
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
                const DashedCircle(
                  size: 81,
                  color: MyColors.grey,
                  strokeWidth: 1.2,
                  dashLength: 6,
                  dashGap: 4,
                  assetImage: Asset.profil,
                ),
                const SizedBox(width: 12),

                // File Picker
                Obx(
                  () => Column(
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
                          onPressed: () async {
                            await controller.pickFile(type: "pan");
                          },
                          child: Text(
                            "Choose File",
                            style: MyTexts.regular16.copyWith(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.pickedFileName.value,
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                    ],
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
            CommonDropdown<String>(
              hintText: "Select User Role",
              items: controller.categories,
              selectedValue: controller.selectedCategory,
              itemLabel: (item) => item,
            ),

            SizedBox(height: 3.h),

            const Divider(color: MyColors.veryLightGrey, indent: 5, endIndent: 5),

            SizedBox(height: 2.h),
            Center(
              child: RoundedButton(
                buttonName: 'NEXT',
                onTap: () {
                  controller.createTeamMember();
                },
              ),
            ),
          ],
        ),
      ),
    ],
  ),
)
 );
  }
}
