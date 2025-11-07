import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/controller/home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/statistic_tile_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/team_card_widget.dart';

class TeamsViewWidget extends StatelessWidget {
  const TeamsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.find<RoleManagementController>();
    final homecon = Get.find<HomeController>();

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
                    value: homecon.statistics.value.totalTeamMember ?? '0',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Active Team',
                    value: homecon.statistics.value.activeTeamMember ?? '0',
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          RefreshIndicator(
            onRefresh: () async => await homecon.refreshTeamList(),
            child: Obx(() {
              if (con.isLoadingTeam.value) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (homecon.teamList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                    ),
                    child: Text(
                      'No team members found',
                      style: MyTexts.medium15.copyWith(color: MyColors.gra54),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homecon.teamList.length,
                itemBuilder: (context, index) {
                  final team = homecon.teamList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TeamCardWidget(user: team),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
