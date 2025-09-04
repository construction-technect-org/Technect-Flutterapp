import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/stepper_widget.dart';
import 'package:construction_technect/app/modules/SignUpRole/controllers/sign_up_role_controller.dart';

class SignUpRoleView extends GetView<SignUpRoleController> {
  const SignUpRoleView({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 6.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 4.h),
                    // Stepper
                    const StepperWidget(currentStep: 0),
                    SizedBox(height: 1.h),
                    Text('SIGN UP', style: MyTexts.light22),
                    Text(
                      'Select Role',
                      style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                    ),
                    SizedBox(height: 2.h),
                    // Role selection grid
                    Obx(
                      () => Column(
                        children: [
                          for (int i = 0; i < 6; i += 2)
                            Padding(
                              padding: EdgeInsets.only(bottom: i < 4 ? 20.0 : 0),
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
                    SizedBox(height: 2.h),
                    RoundedButton(
                      buttonName: 'PROCEED',
                      onTap: () {
                        if (controller.selectedRole.value > 0) {
                          Get.toNamed(Routes.SIGN_UP_DETAILS);
                        }
                      },
                    ),
                    SizedBox(height: 2.5.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ", style: MyTexts.light16),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            "Login",
                            style: MyTexts.light16.copyWith(
                              color: MyColors.lightBlueSecond,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.sh),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(int index, String imagePath, String roleName) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectRole(controller.roleId[index]);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedRole.value - 1 == index
                  ? MyColors.lightBlueSecond
                  : const Color(0xFFA0A0A0),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    SizedBox(width: 60, height: 60, child: Image.asset(imagePath)),
                    const SizedBox(height: 8),
                    Text(roleName, style: MyTexts.bold18, textAlign: TextAlign.center),
                  ],
                ),
              ),
              if (controller.selectedRole.value - 1 == index)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyColors.lightBlueSecond,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.done_rounded, color: MyColors.white, size: 16),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
