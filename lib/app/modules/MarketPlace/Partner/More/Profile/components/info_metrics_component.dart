import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/dashboard/dashbaord_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/edit_profile.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/point_of_contact.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:readmore/readmore.dart';

class InfoMetricsComponent extends StatelessWidget {
  InfoMetricsComponent({super.key});

  final ProfileController controller = Get.find<ProfileController>();
  final DashBoardController _dashBoardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information Section
        Obx(() {
          final name = controller.userName;
          return _buildSectionHeader(
            imageUrl: controller.userImage,
            title: name.isNotEmpty ? name : "User Information",
            isUser: true,
          );
        }),
        _buildInfoCard("Information", [
          _buildInfoRow("Full Name", controller.userName),
          _buildInfoRow("Email", controller.userEmail),
          _buildInfoRow("Phone", controller.userPhone),
          Obx(
            () => _buildInfoRow(
              "Designation",
              controller.userDesignation.isNotEmpty
                  ? controller.userDesignation
                  : controller.selectedValue.value,
            ),
          ),
        ], onEdit: () => Get.to(() => EditProfile())),
        const Gap(16),

        // Business Metrics Section
        Obx(() {
          return _buildSectionHeader(
            imageUrl: controller.businessModel.value.image,
            title: controller.businessModel.value.businessName ?? "Business Metrics",
          );
        }),
        _buildBusinessMetricsContent(),
        const Gap(16),

        // Point of Contact Section
        _buildPointOfContactContent(),
        const Gap(16),

        // Business Hours Section
        _buildBusinessHoursSection(),
        const Gap(32),
      ],
    );
  }

  Widget _buildSectionHeader({String? imageUrl, required String title, bool isUser = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.grayEA,
            child: (imageUrl != null && imageUrl.isNotEmpty)
                ? ClipOval(
                    child: getImageView(
                      finalUrl: imageUrl.startsWith('http')
                          ? imageUrl
                          : "${APIConstants.bucketUrl}$imageUrl",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.person, color: MyColors.grayA5, size: 30),
          ),
          const Gap(12),
          Expanded(
            child: isUser
                ? RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${_dashBoardController.userMainModel?.firstName?.capitalizeFirst ?? ''} ${_dashBoardController.userMainModel?.lastName?.capitalizeFirst ?? ''}',
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(title, style: MyTexts.bold18.copyWith(color: MyColors.gray2E)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children, {VoidCallback? onEdit}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyColors.grayEA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: MyTexts.bold16.copyWith(color: MyColors.gray2E)),
              if (onEdit != null)
                GestureDetector(onTap: onEdit, child: SvgPicture.asset(Asset.edit, height: 18)),
            ],
          ),
          const Gap(12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
          ),
          const Text(":  "),
          Expanded(
            flex: 3,
            child: Text(
              (value == null || value.isEmpty) ? "N/A" : value,
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessMetricsContent() {
    return Obx(() {
      final bm = controller.businessModel.value;
      if (bm.gstinNumber == null || bm.gstinNumber!.isEmpty) {
        return _buildInfoCard("Business Metrics", [
          Center(
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
              child: Text(
                "+ Add Business Details",
                style: MyTexts.bold16.copyWith(color: MyColors.grey),
              ),
            ),
          ),
        ]);
      }
      return _buildInfoCard("Business Metrics", [
        _buildInfoRow("Company Name", bm.businessName),
        _buildInfoRow("GSTIN", bm.gstinNumber),
        _buildInfoRow("Website", bm.website),
        _buildInfoRow("Business Email", bm.businessEmail),
        _buildInfoRow("Contact Number", bm.businessContactNumber),
        _buildInfoRow("Establishment Year", bm.year),
        Obx(() {
          return _buildAddressRow(
            "Address",
            Get.find<CommonController>().getCurrentAddress().value,
          );
        }),
      ], onEdit: () => Get.toNamed(Routes.EDIT_PROFILE));
    });
  }

  Widget _buildAddressRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
          ),
          const Text(":  "),
          Expanded(
            flex: 3,
            child: ReadMoreText(
              value ?? "N/A",
              trimMode: TrimMode.Line,
              colorClickableText: MyColors.primary,
              trimCollapsedText: 'View More',
              trimExpandedText: ' Show less',
              style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointOfContactContent() {
    return Obx(() {
      final poc = controller.profileResponse1.value.merchant?.pocDetails;
      return _buildInfoCard("Point of Contact", [
        _buildInfoRow("Name", poc?.pocName),
        _buildInfoRow("Designation", poc?.pocDesignation),
        _buildInfoRow("Email", poc?.pocEmail),
        _buildInfoRow("Contact Number", poc?.pocPhone),
      ], onEdit: () => Get.to(() => PointOfContentScreen()));
    });
  }

  Widget _buildBusinessHoursSection() {
    return Obx(() {
      return _buildInfoCard(
        "Business Hours",
        [
          if (controller.businessHoursData1.isEmpty)
            const Center(child: Text("No business hours set"))
          else
            Column(
              children: controller.businessHoursData1.map((data) {
                final dayIndex = data.keys.first;
                final dayData = data.values.first;
                final dayNames = [
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                  "Sunday",
                ];
                final dayName = dayIndex < dayNames.length ? dayNames[dayIndex] : "Unknown";
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dayName, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
                      Text(
                        (dayData?.closed == false)
                            ? "${dayData?.open} - ${dayData?.close}"
                            : "Closed",
                        style: MyTexts.medium14.copyWith(
                          color: (dayData?.closed == false) ? MyColors.gray2E : MyColors.red33,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
        onEdit: () async {
          final result = await Get.toNamed(Routes.BUSINESS_HOURS);
          if (result == true) {
            controller.fetchProfileSummaryData();
          }
        },
      );
    });
  }
}
