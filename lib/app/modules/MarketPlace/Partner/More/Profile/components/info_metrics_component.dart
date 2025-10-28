import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:gap/gap.dart';

class InfoMetricsComponent extends StatelessWidget {
  const InfoMetricsComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        // Center(
        //   child: Stack(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 8, right: 8),
        //         width: 90,
        //         height: 90,
        //         decoration: BoxDecoration(
        //           color: MyColors.primary,
        //           borderRadius: BorderRadius.circular(18),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(16),
        //           child: Image.asset(Asset.infoIcon),
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         right: 0,
        //         child: Container(
        //           width: 30,
        //           height: 30,
        //           decoration: BoxDecoration(
        //             color: const Color(0xFFFFED29),
        //             borderRadius: BorderRadius.circular(4),
        //           ),
        //           child: Icon(Icons.photo_camera, size: 20, color: MyColors.black),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Information',
              style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
            ),
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
        SizedBox(height: 2.h),
        _buildInfoMetricsContent(),
        SizedBox(height: 2.h),
        Row(
          children: [
            Text(
              'Business Metrics',
              style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.EDIT_PROFILE);
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        _buildBusinessMetricsContent(),
        SizedBox(height: 2.h),
        Row(
          children: [
            Text(
              'Business Hours',
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final previousData = controller.businessHoursData.toList();
                final result = await Get.toNamed(
                  Routes.BUSINESS_HOURS,
                  arguments: previousData.isNotEmpty ? previousData : null,
                );
                if (result != null && result is List<Map<String, dynamic>>) {
                  controller.handleBusinessHoursData(result);
                  print(controller.businessHoursData);
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(Asset.edit),
              ),
            ),
          ],
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
        border: Border.all(color: MyColors.grayEA),
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
                                "${userData?.countryCode} ${userData?.mobileNumber}",
                          ),
                          const Gap(6),
                          buildRow(
                            title: "Email ID",
                            data: "${userData?.email}",
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
    return Obx(() {
      if ((controller.businessModel.value.gstinNumber ?? "").isEmpty) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.EDIT_PROFILE);
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
                " + Add Business Details",
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
              Obx(() {
                return buildRow(
                  title: "Business name",
                  data:
                      (controller.businessModel.value.businessName ?? "")
                          .isEmpty
                      ? "-"
                      : controller.businessModel.value.businessName,
                );
              }),
              const Gap(6),
              buildRow(
                title: "GSTIN",
                data:
                    controller.userData?.gst ??
                    controller.businessModel.value.gstinNumber ??
                    '-',
              ),
              const Gap(6),

              Obx(() {
                return buildRow(
                  title: "Mobile Number",
                  data:
                      (controller.businessModel.value.businessContactNumber ??
                              "")
                          .isEmpty
                      ? "-"
                      : controller.businessModel.value.businessContactNumber,
                );
              }),
              const Gap(6),
              Obx(() {
                return buildRow(
                  title: "Website",
                  data: (controller.businessModel.value.website ?? "").isEmpty
                      ? "-"
                      : controller.businessModel.value.website,
                );
              }),
              const Gap(6),
              Obx(() {
                return buildRow(
                  title: "Email id",
                  data:
                      (controller.businessModel.value.businessEmail ?? "")
                          .isEmpty
                      ? "-"
                      : controller.businessModel.value.businessEmail,
                );
              }),
              // const Gap(6),
              // Obx(() {
              //   return buildRow(
              //     title: "Address",
              //     data: controller.businessModel.value.address,
              //   );
              // }),
              const Gap(6),
            ],
          ),
        );
      }
    });
  }

  Widget _buildBusinessHourContent() {
    final data = controller.businessHoursData;
    return Obx(() {
      if (data.isEmpty) {
        return Text(
          "No business hours set",
          style: MyTexts.medium16.copyWith(color: MyColors.gray54),
        );
      }
      data.sort(
        (a, b) => (a['day_of_week'] as int).compareTo(b['day_of_week'] as int),
      );

      final openDays = data.where((d) => d['is_open'] == true).toList();
      final closedDays = data.where((d) => d['is_open'] == false).toList();

      final List<Widget> items = [];

      for (final day in openDays) {
        items.add(_buildBusinessHourItem([day], isOpen: true));
      }

      if (closedDays.isNotEmpty) {
        items.add(_buildBusinessHourItem(closedDays, isOpen: false));
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayEA),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Working Hours",
              style: MyTexts.medium15.copyWith(color: MyColors.grayA5),
            ),
            const Gap(12),
            Column(children: items),
          ],
        ),
      );
    });
  }

  Widget _buildBusinessHourItem(
    List<Map<String, dynamic>> days, {
    required bool isOpen,
  }) {
    String dayLabel = "";
    if (days.length == 1) {
      dayLabel = days.first['day_name'];
    } else {
      dayLabel = days.map((d) => d['day_name']).join(", ");
    }

    final String openTime = isOpen ? (days.first['open_time'] ?? "") : "";
    final String closeTime = isOpen ? (days.first['close_time'] ?? "") : "";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFFEAF0FF) : const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOpen ? const Color(0xFFCAD6FF) : const Color(0xFFF5C8C8),
        ),
      ),
      child: Column(
        children: [
          const Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isOpen
                        ? "$dayLabel ${openTime.isNotEmpty ? '$openTime - $closeTime' : ''}"
                        : dayLabel,
                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Text(
                isOpen ? "Open" : "Closed",
                style: MyTexts.medium14.copyWith(
                  color: MyColors.gray2E,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
}
