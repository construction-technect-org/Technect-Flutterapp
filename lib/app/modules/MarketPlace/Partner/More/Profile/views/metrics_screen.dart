import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/point_of_contact.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/RoleManagement/models/GetTeamListModel.dart';

class MetricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Row(
          children: [
            Text(
              'Point of contact',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => PointOfContentScreen());
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
        ),
        _buildPointOfViewContent(),
        SizedBox(height: 2.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Team members',
              style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.ROLE_MANAGEMENT,
                  arguments: {"isRole": false},
                );
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
        ),
        Obx(() {
          if (Get.find<CommonController>().teamList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'No team members found',
                  style: MyTexts.medium15.copyWith(color: MyColors.gra54),
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Get.find<CommonController>().teamList.length,
            itemBuilder: (context, index) {
              final team = Get.find<CommonController>().teamList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _buildTeamCard(team, context),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildPointOfViewContent() {
    return Obx(() {
      final pointOfContact = Get.find<CommonController>()
          .profileData
          .value
          .data
          ?.merchantProfile
          ?.pointOfContact;
      if (pointOfContact?.name?.isEmpty ?? true) {
        return GestureDetector(
          onTap: () {
            Get.to(() => PointOfContentScreen());
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.grayEA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                " + Add Point of contact",
                style: MyTexts.bold16.copyWith(color: MyColors.grey),
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: MyColors.grayEA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(title: "Name", data: pointOfContact?.name ?? "-"),
              const Gap(6),
              buildRow(
                title: "Designation",
                data: pointOfContact?.relation ?? "-",
              ),
              const Gap(6),
              buildRow(
                title: "Phone number",
                data: pointOfContact?.phoneNumber ?? "-",
              ),
              const Gap(6),
              buildRow(
                title: "Alternative number",
                data: pointOfContact?.alternativePhoneNumber ?? "-",
              ),
              const Gap(6),
              buildRow(title: "Email id", data: pointOfContact?.email ?? "-"),
              const Gap(6),
            ],
          ),
        );
      }
    });
  }

  Widget buildRow({String? data, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            data ?? "",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
          ),
        ),
      ],
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
