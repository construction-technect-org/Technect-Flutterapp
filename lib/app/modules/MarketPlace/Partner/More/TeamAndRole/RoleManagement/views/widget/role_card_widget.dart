import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/components/delete_team_dialog.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetAllRoleModel.dart';

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
                        // Delete Role
                        GestureDetector(
                          onTap: () {
                            DeleteRoleDialog.showDeleteRoleDialog(context, () {
                              RoleManagementController.to.deleteRole(role.id!);
                            });
                          },
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
