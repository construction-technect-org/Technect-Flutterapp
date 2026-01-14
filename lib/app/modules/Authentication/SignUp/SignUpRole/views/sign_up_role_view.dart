import 'dart:ui';

import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/views/sign_up_more_details_view.dart';

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Role selection grid
                      Flexible(child: _buildBackGround()),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.15),
                  child: Stack(
                    children: [
                      /* Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(color: Colors.black.withOpacity(0.15)),
                        ),
                      ), */
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                const Size(75, 28),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                Colors.white,
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),

                                  side: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                            child: Text("Skip Login", style: MyTexts.medium14),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 40.h,
                        child: Material(
                          elevation: 10,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          shadowColor: Colors.black,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            height: 30.h,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),*/
                                const SizedBox(height: 24),
                                Text(
                                  "Select Your Role",
                                  style: MyTexts.bold18.copyWith(
                                    color: MyColors.primary,
                                  ),
                                ),

                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _roleOptionButton(
                                        role: "partner",
                                        type: "Merchant",
                                        icon: Asset.contractor,
                                        onTap: () {
                                          hideKeyboard();
                                          controller.selectedFinalRole.value =
                                              "partner";
                                          myPref.setRole(
                                            controller.selectedFinalRole.value,
                                          );
                                          // Get.back();
                                          Get.to(() => SignUpMoreDetailsView());
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _roleOptionButton(
                                        role: "connector",
                                        type: "Connector",
                                        icon: Asset.houseOwner,
                                        onTap: () {
                                          hideKeyboard();
                                          controller.selectedFinalRole.value =
                                              "connector";
                                          myPref.setRole(
                                            controller.selectedFinalRole.value,
                                          );
                                          Get.to(() => SignUpMoreDetailsView());
                                          //Get.offNamed(Routes.SIGN_UP_DETAILS);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleOptionButton({
    required String icon,
    required String role,
    required VoidCallback onTap,
    required String type,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            //image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: role == controller.selectedFinalRole.value
                  ? MyColors.primary
                  : MyColors.grayEA,
            ),
          ),
          child: Column(
            children: [
              Image.asset(icon, width: 86, height: 96, fit: BoxFit.cover),
              const Gap(14),
              Text(type, style: MyTexts.medium16),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBackGround() {
    return GridView.builder(
      itemCount: controller.roleImages.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // crossAxisSpacing: 4.0,
        // mainAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return getItemList(controller.roleImages[index]);
      },
    );
  }

  Widget getItemList(String roleImagePath) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8),
      child: Container(
        width: 100,

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.gra54EA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
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
                    child: Image.asset(roleImagePath),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
