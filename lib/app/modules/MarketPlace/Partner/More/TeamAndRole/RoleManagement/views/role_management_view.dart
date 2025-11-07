import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/roles_view_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/teams_view_widget.dart';

class RoleManagementView extends GetView<RoleManagementController> {
  RoleManagementView({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,

      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text("Role & Team"),
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
              const Gap(10),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: MyColors.grayF7,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Obx(() {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => controller.showRoles.value = true,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: controller.showRoles.value ? 1 : 0,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Roles",
                                        style: MyTexts.medium15.copyWith(
                                          color: MyColors.gray2E,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              GestureDetector(
                                onTap: () => controller.showRoles.value = false,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: !controller.showRoles.value
                                          ? 1
                                          : 0,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Teams",
                                        style: MyTexts.medium15.copyWith(
                                          color: MyColors.gray2E,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const Spacer(),
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            if (controller.showRoles.value) {
                              Get.toNamed(Routes.ADD_ROLE);
                            } else {
                              if (controller.roles.isEmpty) {
                                SnackBars.errorSnackBar(
                                  content:
                                      "Please create a role before adding a team",
                                );
                              } else {
                                Get.toNamed(Routes.ADD_TEAM);
                              }
                            }
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.grayEA),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(Asset.add),
                                const Gap(8),
                                Text(
                                  controller.showRoles.value
                                      ? "Add Role"
                                      : "Add Team",
                                  style: MyTexts.medium15.copyWith(
                                    color: MyColors.gray2E,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Obx(() {
                          return controller.showRoles.value
                              ? RolesViewWidget()
                              : TeamsViewWidget();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
