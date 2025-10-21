import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/components/delete_team_dialog.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';
import 'package:gap/gap.dart';

class RoleManagementView extends StatelessWidget {
  RoleManagementView({super.key});

  final RoleManagementController controller = Get.put(
    RoleManagementController(),
  );
  final HomeController homeController = Get.find();

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
                              Get.toNamed(Routes.ADD_TEAM);
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
                              ? _buildRolesView()
                              : _buildTeamsView(context);
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

  Widget _buildRolesView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Total Roles',
                    value: controller.statistics.value.totalRoles ?? "0",
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Active Roles',
                    value: controller.statistics.value.activeRoles ?? "0",
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          RefreshIndicator(
            onRefresh: () async => await controller.refreshRoles(),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.roles.isEmpty) {
                return const Center(child: Text('No roles found'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.roles.length,
                itemBuilder: (context, index) {
                  final role = controller.roles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: RoleCard(role: role),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ✅ TEAMS TAB CONTENT
  Widget _buildTeamsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Gap(10),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Total Team',
                    value:
                        homeController.statistics.value.totalTeamMember ?? '0',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Active Team',
                    value:
                        homeController.statistics.value.activeTeamMember ?? '0',
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          RefreshIndicator(
            onRefresh: () async => await homeController.refreshTeamList(),
            child: Obx(() {
              if (controller.isLoadingTeam.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (homeController.teamList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                    ),
                    child: Text(
                      'No team members found',
                      style: MyTexts.medium15,
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeController.teamList.length,
                itemBuilder: (context, index) {
                  final team = homeController.teamList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildTeamCard(team, context),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(TeamListData user, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: MyColors.grayEA.withValues(alpha: 0.32),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          const Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: (user.profilePhotoUrl ?? "").isNotEmpty
                      ? NetworkImage(user.profilePhotoUrl!)
                      : const AssetImage(Asset.aTeam) as ImageProvider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName ?? ''} ${user.lastName ?? ''}",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.gray2E,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        user.emailId ?? '',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        user.mobileNumber ?? '',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        user.roleTitle ?? '',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_TEAM, arguments: {"data": user});
                  },
                  behavior: HitTestBehavior.translucent,
                  child: SvgPicture.asset(Asset.edit),
                ),
                const Gap(16),
                GestureDetector(
                  onTap: () {
                    DeleteTeamDialog.showDeleteTeamDialog(context, user, () {
                      controller.deleteTeamMember(user.id!);
                      Get.back();
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: SvgPicture.asset(Asset.remove),
                ),
              ],
            ),
          ),
          if (user.isActive == true)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F5E6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                ),
                child: Text(
                  "Active",
                  style: MyTexts.medium14.copyWith(
                    color: MyColors.gray2E,
                    fontFamily: MyTexts.SpaceGrotesk,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final GetAllRole role;

  const RoleCard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: MyColors.grayEA.withValues(alpha: 0.32),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                role.roleTitle?.capitalizeFirst ?? '',
                                style: MyTexts.medium16.copyWith(
                                  color: MyColors.gray2E,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              const Gap(2),
                              Text(
                                role.roleDescription ?? '',
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.gray54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.ADD_ROLE,
                              arguments: {"isEdit": true, "data": role},
                            );
                          },
                          behavior: HitTestBehavior.translucent,
                          child: SvgPicture.asset(Asset.edit),
                        ),
                        const Gap(16),
                        GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.translucent,
                          child: SvgPicture.asset(Asset.remove),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MyColors.grayEA),
                        color: MyColors.grayF7,
                      ),
                      child: Text(
                        role.functionalities ?? '',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.gray2E,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(2),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6F5E6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
                  child: Text(
                    "Users - ${role.teamMemberCount ?? '0'} ",
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.gray2E,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatisticTile extends StatelessWidget {
  final String image;
  final String title;
  final String value;

  const StatisticTile({
    super.key,
    required this.image,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: MyTexts.bold18.copyWith(color: MyColors.gray2E),
              ),
              SizedBox(height: 0.4.h),
              Text(
                title,
                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
