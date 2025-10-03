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
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.to(() => EditProfile());
              },
              icon: const Icon(Icons.edit, color: Colors.black, size: 20),
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
              style: MyTexts.medium16.copyWith(
                color: MyColors.fontBlack,
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                return Get.toNamed(Routes.EDIT_PROFILE);
              },
              icon: const Icon(Icons.edit, color: Colors.black, size: 20),
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
                fontFamily: MyTexts.Roboto,
              ),
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
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
              icon: const Icon(Icons.edit, color: Colors.black, size: 20),
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
                          buildRow(
                            title: "GSTIN",
                            data:
                                userData?.gst ??
                                Get.find<ProfileController>()
                                    .businessModel
                                    .value
                                    .gstinNumber ??
                                '-',
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
            child: Center(
              child: Text(
                " + ADD BUSINESS DETAILS",
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
              const Gap(6),
              Obx(() {
                return buildRow(
                  title: "Email id",
                  data: controller.businessModel.value.businessEmail,
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
    return Obx(() {
      if (controller.businessHoursData.isEmpty) {
        return GestureDetector(
          onTap: () async {
            final previousData = controller.businessHoursData.toList();
            final result = await Get.toNamed(
              Routes.BUSINESS_HOURS,
              arguments: previousData.isNotEmpty ? previousData : null,
            );
            if (result != null && result is List<Map<String, dynamic>>) {
              controller.handleBusinessHoursData(result);
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
            child: Center(
              child: Text(
                " + ADD BUSINESS HOURS",
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
            border: Border.all(color: MyColors.primary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Working Hours",
                style: MyTexts.medium16.copyWith(
                  color: MyColors.primary.withValues(alpha: 0.5),
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildBusinessHourItem()],
                ),
              ),

              // _buildBusinessHourItem(),
            ],
          ),
        );
      }
    });
  }

  Widget _buildBusinessHourItem() {
    final openDays = controller.businessHoursData
        .where((day) => day['is_open'] == true)
        .toList();

    if (openDays.isEmpty) {
      return Text("Closed", style: MyTexts.medium14.copyWith(color: MyColors.red));
    }

    String dayRange = "";
    if (openDays.length == 1) {
      // Only one open day → show just that day
      dayRange = openDays.first['day_name'];
    } else {
      // More than one open day → show range
      final firstDay = openDays.first['day_name'];
      final lastDay = openDays.last['day_name'];
      dayRange = "$firstDay to $lastDay";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dayRange, style: MyTexts.medium16.copyWith(color: MyColors.green)),
        Text(
          "${openDays.first['open_time']} to ${openDays.first['close_time']}",
          style: MyTexts.medium16.copyWith(color: MyColors.green),
        ),
        const Gap(8),
        ...controller.businessHoursData.map((day) {
          if (day['is_open'] == false) {
            return Text(
              "${day['day_name']} Closed",
              style: MyTexts.medium14.copyWith(color: MyColors.red),
            );
          }
          return const SizedBox();
        }),
      ],
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
}
