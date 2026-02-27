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

  EditProductController get editController => Get.find<EditProductController>();

  @override
  Widget build(BuildContext context) {
    final connectorProfile = controller.connectorProfile;
    // final connectorProfileData = controller.profileDatas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ✅ My Information Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Information',
                style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => EditProfile());
                },
                behavior: HitTestBehavior.translucent,
                child: Icon(Icons.edit, size: 18, color: Colors.black54),
              ),
            ],
          ),
        ),

        SizedBox(height: 1.h),

        /// ✅ Info Rows
        _buildInfoRow(
          icon: Icons.phone_outlined,
          label: "Phone Number",
          value: connectorProfile?.panNumber ?? "",
        ),

        Divider(color: Colors.grey.shade100, height: 1),

        _buildInfoRow(
          icon: Icons.badge_outlined,
          label: "Designation",
          value: connectorProfile?.aadhaarNumber ?? "",
        ),

        Divider(color: Colors.grey.shade100, height: 1),

        _buildInfoRow(
          icon: Icons.mail_outline_rounded,
          label: "Email ID",
          value: connectorProfile?.teamMembers?.name ?? "",
        ),

        // SizedBox(height: 2.h),
        // SizedBox(height: 1.h),
        // _buildInfoMetricsContent(),
        // SizedBox(height: 2.h),

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
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: "Phone Number",
            value: connectorProfile.panNumber ?? "",
          ),

          Divider(color: Colors.grey.shade100, height: 1),

          _buildInfoRow(
            icon: Icons.badge_outlined,
            label: "Designation",
            value: connectorProfile.aadhaarNumber ?? "",
          ),

          // _buildExistingKycDetails(connectorProfile),
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

        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text('Point of contact', style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),
        //
        //       const Spacer(),
        //
        //       GestureDetector(
        //         onTap: () {
        //
        //         },
        //         behavior: HitTestBehavior.translucent,
        //         child: Padding(
        //           padding: const EdgeInsets.all(4.0),
        //           child: SvgPicture.asset(Asset.edit),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(height: 1.h),
        Obx(() {
          if (controller.profileDatas.value?.success != true) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.profileDatas.value;

          if (profile == null) {
            return const Center(child: Text("No Data Found"));
          }

          final poc = profile.connector?.pocDetails;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              // color: const Color(0xffF2F2F2), // light grey background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔹 Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      "Point of Contact",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(onTap: () {
                      final isNew = controller.profileDatas.value == null;

                      Get.to(() => EditPocProfile(), arguments: isNew);
                    }, child: Icon(Icons.edit, size: 18, color: Colors.black54)),
                  ],
                ),

                const SizedBox(height: 15),

                _buildInfoRow(
                  icon: Icons.badge_outlined,
                  label: "POC Name",
                  value: poc?.pocName ?? "N/A",
                ),
                _buildInfoRow(
                  icon: Icons.work_outline,
                  label: "Designation",
                  value: poc?.pocDesignation ?? "N/A",
                ),
                _buildInfoRow(
                  icon: Icons.phone_outlined,
                  label: "Phone Number",
                  value: poc?.pocPhone ?? "N/A",
                ),
                _buildInfoRow(
                  icon: Icons.phone,
                  label: "Alternate Number",
                  value: poc?.pocAlternatePhone ?? "N/A",
                ),
                _buildInfoRow(
                  icon: Icons.email_outlined,
                  label: "Email ID",
                  value: poc?.pocEmail ?? "N/A",
                ),
              ],
            ),
          );
        }),
        // SizedBox(height: 2.h),
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
                child: Icon(Icons.edit, size: 18, color: Colors.black54),
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
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          /// Icon
          Icon(icon, size: 18, color: Colors.grey.shade500),

          const SizedBox(width: 12),

          /// Label
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          /// Value
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
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

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ✅ Top — Avatar + Name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white,
          child: Row(
            children: [
              /// Avatar
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors.primary,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/free-photo/construction-site-sunset_23-2152006125.jpg",
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Name + Verified
              const Row(
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.verified_rounded,
                    color: Colors.green,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),

        /// ✅ Divider
        Divider(color: Colors.grey.shade200, height: 1),

        /// ✅ My Information Section
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Information",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  /// Edit Icon
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// ✅ Phone Number
              _buildInfoRow(
                icon: Icons.phone_outlined,
                label: "Phone Number",
                value: "+91 8798798709",
              ),

              _buildDivider(),

              /// ✅ Designation
              _buildInfoRow(
                icon: Icons.badge_outlined,
                label: "Designation",
                value: "Manufacturer",
              ),

              _buildDivider(),

              /// ✅ Email ID
              _buildInfoRow(
                icon: Icons.mail_outline_rounded,
                label: "Email ID",
                value: "Fullname@gmail.com",
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ✅ Info Row
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          /// Icon
          Icon(icon, size: 18, color: Colors.grey.shade500),

          const SizedBox(width: 12),

          /// Label
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          /// Value
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Divider
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade100,
      height: 1,
    );
  }
}