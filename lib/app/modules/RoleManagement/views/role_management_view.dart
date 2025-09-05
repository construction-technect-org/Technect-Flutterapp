import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/AddRole/controllers/add_role_controller.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';
import 'package:construction_technect/app/modules/RoleManagement/controllers/role_management_controller.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetAllRoleModel.dart';

class RoleManagementView extends GetView<RoleManagementController> {
  const RoleManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: Row(
          children: [
            Image.asset(Asset.profil, height: 40, width: 40),
            SizedBox(width: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Vaishnavi!",
                  style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADDRESS);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Asset.location, width: 9, height: 12.22),
                      SizedBox(width: 0.4.h),
                      Text(
                        "Sadashiv Peth, Pune",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.textFieldBackground,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.hexGray92),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(Asset.notifications, width: 28, height: 28),
                  Positioned(
                    right: 0,
                    top: 3,
                    child: Container(
                      width: 6.19,
                      height: 6.19,
                      decoration: const BoxDecoration(
                        color: MyColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: MyColors.white,
              //       borderRadius: BorderRadius.circular(22.5),
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Color(0x1A000000),
              //           blurRadius: 8,
              //           offset: Offset(0, 4),
              //         ),
              //       ],
              //     ),
              //     child: TextField(
              //       decoration: InputDecoration(
              //         prefixIcon: Padding(
              //           padding: const EdgeInsets.only(left: 18, right: 8),
              //           child: SvgPicture.asset(Asset.searchIcon, height: 16, width: 16),
              //         ),
              //         hintText: 'Search',
              //         hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
              //         filled: true,
              //         fillColor: MyColors.white,
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(22.5),
              //           borderSide: BorderSide.none,
              //         ),
              //         suffixIcon: Padding(
              //           padding: const EdgeInsets.all(14),
              //           child: SvgPicture.asset(Asset.filterIcon, height: 20, width: 20),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 1.h),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 24, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Role Management",
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.textFieldBackground,
                      ),
                    ),
                    RoundedButton(
                      onTap: () {
                        Get.toNamed(Routes.ADD_ROLE);
                      },
                      buttonName: '',
                      borderRadius: 10,
                      width: 26.w,
                      height: 35,
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      child: Center(
                        child: Text(
                          '+ Add New Role',
                          style: MyTexts.medium14.copyWith(color: MyColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => StatCard(
                              title: 'Total Roles',
                              value: controller.roles.length.toString(),
                              icon: SvgPicture.asset(Asset.TotalProducts),
                              iconBackground: MyColors.yellowundertones,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Total Team',
                            value: '02',
                            icon: SvgPicture.asset(Asset.Featured),
                            iconBackground: MyColors.verypaleBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Active Roles',
                            value: controller.roles.length.toString(),
                            icon: SvgPicture.asset(Asset.LowStock),
                            iconBackground: MyColors.paleRed,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Active Team',
                            value: '02',
                            icon: SvgPicture.asset(Asset.TotalInterests),
                            iconBackground: MyColors.warmOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.roles.isEmpty) {
                  return const Center(child: Text("No roles found"));
                }

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ROLE_DETAILS);
                  },
                  child: SizedBox(
                    height: 26.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.roles.length,
                      separatorBuilder: (_, __) => SizedBox(width: 4.w),
                      itemBuilder: (context, index) {
                        final role = controller.roles[index];
                        return RoleCard(role: role);
                      },
                    ),
                  ),
                );
              }),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 24, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Team Management",
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.textFieldBackground,
                      ),
                    ),
                    Center(
                      child: RoundedButton(
                        onTap: () {
                          Get.toNamed(Routes.ADD_TEAM);
                        },
                        buttonName: '',
                        borderRadius: 10,
                        width: 26.w,
                        height: 35,
                        verticalPadding: 0,
                        horizontalPadding: 0,
                        child: Center(
                          child: Text(
                            '+ Add New Team',
                            style: MyTexts.medium14.copyWith(color: MyColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return GestureDetector(
                        onTap: () {
                          // 👇 Navigate to new screen & pass user data
                          Get.toNamed(Routes.TEAM_DETAILS);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyColors.white, // 👈 background color
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: MyColors.americanSilver),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(user["image"]!),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          user["name"]!,
                                          style: MyTexts.extraBold20.copyWith(
                                            color: MyColors.fontBlack,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: MyColors.mediumSeaGreen,
                                            borderRadius: BorderRadius.circular(14.5),
                                          ),
                                          child: Text(
                                            "Admin",
                                            style: MyTexts.extraBold14.copyWith(
                                              color: MyColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      user["role"]!,
                                      style: MyTexts.regular16.copyWith(
                                        color: MyColors.fontBlack,
                                      ),
                                    ),
                                    Text(
                                      "@ ${user["email"]!}",
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
                                          user["status"]!,
                                          style: MyTexts.regular14.copyWith(
                                            color: MyColors.mutedGreen,
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
                  ),
                ),
              ),
            ],
          ),
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
    return SizedBox(
      width: 65.w,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: MyColors.americanSilver),
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
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        // 👈 this fixes overflow issue
                        child: Text(
                          role.roleTitle,
                          style: MyTexts.medium20.copyWith(color: MyColors.fontBlack),
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
                        ), // space between dot & text
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.philippineGray, // 👈 change color if needed
                        ),
                      ),
                      Expanded(
                        child: Text(
                          role.roleDescription,
                          style: MyTexts.regular14.copyWith(color: MyColors.gray32),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: MyColors.whiteBlue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      "Users: ${role.id} ",
                      style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Edit Button
          Positioned(
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
          ),
        ],
      ),
    );
  }
}
