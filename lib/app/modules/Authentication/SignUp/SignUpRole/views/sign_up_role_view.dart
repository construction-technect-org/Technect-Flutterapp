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
        appBar: CommonAppBar(title: const Text("SIGN UP"), isCenter: false),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: 2.h),
                  // const StepperWidget(currentStep: 0),
                  // SizedBox(height: 2.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Role',
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: 'PROCEED',
            onTap: () {
              if (controller.selectedRole.value > 0) {
                if (controller.selectedRole.value == 6 &&
                    controller.otherRoleController.text.isEmpty) {
                  SnackBars.errorSnackBar(content: 'Please enter other role');
                  return;
                } else {
                  if (controller.selectedRole.value == 1) {
                    controller.selectedRoleName.value = "Merchant";
                  } else if (controller.selectedRole.value == 6) {
                    controller.selectedRoleName.value =
                        controller.otherRoleController.text;
                  } else {
                    controller.selectedRoleName.value =
                        controller.roleName[controller.selectedRole.value - 1];
                  }
                  print(controller.selectedRoleName.value);
                  Get.toNamed(Routes.SIGN_UP_DETAILS);
                }
              } else {
                SnackBars.errorSnackBar(content: 'Please select role');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(int index, String imagePath, String roleName) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectRole(controller.roleId[index]);
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
                      child:  Icon(
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
