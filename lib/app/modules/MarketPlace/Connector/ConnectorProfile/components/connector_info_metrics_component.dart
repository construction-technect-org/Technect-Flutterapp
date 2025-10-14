import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';
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
        SizedBox(height: 4.h),
        // Avatar
        Center(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8, right: 8),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(Asset.infoIcon),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFED29),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.photo_camera,
                      size: 20, color: MyColors.black),
                ),
              ),
            ],
          ),
        ),

        // Info Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Information',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.fontBlack,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  Get.to(()=>EditProfile());
                },
                icon: const Icon(Icons.edit, color: Colors.black, size: 20),
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
                'VERIFY KYC',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.fontBlack,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
              ),
              const Spacer(),
              if (connectorProfile != null &&
                  (connectorProfile.aadhaarNumber != null ||
                      connectorProfile.panNumber != null))
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.toNamed(
                      Routes.ADD_KYC,
                      arguments: {
                        'kycId': connectorProfile.id,
                        'aadhaar_number': connectorProfile.aadhaarNumber,
                        'pan_number': connectorProfile.panNumber,
                        'aadhaar_front': connectorProfile.documents
                            ?.firstWhereOrNull(
                                (d) => d.documentType == 'aadhaar_front')
                            ?.filePath,
                        'aadhaar_back': connectorProfile.documents
                            ?.firstWhereOrNull(
                                (d) => d.documentType == 'aadhaar_back')
                            ?.filePath,
                        'pan_front': connectorProfile.documents
                            ?.firstWhereOrNull((d) => d.documentType == 'pan_front')
                            ?.filePath,
                        'pan_back': connectorProfile.documents
                            ?.firstWhereOrNull((d) => d.documentType == 'pan_back')
                            ?.filePath,
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.black, size: 20),
                ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        if (connectorProfile != null &&
            (connectorProfile.aadhaarNumber != null ||
                connectorProfile.panNumber != null))
          _buildExistingKycDetails(connectorProfile),
        _buildBusinessMetricsContent(connectorProfile),
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
          border: Border.all(color: MyColors.primary),
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
              buildRow(title: "GSTIN", data: userData?.gst ?? "-"),
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
        Text(
          title,
          style: MyTexts.medium16.copyWith(
            color: MyColors.primary.withValues(alpha: 0.5),
            fontFamily: MyTexts.SpaceGrotesk,
          ),
        ),
        const Spacer(),
        Text(
          data ?? "",
          style: MyTexts.medium16.copyWith(
            color: MyColors.black,
            fontFamily: MyTexts.SpaceGrotesk,
          ),
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
          border: Border.all(color: MyColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(
                title: "Aadhaar Number",
                data: connectorProfile.aadhaarNumber ?? "-"),
            const Gap(6),
            buildRow(
                title: "PAN Number", data: connectorProfile.panNumber ?? "-"),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessMetricsContent(connectorProfile) {
    final bool hasKyc = connectorProfile != null &&
        connectorProfile.aadhaarNumber != null &&
        connectorProfile.panNumber != null;

    return hasKyc? const SizedBox(): GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.ADD_KYC,
          arguments: hasKyc
              ? {
            'kycId': connectorProfile.id,
            'aadhaar_number': connectorProfile.aadhaarNumber,
            'pan_number': connectorProfile.panNumber,
            'aadhaar_front': connectorProfile.documents
                ?.firstWhereOrNull(
                    (d) => d.documentType == 'aadhaar_front')
                ?.filePath,
            'aadhaar_back': connectorProfile.documents
                ?.firstWhereOrNull(
                    (d) => d.documentType == 'aadhaar_back')
                ?.filePath,
            'pan_front': connectorProfile.documents
                ?.firstWhereOrNull((d) => d.documentType == 'pan_front')
                ?.filePath,
            'pan_back': connectorProfile.documents
                ?.firstWhereOrNull((d) => d.documentType == 'pan_back')
                ?.filePath,
          }
              : null,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(
              color: hasKyc ? MyColors.primary : MyColors.grey,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "+ ADD KYC DETAILS",
              style: MyTexts.bold16.copyWith(
                color: hasKyc ? MyColors.primary : MyColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
