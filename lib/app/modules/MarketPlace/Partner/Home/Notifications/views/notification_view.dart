import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/Notifications/controllers/notification_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:intl/intl.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          const CommonBgImage(),

          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Notifications'),
                isCenter: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Obx(() {
                          final notifications =
                              controller.notificationModel.value.data?.notifications ?? [];
                          if(controller.isLoading.value){
                            return Padding(
                              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5),
                              child: const Center(child: CircularProgressIndicator(backgroundColor: MyColors.primary, color: MyColors.verypaleBlue,)),
                            );
                          }
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
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                Color statusColor;

                                switch (notification.notificationType?.toLowerCase()) {
                                  case "connection_accepted":
                                    statusColor =const Color(0xffE6F5E6);
                                    case "connection_rejected":
                                    statusColor = const Color(0xffFCECE9);
                                  case "product_approved":
                                    statusColor =const Color(0xffE6F5E6);
                                  case "product_verification":
                                    statusColor = const Color(0xFFFEF7E8);
                                  case "product_rejected":
                                    statusColor = const Color(0xffFCECE9);
                                  default:
                                    statusColor = MyColors.veryPaleBlue;
                                }

                                return buildNotificationCard(
                                  title: notification.title ?? "",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNotificationCard({
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
        color: iconColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow:  [
          BoxShadow(color: MyColors.grayEA.withValues(alpha: 0.32), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MyTexts.medium15.copyWith(
                          color: MyColors.gray2E,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.gray54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (product.isNotEmpty) ...[
                        Row(
                          children: [
                            Text(
                              "Product: ",
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gray54,
                              ),
                            ),
                            Text(
                              product,
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.black,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Type: ",
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.gray54,
                              ),
                            ),
                            Text(
                              category.capitalizeFirst ?? "",
                              style: MyTexts.medium13.copyWith(
                                color: MyColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ],
                  ),
                ),
                // if (!isRead)
                //   Container(
                //     width: 8,
                //     height: 8,
                //     decoration: const BoxDecoration(
                //       color: MyColors.primary,
                //       shape: BoxShape.circle,
                //     ),
                //   ),
              ],
            ),
          ),
          Align(
            alignment:AlignmentGeometry.bottomRight ,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                )
              ),
              child: Text(
                DateFormat("dd MMM yyyy, hh:mma").format(dateTime.toLocal()),
                style: MyTexts.medium14.copyWith(
                  color: MyColors.gray2E,
                  fontFamily: MyTexts.SpaceGrotesk,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
