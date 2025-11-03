import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/controller/service_detail_controller.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailScreen extends GetView<ServiceDetailController> {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final service = controller.service;
      final isEdit = controller.isFromAdd.value;

      return LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            title: Text(isEdit ? "Edit Service" : "Service Details"),
            isCenter: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// =============== SERVICE INFO SECTION ===============
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.service.serviceCategoryName?.capitalizeFirst ??
                          '-',
                      style: MyTexts.medium18.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        controller.onEditService();
                      },
                      icon: SvgPicture.asset(
                        Asset.editIcon,
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          MyColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(
                        "Edit",
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.primary,
                          fontFamily: MyTexts.SpaceGrotesk,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFF9BD),
                        const Color(0xFFFFF9BD).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      rowText(
                        '₹ ${controller.service.price ?? 0}',

                        'Ex factory rate',
                      ),
                      const Gap(4),
                      rowText(
                        '₹ ${controller.service.gstPercentage?.split(".").first ?? 0}% - (₹${controller.service.gstAmount ?? 0})',
                        'Gst',
                      ),
                      Divider(color: MyColors.white),
                      rowText(
                        "₹ ${controller.service.totalAmount ?? "0"}",
                        'Ex Factory Amount',
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                _buildSpecificationsTable(),
                const Gap(20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF7E8),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFDEBC8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.grayA5,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        controller.service.description ?? "-",
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),

                if (controller.videoPlayerController != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reference Video",
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () => controller.openVideoDialog(
                          context,
                          APIConstants.bucketUrl +
                              (service.media?.first?.toString() ?? ""),
                          true,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: controller
                                .videoPlayerController!
                                .value
                                .aspectRatio,
                            child: VideoPlayer(
                              controller.videoPlayerController!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
  Widget _buildSpecificationsTable() {
    final product = controller.service;
    final specifications = [
      {'label': 'Brand Name', 'value': product.mainCategoryName.toString()},
      {'label': 'Category', 'value': product.subCategoryName.toString()},
      {'label': 'Sub category', 'value': product.subCategoryName.toString()},
      {'label': 'Unit', 'value': product.units.toString()},
    ];

    return _buildSpecificationTable(specifications);
  }

  Widget _buildSpecificationTable(List<Map<String, String>> specifications) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.grayE6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          border: const TableBorder(
            // horizontalInside: BorderSide(color: MyColors.grayD4),
            // verticalInside: BorderSide(color: MyColors.grayD4),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: MyColors.grayE6),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Specification',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            ...specifications.map(
                  (spec) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      spec['label']!,
                      style: MyTexts.medium15.copyWith(color: MyColors.gray54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Text(
                        spec['value']?.capitalizeFirst?? '',
                        style: MyTexts.medium15.copyWith(color: MyColors.black),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowText(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              fontSize: 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ],
      ),
    );
  }

}
