import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/Connector/AddKyc/models/AddkycModel.dart';
import 'package:construction_technect/app/modules/Connector/ConnectorProfile/controllers/connector_profile_controller.dart';
import 'package:gap/gap.dart';

class ConnectorInfoMetricsComponent extends StatelessWidget {
  const ConnectorInfoMetricsComponent({super.key});

  ConnectorProfileController get controller => Get.find<ConnectorProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
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
                  child: Icon(Icons.photo_camera, size: 20, color: MyColors.black),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Information',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Asset.editIcon,
                        height: 18,
                        width: 18,
                        color: MyColors.primary,
                      ),
                      Text(
                        'Edit Profile',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.primary,
                          fontFamily: MyTexts.Roboto,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColors.primary,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 2.h),
        _buildInfoMetricsContent(),
        SizedBox(height: 2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'VERIFY KYC',
            style: MyTexts.medium16.copyWith(
              color: MyColors.fontBlack,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        _buildBusinessMetricsContent(),
        SizedBox(height: 2.h),
      ],
    );
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                              data: "${userData?.countryCode} ${userData?.mobileNumber}",
                            ),
                            const Gap(6),
                            buildRow(title: "Email ID", data: "${userData?.email}"),
                            const Gap(6),
                            buildRow(title: "GSTIN", data: "${userData?.roleName}"),
                            SizedBox(height: 0.5.h),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
            fontFamily: MyTexts.Roboto,
          ),
        ),
        const Spacer(),
        Text(
          data ?? "",
          style: MyTexts.medium16.copyWith(
            color: MyColors.black,
            fontFamily: MyTexts.Roboto,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessMetricsContent({Addkyc? existingKyc}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.ADD_KYC,
          arguments: existingKyc != null
              ? {
                  'kycId': existingKyc.id,
                  'aadhaar_number': existingKyc.aadhaarNumber,
                  'pan_number': existingKyc.panNumber,
                  'aadhaar_front': existingKyc.aadhaarFront,
                  'aadhaar_back': existingKyc.aadhaarBack,
                  'pan_front': existingKyc.panFront,
                  'pan_back': existingKyc.panBack,
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
            border: Border.all(color: MyColors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              existingKyc != null ? "UPDATE KYC DETAILS" : "+ ADD KYC DETAILS",
              style: MyTexts.bold16.copyWith(color: MyColors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
