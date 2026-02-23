

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/components/delete_team_dialog.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';

class TeamCardWidget extends StatelessWidget {
  final TeamListData user;
  const TeamCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final con = Get.find<RoleManagementController>();
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
                      con.deleteTeamMember(user.id!);
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
