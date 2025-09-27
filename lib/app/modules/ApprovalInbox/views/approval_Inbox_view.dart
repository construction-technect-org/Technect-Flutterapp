import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/controllers/approval_Inbox_controller.dart';
import 'package:construction_technect/app/modules/home/views/home_view.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ApprovalInboxView extends GetView<ApprovalInboxController> {
  const ApprovalInboxView({super.key});

  Widget buildStatusCard({
    required IconData icon,
    required Color iconColor,
    required String message,
    required String title,
    required String product,
    required String category,
    required String dateTime,
  }) {
    print(dateTime);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: iconColor, width: 3)),
        boxShadow: const [
          BoxShadow(
            color: MyColors.americanSilver,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),

            // Message Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   title,
                  //   style: MyTexts.bold15.copyWith(
                  //     color: MyColors.fontBlack,
                  //     fontFamily: MyTexts.Roboto,
                  //   ),
                  // ),
                  // Gap(4),
                  Text(
                    message,
                    style: MyTexts.bold15.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Product: ",
                        style: MyTexts.medium13.copyWith(
                          color: MyColors.dopelyColors,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      Text(
                        product,
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.primary,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Category: ",
                        style: MyTexts.medium13.copyWith(
                          color: MyColors.dopelyColors,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                      Text(
                        (category ?? "").capitalizeFirst ?? "",
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.primary,
                          fontFamily: MyTexts.Roboto,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DateFormat("dd MMM yyyy, hh:mma").format(
                      DateTime.parse("2025-09-27T05:26:33.061Z").toLocal(),
                    ),
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.darkGray,
                      fontFamily: MyTexts.Roboto,
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

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: const Text('Approval Inbox'),
          isCenter: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              HeaderText(text: "Statistics"),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: StaticsCard(
                      title: "Total Products",
                      value: "123.4K",
                      icon: Asset.noOfConectors,
                      color: MyColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StaticsCard(
                      title: "Approved Products",
                      value: "123.4K",
                      icon: Asset.noOfConectors,
                      color: MyColors.green,
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: StaticsCard(
                      title: "Rejected Products",
                      value: "250",
                      icon: Asset.noOfConectors,
                      color: MyColors.red,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              HeaderText(text: "Inbox"),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: controller.approvalInboxList.length,

                    itemBuilder: (context, index) {
                      final card = controller.approvalInboxList[index];
                      IconData statusIcon;
                      Color statusColor;

                      switch (card.status?.toLowerCase()) {
                        case "pending":
                          statusIcon = Icons.error_outline;
                          statusColor = MyColors.warning;
                        case "approved":
                          statusIcon = Icons.check_circle_outline_outlined;
                          statusColor = MyColors.green;
                        case "rejected":
                          statusIcon = Icons.cancel_outlined;
                          statusColor = MyColors.red;
                        default:
                          statusIcon = Icons.error_outline;
                          statusColor = MyColors.warning;
                      }
                      return buildStatusCard(
                        title: card.title ?? "",
                        icon: statusIcon,
                        category: card.entityType ?? "",
                        dateTime: card.createdAt ?? "",
                        iconColor: statusColor,
                        message: card.message ?? "",
                        product: card.metadata?.productName ?? "",
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
