import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/YourRole/controllers/your_role_controller.dart';

class YourRoleView extends GetView<YourRoleController> {
  const YourRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Asset.bricksBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(43)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.sw, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('YOUR ROLE', style: MyTexts.light22),
                    SizedBox(height: 3.h),
                    Text('Select Your Role', style: MyTexts.regular18),
                    SizedBox(height: 1.h),
                    // Options List
                    Obx(
                      () => Column(
                        children: [
                          _buildOption(
                            title: "Partner",
                            imagePath: Asset.partner,
                            isSelected: controller.selectedRole.value == "Partner",
                            onTap: () => controller.selectRole("Partner"),
                          ),
                          const SizedBox(height: 16), // spacing
                          _buildOption(
                            title: "Connector",
                            imagePath: Asset.connector,
                            isSelected: controller.selectedRole.value == "Connector",
                            onTap: () => controller.selectRole("Connector"),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        SizedBox(height: 13.sh),
                        RoundedButton(
                          buttonName: 'PROCEED',
                          onTap: () {
                            Get.toNamed(Routes.MAIN);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 5.sh),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required String title,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 11.8.h,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? MyColors.lightBlueSecond : MyColors.textFieldBorder,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 65,
                  width: 66,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColors
                              .yellow // selected full yellow
                        : MyColors.yellowRemaining,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 26,
                    width: 46,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                   style: MyTexts.bold18.copyWith(color:MyColors.fontBlack),
                  ),
                ),
              ],
            ),
          ),

          // ✅ Check icon positioned top-right
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(Asset.checkCircle, height: 21, width: 19),
            ),
        ],
      ),
    );
  }
}
