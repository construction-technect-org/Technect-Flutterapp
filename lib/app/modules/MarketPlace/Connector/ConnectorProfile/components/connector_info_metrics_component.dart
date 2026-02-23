import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/add_kyc_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/poc_edit_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/controllers/edit_product_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/models/connector_Project_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/views/edit_project_view.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';

class ConnectorInfoMetricsComponent extends StatelessWidget {
  const ConnectorInfoMetricsComponent({super.key});

  ConnectorProfileController get controller => Get.find<ConnectorProfileController>();

   // final  EditProductController editControllers = Get.find<EditProductController>();

  @override
  Widget build(BuildContext context) {
    final connectorProfile = controller.connectorProfile;
    // final connectorProfileData = controller.profileDatas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Information', style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => EditProfile());
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(Asset.edit),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),

        _buildInfoMetricsContent(),
        SizedBox(height: 2.h),

        // ---------- KYC Section ----------
        Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Text('Aadhaar details', style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        if (connectorProfile != null &&
            (connectorProfile.aadhaarNumber != null || connectorProfile.panNumber != null)) ...[
          _buildExistingKycDetails(connectorProfile),
        ] else ...[
          GestureDetector(
            onTap: () {
              Get.to(() => AddKycScreen());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayEA),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(child: Text("+ Add Kyc", style: MyTexts.bold16)),
            ),
          ),
        ],
        SizedBox(height: 2.h),

        // ---------- Project Section ----------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Project details', style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => EditProjectView());
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(Asset.edit),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        _buildProjectDetails(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Point of contact', style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),

              const Spacer(),

              GestureDetector(
                onTap: () {
                  final isNew = controller.profileDatas.value == null;

                  Get.to(() => EditPocProfile(), arguments: isNew);
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(Asset.edit),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          if (controller.profileDatas.value?.success != true) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.profileDatas.value;

          if (profile == null) {
            return const Text("No Data Found");
          }

          final poc = profile.connector?.pocDetails;
          return _buildProjectDetailsPoint([
            {"title": "POC Name", "value": poc?.pocName ?? "Null"},
            {"title": "Designation", "value": poc?.pocDesignation ?? "Null"},
            {"title": "Phone Number", "value": poc?.pocPhone ?? "Null"},
            {"title": "Alternative Number", "value": poc?.pocAlternatePhone ?? "Null"},
            {"title": "Email", "value": poc?.pocEmail ?? "Null"},
          ]);
        }),
        // SizedBox(height: 2.h),
        // ---------- Project Section ----------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Project details',
                style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => EditProjectView());
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(Asset.edit),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (editController.projectList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("No Project Found"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: editController.projectList.length,
            itemBuilder: (context, index) {
              final project = editController.projectList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildProjectDetails(project),
              );
            },
          );
        }),

        SizedBox(height: 2.h),
      ],
    );
  }

  // ------------------- USER INFO CARD -------------------
  Widget _buildInfoMetricsContent() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.white,
          border: Border.all(color: MyColors.grayEA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Obx(() {
          final userData = controller.userData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(
                title: "Name",
                data:
                    '${(userData?.firstName ?? '').capitalizeFirst} ${(userData?.lastName ?? '').capitalizeFirst}'
                        .trim()
                        .isEmpty
                    ? 'User Name'
                    : '${(userData?.firstName ?? '').capitalizeFirst} ${(userData?.lastName ?? '').capitalizeFirst}'
                          .trim(),
              ),
              const Gap(6),
              buildRow(
                title: "Mobile Number",
                data: "${userData?.countryCode ?? ''} ${userData?.mobileNumber ?? ''}",
              ),
              const Gap(6),
              buildRow(title: "Email ID", data: userData?.email ?? "-"),
              const Gap(6),
              buildRow(title: "Role", data: userData?.roleName ?? "-"),
              SizedBox(height: 0.5.h),
            ],
          );
        }),
      ),
    );
  }

  Widget buildRow({String? data, required String title}) {
    return Row(
      children: [
        Text(title, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
        const Spacer(),
        Text(data ?? "", style: MyTexts.medium15.copyWith(color: MyColors.gray2E)),
      ],
    );
  }

  // ------------------- KYC DISPLAY CARD -------------------
  Widget _buildExistingKycDetails(ConnectorProfile connectorProfile) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
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
            buildRow(title: "Aadhaar Number", data: connectorProfile.aadhaarNumber ?? "-"),
            const Gap(6),
            buildRow(title: "PAN Number", data: connectorProfile.panNumber ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectDetails(ConnectorProject project) {
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
          buildRow(title: "Project Name", data: "Adarsh"),
          const Gap(6),
          buildRow(title: "Project Code", data: "CT-PRJ001"),
          const Gap(6),
          buildRow(title: "Area", data: "1600 sqft"),
          const Gap(6),
          buildRow(title: "Project Type", data: "Residential Project"),
          const Gap(6),
          buildRow(title: "No. of floor", data: "2"),
          const Gap(6),
          buildRow(title: "Project Status", data: "Ongoing"),
        ],
      ),
    );
  }

  // Widget _buildProjectDetails() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: MyColors.white,
  //       border: Border.all(color: MyColors.grayEA),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         buildRow(title: "Project Name", data: "Adarsh" ?? "-"),
  //         const Gap(6),
  //         buildRow(title: "Project Code", data: "CT-PRJ001" ?? "-"),
  //         const Gap(6),
  //         buildRow(title: "Area", data: "1600 sqft" ?? "-"),
  //         const Gap(6),
  //         buildRow(title: "Project Type", data: "Residential Project" ?? "-"),
  //         const Gap(6),
  //         buildRow(title: "No. of floor", data: "2" ?? "-"),
  //         const Gap(6),
  //         buildRow(title: "Project Status", data: "Ongoing" ?? "-"),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProjectDetailsPoint(List<Map<dynamic, dynamic>> allData) {
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
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allData.length,
            itemBuilder: (context, index) {
              final item = allData[index];
              return buildRow(
                title: item["title"]?.toString() ?? "-",
                data: item["value"]?.toString() ?? "-",
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 6),
          ),
          // buildRow(title: "Project Name", data: "Adarsh" ?? "-"),
          // const Gap(6),
          // buildRow(title: "Project Code", data: "CT-PRJ001" ?? "-"),
          // const Gap(6),
          // buildRow(title: "Area", data: "1600 sqft" ?? "-"),
          // const Gap(6),
          // buildRow(title: "Project Type", data: "Residential Project" ?? "-"),
          // const Gap(6),
          // buildRow(title: "No. of floor", data: "2" ?? "-"),
          // const Gap(6),
          // buildRow(title: "Project Status", data: "Ongoing" ?? "-"),
        ],
      ),
    );
  }
}
