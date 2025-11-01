import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/components/add_kyc_screen.dart';
import 'package:gap/gap.dart';

class ConnectorInfoMetricsComponent extends StatelessWidget {
  const ConnectorInfoMetricsComponent({super.key});

  ConnectorProfileController get controller =>
      Get.find<ConnectorProfileController>();

  @override
  Widget build(BuildContext context) {
    final connectorProfile = controller.connectorProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Information',
                style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'KYC Details',
                style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        if (connectorProfile != null &&
            (connectorProfile.aadhaarNumber != null ||
                connectorProfile.panNumber != null)) ...[
          _buildExistingKycDetails(connectorProfile),
        ] else ...[
          GestureDetector(
            onTap: (){
              Get.to(()=> AddKycScreen());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.grayEA),
                borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(child: Text("+ Add Kyc", style: MyTexts.bold16)),
            ),
          ),
        ],
        SizedBox(height: 2.h),
      ],
    );
  }

  // ------------------- USER INFO CARD -------------------
  Widget _buildInfoMetricsContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                data:
                    "${userData?.countryCode ?? ''} ${userData?.mobileNumber ?? ''}",
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
        Text(
          data ?? "",
          style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
        ),
      ],
    );
  }

  // ------------------- KYC DISPLAY CARD -------------------
  Widget _buildExistingKycDetails(connectorProfile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
            buildRow(
              title: "Aadhaar Number",
              data: connectorProfile.aadhaarNumber ?? "-",
            ),
            const Gap(6),
            buildRow(
              title: "PAN Number",
              data: connectorProfile.panNumber ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}
