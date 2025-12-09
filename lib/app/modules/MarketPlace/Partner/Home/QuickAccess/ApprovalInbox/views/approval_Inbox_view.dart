import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/ApprovalInbox/controllers/approval_Inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/views/home_view.dart';
import 'package:intl/intl.dart';

class ApprovalInboxView extends GetView<ApprovalInboxController> {
  Widget buildStatusCard({
    required Color iconColor,
    required String message,
    required String title,
    required String product,
    required String category,
    required DateTime dateTime,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        alignment: AlignmentGeometry.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: MyColors.grayEA.withValues(alpha: 0.32), blurRadius: 4)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message, style: MyTexts.medium14.copyWith(color: MyColors.black)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              product,
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gray54,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              DateFormat(
                "dd MMM yyyy, hh:mma",
              ).format(DateTime.parse("2025-09-27T05:26:33.061Z").toLocal()),
              style: MyTexts.medium13.copyWith(
                color: MyColors.gray2E,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Asset.moreIBg), fit: BoxFit.cover),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Inbox'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(12),
                          const HeaderText(text: "Statistics"),
                          const Gap(24),
                          Obx(() {
                            return IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: buildRow(
                                      image: Asset.totalProduct,
                                      title: "Total Products",
                                      data:
                                          (controller
                                                      .approvalInboxList
                                                      .value
                                                      .data
                                                      ?.productStatistics
                                                      ?.totalProducts ??
                                                  0)
                                              .toString(),
                                      filter: ApprovalFilter.all,
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: buildRow(
                                      image: Asset.totalProduct,
                                      title: "Approved Products",
                                      data:
                                          (controller
                                                      .approvalInboxList
                                                      .value
                                                      .data
                                                      ?.productStatistics
                                                      ?.approvedProducts ??
                                                  0)
                                              .toString(),
                                      filter: ApprovalFilter.approved,
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: buildRow(
                                      image: Asset.totalProduct,
                                      title: "Rejected Products",
                                      data:
                                          (controller
                                                      .approvalInboxList
                                                      .value
                                                      .data
                                                      ?.productStatistics
                                                      ?.rejectedProducts ??
                                                  0)
                                              .toString(),
                                      filter: ApprovalFilter.rejected,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Gap(32),
                          const HeaderText(text: "Inbox"),
                          Obx(() {
                            final list = controller.filteredInbox;
                            if (list.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 4,
                                ),
                                child: Center(
                                  child: Text(
                                    "No data found",
                                    style: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: list.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final card = list[index];
                                Color statusColor;
                                switch (card.status?.toLowerCase()) {
                                  case "approved":
                                    statusColor = const Color(0xFFE6F5E6);
                                  case "rejected":
                                    statusColor = const Color(0xFFFCECE9);
                                  default:
                                    statusColor = const Color(0xFFFEF7E8);
                                }

                                return buildStatusCard(
                                  title: card.title ?? "",
                                  category: card.entityType ?? "",
                                  dateTime: card.createdAt ?? DateTime.now(),
                                  iconColor: statusColor,
                                  message: card.message ?? "",
                                  product: card.metadata?.productName ?? "",
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow({
    required String image,
    required String data,
    required String title,
    required ApprovalFilter filter,
  }) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == filter;

      return GestureDetector(
        onTap: () {
          controller.selectedFilter.value = filter;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? MyColors.primary.withValues(alpha: 0.5) : Colors.transparent,
            ),

            borderRadius: BorderRadius.circular(8),
            color: MyColors.white,
            boxShadow: [BoxShadow(color: MyColors.grayEA.withValues(alpha: 0.32), blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image, height: 27, width: 28, fit: BoxFit.cover),
              const Gap(4),
              Text(data, style: MyTexts.extraBold18.copyWith(color: MyColors.black)),
              const Gap(4),
              Text(title, style: MyTexts.medium14.copyWith(color: MyColors.gray54)),
            ],
          ),
        ),
      );
    });
  }
}
