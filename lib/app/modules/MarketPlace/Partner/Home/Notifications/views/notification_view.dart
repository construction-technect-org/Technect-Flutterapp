import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/controllers/notification_controller.dart';
import 'package:intl/intl.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(title: const Text('Notifications'), isCenter: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            final notifications =
                controller.notificationModel.value.data?.notifications ?? [];

            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.notifications_none, size: 64, color: MyColors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No notifications found',
                      style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You'll see notifications here",
                      style: MyTexts.regular14.copyWith(color: MyColors.grey),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: MyColors.primary,
              onRefresh: controller.refreshNotifications,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  IconData statusIcon;
                  Color statusColor;

                  switch (notification.notificationType?.toLowerCase()) {
                    case "connection_accepted":
                      statusIcon = Icons.check_circle_outline;
                      statusColor = MyColors.green;
                      case "connection_rejected":
                      statusIcon = Icons.cancel_outlined;
                      statusColor = MyColors.red;
                    case "product_approved":
                      statusIcon = Icons.verified;
                      statusColor = MyColors.green;
                    case "product_verification":
                      statusIcon = Icons.hourglass_empty;
                      statusColor = MyColors.warning;
                    case "product_rejected":
                      statusIcon = Icons.cancel_outlined;
                      statusColor = MyColors.red;
                    default:
                      statusIcon = Icons.notifications;
                      statusColor = MyColors.primary;
                  }

                  return buildNotificationCard(
                    title: notification.title ?? "",
                    icon: statusIcon,
                    category: notification.entityType ?? "",
                    dateTime: notification.createdAt ?? DateTime.now(),
                    iconColor: statusColor,
                    message: notification.message ?? "",
                    product: notification.metadata?.productName ?? "",
                    isRead: notification.isRead ?? false,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String message,
    required String title,
    required String product,
    required String category,
    required DateTime dateTime,
    required bool isRead,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: iconColor, width: 3)),
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
                color: iconColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTexts.bold15.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: MyTexts.regular14.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (product.isNotEmpty) ...[
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
                          "Type: ",
                          style: MyTexts.medium13.copyWith(
                            color: MyColors.dopelyColors,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        Text(
                          category.capitalizeFirst ?? "",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.primary,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    DateFormat("dd MMM yyyy, hh:mma").format(dateTime.toLocal()),
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.darkGray,
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: MyColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
