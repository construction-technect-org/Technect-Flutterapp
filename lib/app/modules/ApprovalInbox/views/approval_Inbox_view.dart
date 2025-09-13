import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/ApprovalInbox/controllers/approval_Inbox_controller.dart';

class ApprovalInboxView extends GetView<ApprovalInboxController> {
  const ApprovalInboxView({super.key});

  Widget buildStatusCard({
    required Color borderColor,
    required Color iconBgColor,
    required IconData icon,
    required Color iconColor,
    required String message,
    required String product,
    required String category,
    required String dateTime, 
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: borderColor, width: 3)),
        boxShadow: const [
          BoxShadow(color: MyColors.americanSilver, blurRadius: 10, offset: Offset(0, 6)),
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
                color: iconBgColor,
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
                  Text(
                    message,
                    style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Product: ",
                        style: MyTexts.medium12.copyWith(color: MyColors.fontBlack),
                      ),
                      Text(
                        product,
                        style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Category: ",
                        style: MyTexts.medium12.copyWith(color: MyColors.fontBlack),
                      ),
                      Text(
                        category,
                        style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dateTime,
                    style: MyTexts.medium12.copyWith(color: MyColors.darkGray),
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
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: WelcomeName(),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Approval Inbox",
              style: MyTexts.medium20.copyWith(color: MyColors.fontBlack),
            ),
            SizedBox(height: 2.h), // spacing between text and list
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.statusCards.length,
                  itemBuilder: (context, index) {
                    final card = controller.statusCards[index];
                    return buildStatusCard(
                      borderColor: card["borderColor"],
                      iconBgColor: card["iconBgColor"],
                      icon: card["icon"],
                      iconColor: card["iconColor"],
                      message: card["message"],
                      product: card["product"],
                      category: card["category"],
                      dateTime: card["dateTime"],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
