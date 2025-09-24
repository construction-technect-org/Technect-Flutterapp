import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorHome/views/connector_home_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class RoleManagementView extends GetView<RoleManagementController> {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Roles & Teams
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          leading:  GestureDetector(
            onTap:
                    () {
                  Get.back();
                },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(Icons.arrow_back_ios, color: MyColors.black),
            ),
          ),
          backgroundColor: MyColors.white,
          elevation: 0,
          leadingWidth: 40,
          title:  Text(
            "Teams & Roles",
            style: MyTexts.medium18.copyWith(color: Colors.black,fontFamily: MyTexts.Roboto),
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: MyColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: MyColors.primary,
            tabs: [
              Tab(text: 'Roles'),
              Tab(text: 'Teams'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 24,
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HearderText(text: "Role Management"),
                      RoundedButton(
                        onTap: () {
                          Get.toNamed(Routes.ADD_ROLE);
                        },
                        buttonName: '',
                        borderRadius: 10,
                        width: 28.w,
                        height: 35,
                        verticalPadding: 0,
                        horizontalPadding: 0,
                        child: Center(
                          child: Text(
                            ' + Add New Role',
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                      () => StatCard(
                                    title: 'Total Roles',
                                    value: controller.roles.length
                                        .toString(),
                                    icon: SvgPicture.asset(
                                      Asset.TotalProducts,
                                    ),
                                    iconBackground:
                                    MyColors.yellowundertones,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Obx(
                                      () => StatCard(
                                    title: 'Active Roles',
                                    value:
                                    controller
                                        .teamStats
                                        .value
                                        ?.data
                                        ?.activeRoles ??
                                        '0',
                                    icon: SvgPicture.asset(
                                      Asset.LowStock,
                                    ),
                                    iconBackground: MyColors.paleRed,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        const Gap(20),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (controller.roles.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Center(child: Text("No roles found")),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: controller.roles.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            separatorBuilder: (_, _) => SizedBox(width: 4.w),
                            itemBuilder: (context, index) {
                              final role = controller.roles[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.ROLE_DETAILS,
                                      arguments: {"getRole": role},
                                    )?.then((value) {
                                      controller.loadRoles();
                                    });
                                  },
                                  child: RoleCard(role: role),
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 24,
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HearderText(text: "Team Management"),
                      Center(
                        child: RoundedButton(
                          onTap: () {
                            Get.toNamed(Routes.ADD_TEAM);
                          },
                          buttonName: '',
                          borderRadius: 10,
                          width: 28.w,
                          height: 35,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          child: Center(
                            child: Text(
                              ' + Add New Team',
                              style: MyTexts.medium14.copyWith(
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                    () => StatCard(
                                  title: 'Total Team',
                                  value:
                                  controller
                                      .teamStats
                                      .value
                                      ?.data
                                      ?.totalTeamMembers ??
                                      '0',
                                  icon: SvgPicture.asset(
                                    Asset.Featured,
                                  ),
                                  iconBackground: MyColors.verypaleBlue,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),
                            Expanded(
                              child: Obx(
                                    () => StatCard(
                                  title: 'Active Team',
                                  value:
                                  controller
                                      .teamStats
                                      .value
                                      ?.data
                                      ?.activeTeamMembers ??
                                      '0',
                                  icon: SvgPicture.asset(
                                    Asset.TotalInterests,
                                  ),
                                  iconBackground: MyColors.warmOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() {
                          if (controller.isLoadingTeam.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (homeController.teamList.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(child: Text("No Team member found")),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController.teamList.length,
                            itemBuilder: (context, index) {
                              final TeamListData user =
                                  homeController.teamList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.TEAM_DETAILS,
                                    arguments: {
                                      "team": homeController.teamList[index],
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColors.americanSilver,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: user.profilePhotoUrl ?? '',
                                            width: 48,
                                            height: 48,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: const BoxDecoration(
                                                    color: MyColors.grey1,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child:
                                                        CupertinoActivityIndicator(
                                                          color: MyColors.primary,
                                                          radius: 12,
                                                        ),
                                                  ),
                                                ),
                                            errorWidget: (context, url, error) =>
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: const BoxDecoration(
                                                    color: MyColors.grey1,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: MyColors.grey,
                                                    size: 24,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  user.fullName!,
                                                  style: MyTexts.extraBold20
                                                      .copyWith(
                                                        color: MyColors.fontBlack,
                                                      ),
                                                ),
                                                const SizedBox(width: 6),
                                                Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color: MyColors
                                                        .primary, // background with opacity
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 10,
                                                      // smaller so it fits inside 14x14 box
                                                      color: MyColors.white,
                                                    ),
                                                  ),
                                                ),

                                                const Spacer(),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColors.mediumSeaGreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          14.5,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "Admin",
                                                    style: MyTexts.extraBold14
                                                        .copyWith(
                                                          color: MyColors.white,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              user.roleTitle ?? '',
                                              style: MyTexts.regular16.copyWith(
                                                color: MyColors.fontBlack,
                                              ),
                                            ),
                                            Text(
                                              "@ ${user.emailId ?? ''}",
                                              style: MyTexts.regular14.copyWith(
                                                color: MyColors.lightGray,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  user.isActive == true
                                                      ? 'Active'
                                                      : 'DeActive',
                                                  style: MyTexts.regular14
                                                      .copyWith(
                                                        color:
                                                            MyColors.mutedGreen,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // ... keep the rest of the Team section exactly as is
                // including ListView.builder for teamList
              ],
            ),
          ],
        ),
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
            border: Border.all(
              color: role.isActive == true
                  ? MyColors.green
                  : MyColors.red,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header row
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: MyColors.paleBluecolor, // background color
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Asset.Admin,
                          width: 14.54, // scale as needed
                          height: 13,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      // 👈 this fixes overflow issue
                      child: Text(
                        role.roleTitle ?? '',
                        style: MyTexts.medium18.copyWith(
                          color: MyColors.fontBlack,
                          fontFamily: MyTexts.Roboto,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(
                        top: 6,
                        right: 6,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColors
                            .philippineGray,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        role.roleDescription ?? '',
                        style: MyTexts.regular14.copyWith(
                          color: MyColors.gray32,
                          fontFamily: MyTexts.Roboto,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.whiteBlue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      "Users: ${role.teamMemberCount ?? '0'} ",
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Edit Button
        /* Positioned(
          right: 3.w,
          top: 3.h,
          child: GestureDetector(
            // Inside RoleCard
            // onTap: () {
            //   final controller = Get.put(AddRoleController());
            //   controller.loadRoleData(role); // pass role model from API
            //   Get.toNamed(Routes.ADD_ROLE);
            // },

            // inside RoleCard
            onTap: () {
              final controller = Get.put(AddRoleController());
              controller.loadRoleData(role); // pass selected role
              Get.toNamed(Routes.ADD_ROLE);
            },

            child: Container(
              width: 27,
              height: 26,
              decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.white),
            ),
          ),
        ),*/
      ],
    );
  }
}
