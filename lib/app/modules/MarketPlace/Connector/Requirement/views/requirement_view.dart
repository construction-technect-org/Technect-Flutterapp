import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddRequirement/models/GetRequirementModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddServiceRequirement/models/get_service_requirement_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Requirement/controllers/requirement_controller.dart';
import 'package:intl/intl.dart';

class RequirementView extends StatelessWidget {
  final RequirementController controller = Get.put(RequirementController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoaderWrapper(
        isLoading: controller.isLoading,
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            backgroundColor: MyColors.white,
            appBar: CommonAppBar(title: const Text("Requirements")),
            body: Column(
              children: [
                // Tab Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.grayEA,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onTabChanged(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: controller.selectedTabIndex.value == 0
                                    ? MyColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Product',
                                textAlign: TextAlign.center,
                                style: MyTexts.medium14.copyWith(
                                  color: controller.selectedTabIndex.value == 0
                                      ? Colors.white
                                      : MyColors.gray54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onTabChanged(1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: controller.selectedTabIndex.value == 1
                                    ? MyColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Service',
                                textAlign: TextAlign.center,
                                style: MyTexts.medium14.copyWith(
                                  color: controller.selectedTabIndex.value == 1
                                      ? Colors.white
                                      : MyColors.gray54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor: MyColors.primary,
                    color: Colors.white,
                    onRefresh: () async {
                      if (controller.selectedTabIndex.value == 0) {
                        await controller.fetchRequirementsList();
                      } else {
                        await controller.fetchServiceRequirementsList();
                      }
                    },
                    child: Obx(() {
                      if (controller.selectedTabIndex.value == 0) {
                        return _buildProductRequirementsList();
                      } else {
                        return _buildServiceRequirementsList();
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductRequirementsList() {
    if (controller.requirementListModel.value.data?.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No product requirements found',
              style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Add your first product requirement',
              style: MyTexts.regular14.copyWith(color: MyColors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.requirementListModel.value.data?.length ?? 0,
      itemBuilder: (context, index) {
        final requirement = controller.requirementListModel.value.data?[index];
        return _buildRequirementCard(context, requirement);
      },
    );
  }

  Widget _buildServiceRequirementsList() {
    if (controller.serviceRequirementListModel.value.data?.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No service requirements found',
              style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Add your first service requirement',
              style: MyTexts.regular14.copyWith(color: MyColors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.serviceRequirementListModel.value.data?.length ?? 0,
      itemBuilder: (context, index) {
        final serviceRequirement =
            controller.serviceRequirementListModel.value.data?[index];
        return _buildServiceRequirementCard(context, serviceRequirement);
      },
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
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
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.black,
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
                        color: statusColor.withValues(alpha: 0.1),
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
                          color: MyColors.primary.withValues(alpha: 0.1),
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
                          color: Colors.red.withValues(alpha: 0.1),
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
            const Gap(8),
            Row(
              children: [
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
                  const Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: MyColors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (requirement?.siteAddress?.siteName != null)
                          Text(
                            requirement!
                                    .siteAddress!
                                    .siteName!
                                    .capitalizeFirst ??
                                "",
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
                style: MyTexts.regular14.copyWith(color: MyColors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildServiceRequirementCard(
    BuildContext context,
    ServiceRequirementData? serviceRequirement,
  ) {
    Color statusColor;
    switch (serviceRequirement?.status?.toLowerCase()) {
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceRequirement?.serviceCategoryName ?? 'N/A',
                        style: MyTexts.bold16.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      if (serviceRequirement?.mainCategoryName != null)
                        Text(
                          '${serviceRequirement?.mainCategoryName} > ${serviceRequirement?.subCategoryName ?? ''}',
                          style: MyTexts.regular14.copyWith(
                            color: MyColors.black,
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
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        serviceRequirement?.status?.toUpperCase() ?? 'N/A',
                        style: MyTexts.medium12.copyWith(color: statusColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => controller.navigateToEditServiceRequirement(
                        serviceRequirement,
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.primary.withValues(alpha: 0.1),
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
                      onTap: () => controller
                          .showDeleteServiceRequirementConfirmationDialog(
                            serviceRequirement?.id ?? 0,
                          ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
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
            const Gap(8),
            if (serviceRequirement?.siteAddress != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: MyColors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (serviceRequirement?.siteAddress?.siteName != null)
                          Text(
                            serviceRequirement!
                                    .siteAddress!
                                    .siteName!
                                    .capitalizeFirst ??
                                "",
                            style: MyTexts.medium14.copyWith(
                              color: MyColors.fontBlack,
                            ),
                          ),
                        if (serviceRequirement?.siteAddress?.fullAddress !=
                            null) ...[
                          if (serviceRequirement?.siteAddress?.siteName != null)
                            const SizedBox(height: 4),
                          Text(
                            serviceRequirement!.siteAddress!.fullAddress!,
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
            if (serviceRequirement?.estimateStartDate != null) ...[
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: MyColors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Est. Start: ${_formatDateString(serviceRequirement?.estimateStartDate! ?? '')}',
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.fontBlack,
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
            if (serviceRequirement?.note != null &&
                (serviceRequirement?.note!.isNotEmpty ?? false)) ...[
              const Gap(4),
              Text(
                serviceRequirement?.note! ?? '',
                style: MyTexts.regular14.copyWith(color: MyColors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
