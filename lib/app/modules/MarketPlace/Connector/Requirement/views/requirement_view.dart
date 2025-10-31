import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/controllers/requirement_controller.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequirementView extends StatelessWidget {
  final RequirementController controller = Get.put(RequirementController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(title: const Text("Requirements")),
          body: RefreshIndicator(
            backgroundColor: MyColors.primary,
            color: Colors.white,
            onRefresh: () async {
              await controller.fetchRequirementsList();
            },
            child: Obx(() {
              if (controller.requirementListModel.value.data?.isEmpty ?? true) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No requirements found',
                        style: MyTexts.medium16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Add your first requirement',
                        style: MyTexts.regular14.copyWith(color: MyColors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount:
                    controller.requirementListModel.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final requirement =
                      controller.requirementListModel.value.data?[index];
                  return _buildRequirementCard(context, requirement);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementCard(
    BuildContext context,
    RequirementData? requirement,
  ) {
    Color statusColor;
    switch (requirement?.status?.toLowerCase()) {
      case "pending":
        statusColor = Colors.orange;
      case "approved":
      case "accepted":
        statusColor = Colors.green;
      case "rejected":
        statusColor = Colors.red;
      default:
        statusColor = MyColors.fontBlack;
    }

    return Card(
      color: MyColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: MyColors.americanSilver),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requirement?.categoryProductName ?? 'N/A',
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      if (requirement?.mainCategoryName != null)
                        Text(
                          '${requirement?.mainCategoryName} > ${requirement?.subCategoryName ?? ''}',
                          style: MyTexts.regular12.copyWith(
                            color: MyColors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        requirement?.status?.toUpperCase() ?? 'N/A',
                        style: MyTexts.medium12.copyWith(color: statusColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          controller.navigateToEditRequirement(requirement),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: MyColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => controller.showDeleteConfirmationDialog(
                        requirement?.id ?? 0,
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.delete,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                const Icon(Icons.numbers, size: 16, color: MyColors.grey),
                const SizedBox(width: 8),
                Text(
                  'Quantity: ${requirement?.quantity ?? 0} ${requirement?.uom ?? ''}',
                  style: MyTexts.regular14.copyWith(color: MyColors.fontBlack),
                ),
              ],
            ),
            const Gap(8),
            if (requirement?.siteAddress != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 16, color: MyColors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (requirement?.siteAddress?.siteName != null)
                          Text(
                            requirement!.siteAddress!.siteName!,
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.fontBlack,
                            ),
                          ),
                        if (requirement?.siteAddress?.fullAddress != null) ...[
                          if (requirement?.siteAddress?.siteName != null)
                            const SizedBox(height: 4),
                          Text(
                            requirement!.siteAddress!.fullAddress!,
                            style: MyTexts.regular12.copyWith(
                              color: MyColors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
            if (requirement?.estimateDeliveryDate != null) ...[
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: MyColors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Est. Delivery: ${_formatDateString(requirement?.estimateDeliveryDate! ?? '')}',
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.fontBlack,
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
            if (requirement?.note != null &&
                (requirement?.note!.isNotEmpty ?? false)) ...[
              const Gap(4),
              Text(
                requirement?.note! ?? '',
                style: MyTexts.regular12.copyWith(color: MyColors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (requirement?.createdAt != null) ...[
              const Gap(8),
              Text(
                'Created: ${_formatDate(requirement?.createdAt! ?? DateTime.now())}',
                style: MyTexts.regular12.copyWith(color: MyColors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatDateString(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
