import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';

class InfoMetricsComponent extends StatelessWidget {
  const InfoMetricsComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

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
                  child: Icon(
                    Icons.photo_camera,
                    size: 20,
                    color: MyColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
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
            // TextButton(
            //   onPressed: () {
            //     Get.toNamed(Routes.EDIT_PROFILE);
            //   },
            //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       SvgPicture.asset(
            //         Asset.editIcon,
            //         width: 12,
            //         height: 12,
            //         color: MyColors.primary,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 10),
            //         child: Text(
            //           "Edit Profile",
            //           style: MyTexts.regular14.copyWith(
            //             color: MyColors.primary,
            //             fontFamily: MyTexts.Roboto,
            //             decoration: TextDecoration.underline,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 2.h),
        _buildInfoMetricsContent(),
        SizedBox(height: 2.h),
        Text(
          'Business Metrics',
          style: MyTexts.medium16.copyWith(
            color: MyColors.fontBlack,
            fontFamily: MyTexts.Roboto,
          ),
        ),
        SizedBox(height: 1.h),
        _buildBusinessMetricsContent(),
        SizedBox(height: 2.h),
        Text(
          'Business Hours',
          style: MyTexts.medium16.copyWith(
            color: MyColors.fontBlack,
            fontFamily: MyTexts.Roboto,
          ),
        ),
        SizedBox(height: 1.h),
        _buildBusinessHourContent(),

        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildInfoMetricsContent() {
    return Container(
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
                      // final merchantProfile = controller.merchantProfile;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(
                            title: "Name",
                            data:
                            '${(userData?.firstName ?? '')
                                .capitalizeFirst} ${(userData?.lastName ?? '')
                                .capitalizeFirst}'
                                .trim()
                                .isEmpty
                                ? 'User Name'
                                : '${(userData?.firstName ?? '')
                                .capitalizeFirst} ${(userData?.lastName ?? '')
                                .capitalizeFirst}'
                                .trim(),
                          ),
                          const Gap(6),
                          buildRow(
                            title: "Mobile Number",
                            data: "${userData?.countryCode} ${userData
                                ?.mobileNumber}",
                          ),
                          const Gap(6),
                          buildRow(
                            title: "Email ID",
                            data: "${userData?.email}",
                          ),
                          const Gap(6),
                          buildRow(
                            title: "GSTIN",
                            data: "${userData?.roleName}",
                          ),
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
    );
  }

  Widget _buildBusinessMetricsContent() {
    if ((controller.businessModel.value.businessEmail ?? "").isEmpty) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.EDIT_PROFILE);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MyColors.white,
            border: Border.all(color: MyColors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(" + ADD BUSINESS DETAILS",
            style: MyTexts.bold16.copyWith(color: MyColors.grey),)),
        ),
      );
    } else {
      return Container(
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
            Obx(() {
              return buildRow(
                title: "Business name",
                data: controller.businessModel.value.businessName,
              );
            }),
            const Gap(6),
            Obx(() {
              return buildRow(
                title: "Mobile Number",
                data: controller.businessModel.value.businessContactNumber,
              );
            }),
            const Gap(6),
            Obx(() {
              return buildRow(
                title: "Website",
                data: controller.businessModel.value.website,
              );
            }),
            const Gap(6), Obx(() {
              return buildRow(
                title: "Email id",
                data: controller.businessModel.value.businessEmail,
              );
            }),
            const Gap(6),
            Obx(() {
              return buildRow(
                title: "Address",
                data: controller.businessModel.value.website,
              );
            }),
            const Gap(6),

          ],
        ),
      );
    }
  }

  Widget _buildBusinessHourContent() {
    return (controller.merchantProfile?.businessHours ?? []).isEmpty
        ? GestureDetector(
      onTap: () async {
        final previousData = (controller.merchantProfile?.businessHours ?? [])
            .toList();
        final result = await Get.toNamed(
          Routes.BUSINESS_HOURS,
          arguments: previousData.isNotEmpty
              ? previousData
              : null,
        );
        if (result != null &&
            result is List<Map<String, dynamic>>) {
          // controller.handleBusinessHoursData(result);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.white,
          border: Border.all(color: MyColors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(" + ADD BUSINESS HOURS",
          style: MyTexts.bold16.copyWith(color: MyColors.grey),)),
      ),
    )
        : Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: MyColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildBusinessHourItem(),
        ],
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

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: MyColors.iconColor),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            text,
            style: MyTexts.medium14.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHourItem(String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: MyTexts.regular14.copyWith(
            color: const Color(0xFF808080),
            fontFamily: MyTexts.Roboto,
          ),
        ),
        Text(
          hours,
          style: MyTexts.medium14.copyWith(
            color: const Color(0xFF2B2B2B),
            fontFamily: MyTexts.Roboto,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessMetricsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: const Color(0xFFD0D0D0)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Metrics',
            style: MyTexts.medium16.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          SizedBox(height: 2.h),
          Obx(() {
            final merchantProfile = controller.merchantProfile;

            return Column(
              children: [
                if (merchantProfile?.yearsInBusiness != null)
                  _buildMetricItem(
                    'Years in Business',
                    '${merchantProfile!.yearsInBusiness}+',
                  ),
                if (merchantProfile?.yearsInBusiness != null)
                  SizedBox(height: 1.h),
                if (merchantProfile?.projectsCompleted != null)
                  _buildMetricItem(
                    'Projects Completed',
                    '${merchantProfile!.projectsCompleted}+',
                  ),
                if (merchantProfile?.projectsCompleted != null)
                  SizedBox(height: 1.h),
                _buildMetricItem('Customer Rating', '4.9/5'), // Static for now
                SizedBox(height: 1.h),
                _buildMetricItem(
                  'Response Time',
                  '< 2 hours',
                ), // Static for now
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: MyColors.backgroundColor, // Light blue background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: MyTexts.regular14.copyWith(
              color: MyColors.textGrey,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          Text(
            value,
            style: MyTexts.medium14.copyWith(
              color: MyColors.textGrey,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}
