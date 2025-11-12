import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpRole/controllers/sign_up_role_controller.dart';

class SignUpRoleView extends GetView<SignUpRoleController> {
  const SignUpRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset.loginBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text("Sign up"),
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
                      padding: EdgeInsets.symmetric(horizontal: 6.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select your Role',
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.lightBlue,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          // Role selection grid
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  for (int i = 0; i < 6; i += 2)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: i < 4 ? 20.0 : 0,
                                      ),
                                      child: Row(
                                        children: [
                                          _buildRoleCard(
                                            i,
                                            controller.roleImages[i],
                                            controller.roleName[i],
                                          ),
                                          const SizedBox(width: 20),
                                          _buildRoleCard(
                                            i + 1,
                                            controller.roleImages[i + 1],
                                            controller.roleName[i + 1],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Obx(() {
                            return controller.selectedRole.value == 6
                                ? Column(
                                    children: [
                                      CommonTextField(
                                        hintText: "Specify others",
                                        textInputAction: TextInputAction.done,
                                        controller:
                                            controller.otherRoleController,
                                        onChange: (val) {
                                          controller.otherRoleString.value;
                                        },
                                      ),
                                      SizedBox(height: 2.h),
                                    ],
                                  )
                                : const SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return controller.selectedRole.value == 6
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RoundedButton(
                    buttonName: 'Continue',
                    onTap: () {
                      if (controller.otherRoleController.text.isEmpty) {
                        SnackBars.errorSnackBar(
                          content: 'Please enter other role',
                        );
                        return;
                      } else {
                        controller.selectedFinalRole.value = "";
                        if (controller.selectedRole.value > 0) {
                          if (controller.selectedRole.value == 1) {
                            controller.selectedRoleName.value = "Merchant";
                          } else if (controller.selectedRole.value == 6) {
                            controller.selectedRoleName.value =
                                controller.otherRoleController.text;
                          } else {
                            controller.selectedRoleName.value = controller
                                .roleName[controller.selectedRole.value - 1];
                          }
                          _showRoleTypeBottomSheet(Get.context!, controller);
                        } else {
                          SnackBars.errorSnackBar(
                            content: 'Please select role',
                          );
                        }
                      }
                    },
                  ),
                )
              : const SizedBox();
        }),
      ),
    );
  }

  void _showRoleTypeBottomSheet(
    BuildContext context,
    SignUpRoleController controller,
  ) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Select a Access",
              style: MyTexts.bold18.copyWith(color: MyColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              "Please select whether you want to register as a Merchant or Connector.",
              style: MyTexts.regular14.copyWith(color: MyColors.gray2E),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _roleOptionButton(
                    role: "partner",
                    icon: Asset.rMerchant,
                    onTap: () {
                      hideKeyboard();
                      controller.selectedFinalRole.value = "partner";
                      myPref.setRole(controller.selectedFinalRole.value);
                      // Get.back();
                      Get.offNamed(Routes.SIGN_UP_DETAILS);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _roleOptionButton(
                    role: "connector",
                    icon: Asset.rConnector,
                    onTap: () {
                      hideKeyboard();
                      controller.selectedFinalRole.value = "connector";
                      myPref.setRole(controller.selectedFinalRole.value);
                      Get.offNamed(Routes.SIGN_UP_DETAILS);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _roleOptionButton({
    required String icon,
    required String role,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 86,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(icon),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: role == controller.selectedFinalRole.value
                  ? MyColors.primary
                  : MyColors.grayEA,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildRoleCard(int index, String imagePath, String roleName) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedFinalRole.value = "";
          controller.selectRole(controller.roleId[index]);
          if (controller.selectedRole.value == 1) {
            controller.selectedRoleName.value = "Merchant";
          } else if (controller.selectedRole.value == 6) {
            controller.selectedRoleName.value =
                controller.otherRoleController.text;
            return;
          } else {
            controller.selectedRoleName.value =
                controller.roleName[controller.selectedRole.value - 1];
          }
          _showRoleTypeBottomSheet(Get.context!, controller);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8),
          child: Container(
            decoration: BoxDecoration(
              color: index == 1 ? const Color(0xFFFFFDEA) : null,
              border: Border.all(
                color: controller.selectedRole.value - 1 == index
                    ? MyColors.primary
                    : MyColors.grayD4,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.asset(imagePath),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            roleName,
                            style: MyTexts.bold16,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.selectedRole.value - 1 == index)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: MyColors.primary,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.done_rounded,
                        color: MyColors.white,
                        size: 16,
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
