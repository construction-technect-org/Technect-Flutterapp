import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/ChatSystem/connector/AllChatList/model/all_chat_list_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:readmore/readmore.dart';

class InfoMetricsComponent extends StatelessWidget {
  InfoMetricsComponent({super.key});

  List<String> items = ["Manufacturer", "Service Provider", "Trader"];

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Information',
              style: MyTexts.bold16.copyWith(color: MyColors.gray2E),
            ),
            GestureDetector(
              onTap: () => Get.to(() => EditProfile()),

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
              onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
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
                                // '${(userData?.firstName ?? '').capitalizeFirst} ${(userData?.lastName ?? '').capitalizeFirst}'
                                //     .trim()
                                //     .isEmpty
                                '${controller.userMainModel?.firstName?.capitalizeFirst ?? ''} ${controller.userMainModel?.lastName?.capitalizeFirst ?? ''}!',
                          ),
                          const Gap(6),
                          buildRow(
                            title: "Mobile Number",
                            data: "${controller.userMainModel?.phone ?? ""}",
                          ),
                          const Gap(6),
                          buildRow(
                            title: "Email ID",
                            data: "${controller.userMainModel?.email ?? ""}",
                          ),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Role",
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.grayA5,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Obx(() {
                                return DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: controller.selectedValue.value,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Manufacturer',
                                          child: Text('Manufacturer'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Service Provider',
                                          child: Text('Service Provider'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Trader',
                                          child: Text('Trader'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        controller.selectedValue.value = value!;
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          //buildRow(title: "Role", data: userData?.roleName ?? "-"),
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
      // final home = Get.find<CommonController>();
      // final merchant = home.profileData.value.data?.merchantProfile;
      // final modelGstin = controller.businessModel.value.gstinNumber ?? '';
      // final merchantGstin = merchant?.gstinNumber ?? '';

      if (controller.businessModel1.value.gstinNumber == null) {
        return GestureDetector(
          onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
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
      } else if (controller.businessModel1.value.gstinNumber!.isEmpty) {
        return GestureDetector(
          onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
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
                final name = controller.businessModel1.value.businessName;
                return buildRow(title: "Company name", data: name);
              }),
              const Gap(6),
              Obx(() {
                final modelGstin =
                    controller.businessModel1.value.gstinNumber ?? '';
                final userGstin = controller.userData?.gst ?? '-';
                return buildRow(title: "GSTIN", data: modelGstin);
              }),
              const Gap(6),

              Obx(() {
                final contact =
                    controller.businessModel1.value.businessContactNumber ?? '';
                return buildRow(title: "Mobile Number", data: contact);
              }),
              const Gap(6),
              Obx(() {
                final website = controller.businessModel1.value.website ?? '';
                return buildRow(title: "Website", data: website);
              }),
              const Gap(6),
              Obx(() {
                final email =
                    controller.businessModel1.value.businessEmail ?? '';
                return buildRow(title: "Email id", data: email);
              }),
              const Gap(6),
              Obx(() {
                final alt =
                    controller.businessModel1.value.alternativeBusinessEmail ??
                    '';
                return buildRow(title: "Alternative number", data: alt);
              }),
              const Gap(6),
              Obx(() {
                final year = controller.businessModel1.value.year ?? '';
                return buildRow(title: "Year of establish", data: year);
              }),

              const Gap(6),
              Obx(() {
                return buildAddressRow(
                  title: "Address",
                  data: Get.find<CommonController>().getCurrentAddress().value,
                );
              }),
              const Gap(6),
            ],
          ),
        );
      }
    });
  }

  Widget _buildBusinessHourContent() {
    final data = controller.businessHoursData1;
    final List<MerchantDay> openDays = [];
    final List<MerchantDay> closedDays = [];
    return Obx(() {
      if (controller.businessHoursData1.isEmpty) {
        return Text(
          "No business hours set",
          style: MyTexts.medium16.copyWith(color: MyColors.gray54),
        );
      }
      controller.businessHoursData1.sort((a, b) {
        final keyA = a.keys.first;
        final keyB = b.keys.first;
        return keyA.compareTo(keyB);
      });
      if (controller.businessHoursData1[0].keys == 0) {
        print("Values ${controller.businessHoursData1[0].values}");
      }
      /*data.sort(
        (a, b) => (a['day_of_week'] as int).compareTo(b['day_of_week'] as int),
      );

      final openDays = data.where((d) => d['is_open'] == true).toList();
      final closedDays = data.where((d) => d['is_open'] == false).toList(); */

      final List<Widget> items = [];
      items.add(
        _buildBusinessHourItem("Monday", controller.businessHoursData1[0]![0]!),
      );
      items.add(
        _buildBusinessHourItem(
          "Tuesday",
          controller.businessHoursData1[1]![1]!,
        ),
      );
      items.add(
        _buildBusinessHourItem(
          "Wednesday",
          controller.businessHoursData1[2]![2]!,
        ),
      );
      items.add(
        _buildBusinessHourItem(
          "Thursday",
          controller.businessHoursData1[3]![3]!,
        ),
      );
      items.add(
        _buildBusinessHourItem("Friday", controller.businessHoursData1[4]![4]!),
      );
      items.add(
        _buildBusinessHourItem(
          "Saturday",
          controller.businessHoursData1[5]![5]!,
        ),
      );
      items.add(
        _buildBusinessHourItem("Sunday", controller.businessHoursData1[6]![6]!),
      );
      /*for (final day in openDays) {
        items.add(_buildBusinessHourItem([day], isOpen: true));
      }

      if (closedDays.isNotEmpty) {
        items.add(_buildBusinessHourItem(closedDays, isOpen: false));
      } */

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

  Widget _buildBusinessHourItem(String dayofWeek, MerchantDay days) {
    String dayLabel = dayofWeek;

    final String openTime = !days.closed! ? (days.open ?? "") : "";
    final String closeTime = !days.closed! ? (days.close ?? "") : "";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: !days.closed!
            ? const Color(0xFFEAF0FF)
            : const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: !days.closed!
              ? const Color(0xFFCAD6FF)
              : const Color(0xFFF5C8C8),
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
                    !days.closed!
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
                !days.closed! ? "Open" : "Closed",
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

  Widget buildAddressRow({String? data, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: MyTexts.medium14.copyWith(color: MyColors.grayA5),
          ),
        ),
        Flexible(
          flex: 2,
          child: ReadMoreText(
            data ?? "",
            trimMode: TrimMode.Line,
            trimLines: 1,
            colorClickableText: const Color.fromRGBO(33, 150, 243, 1),
            trimCollapsedText: 'View More',
            style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
            trimExpandedText: '  Show less',
            textAlign: TextAlign.right,
            moreStyle: MyTexts.medium15.copyWith(
              color: const Color.fromRGBO(33, 150, 243, 1),
            ),
          ),
        ),
      ],
    );
  }
}
