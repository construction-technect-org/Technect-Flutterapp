import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/role_card_widget.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/views/widget/statistic_tile_widget.dart';

class RolesViewWidget extends StatelessWidget {
  const RolesViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final con = RoleManagementController.to;
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
                    value: con.statistics.value.totalRoles ?? "0",
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => StatisticTile(
                    image: Asset.totalProduct,
                    title: 'Active Roles',
                    value: con.statistics.value.activeRoles ?? "0",
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          RefreshIndicator(
            onRefresh: () async => await con.refreshRoles(),
            child: Obx(() {
              if (con.isLoading.value) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (con.roles.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                    ),
                    child: Text(
                      'No role found',
                      style: MyTexts.medium15.copyWith(color: MyColors.gra54),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: con.roles.length,
                itemBuilder: (context, index) {
                  final role = con.roles[index];
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
}
