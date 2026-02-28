import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/controllers/connection_inbox_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/incoming_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Connection/views/outgoing_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/model/product_model.dart';
import 'package:intl/intl.dart';

class ConnectionDialogs {
  static void _showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmButtonText,
    required Color confirmButtonColor,
    required VoidCallback onConfirm,
    IconData? icon,
    Color? iconColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (iconColor ?? MyColors.primary).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 32, color: iconColor ?? MyColors.primary),
                  ),
                  const Gap(16),
                ],
                Text(
                  title,
                  style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                  textAlign: TextAlign.center,
                ),
                const Gap(12),
                Text(
                  message,
                  style: MyTexts.regular14.copyWith(color: MyColors.gra54),
                  textAlign: TextAlign.center,
                ),
                const Gap(24),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        onTap: () => Navigator.of(context).pop(),
                        buttonName: 'Cancel',
                        borderRadius: 12,
                        height: 48,
                        color: MyColors.grayEA,
                        fontColor: MyColors.fontBlack,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: RoundedButton(
                        onTap: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        buttonName: confirmButtonText,
                        borderRadius: 12,
                        height: 48,
                        color: confirmButtonColor,
                        fontColor: MyColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showAcceptDialog(BuildContext context, IncomingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Accept Connection",
      message:
          "Are you sure you want to connect with ${connection.connectorProfile?.verificationDetails?.name ?? 'this user'}?",
      confirmButtonText: "Accept",
      confirmButtonColor: Colors.green,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      onConfirm: () => Get.find<ConnectionInboxController>().acceptConnection(connection.id),
    );
  }

  static void showDeclineDialog(BuildContext context, IncomingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Decline Request",
      message:
          "Are you sure you want to decline the request from ${connection.connectorProfile?.verificationDetails?.name ?? 'this user'}?",
      confirmButtonText: "Decline",
      confirmButtonColor: MyColors.red,
      icon: Icons.highlight_off,
      iconColor: MyColors.red,
      onConfirm: () => Get.find<ConnectionInboxController>().rejectConnection(connection.id),
    );
  }

  static void showBlockDialog(BuildContext context, IncomingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Block User",
      message:
          "Are you sure you want to block ${connection.connectorProfile?.verificationDetails?.name ?? 'this user'}? You won't see their requests anymore.",
      confirmButtonText: "Block",
      confirmButtonColor: MyColors.fontBlack,
      icon: Icons.block,
      iconColor: MyColors.fontBlack,
      onConfirm: () => Get.find<ConnectionInboxController>().blockConnection(connection.id),
    );
  }

  static void showWithdrawDialog(BuildContext context, OutgoingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Withdraw Request",
      message:
          "Are you sure you want to withdraw your connection request to ${connection.merchantProfile?.businessName ?? 'this business'}?",
      confirmButtonText: "Withdraw",
      confirmButtonColor: MyColors.primary,
      icon: Icons.undo,
      iconColor: MyColors.primary,
      onConfirm: () => Get.find<ConnectionInboxController>().withdrawRequest(connection.id),
    );
  }

  static void showRemoveDialog(BuildContext context, OutgoingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Remove Connection",
      message:
          "Are you sure you want to remove your connection with ${connection.merchantProfile?.businessName ?? 'this business'}?",
      confirmButtonText: "Remove",
      confirmButtonColor: MyColors.red,
      icon: Icons.person_remove_outlined,
      iconColor: MyColors.red,
      onConfirm: () => Get.find<ConnectionInboxController>().removeConnection(connection.id),
    );
  }

  static void showBlockOutgoingDialog(BuildContext context, OutgoingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Block Business",
      message:
          "Are you sure you want to block ${connection.merchantProfile?.businessName ?? 'this business'}?",
      confirmButtonText: "Block",
      confirmButtonColor: MyColors.fontBlack,
      icon: Icons.block,
      iconColor: MyColors.fontBlack,
      onConfirm: () => Get.find<ConnectionInboxController>().blockConnection(connection.id),
    );
  }

  static void showConnectDialog({
    required BuildContext context,
    required String businessName,
    required VoidCallback onConfirm,
  }) {
    _showConfirmDialog(
      context: context,
      title: "Connect with Business",
      message: "Are you sure you want to connect with $businessName?",
      confirmButtonText: "Connect",
      confirmButtonColor: MyColors.primary,
      icon: Icons.person_add_outlined,
      iconColor: MyColors.primary,
      onConfirm: onConfirm,
    );
  }

  // --- Adapters for old model calls ---

  static void showAcceptConnectionDialog(BuildContext context, IncomingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Accept Connection",
      message:
          "Are you sure you want to connect with ${connection.connectorProfile?.verificationDetails?.name ?? 'this user'}?",
      confirmButtonText: "Accept",
      confirmButtonColor: Colors.green,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      onConfirm: () => Get.find<ConnectionInboxController>().acceptConnection(connection.id),
    );
  }

  static void showRejectConnectionDialog(BuildContext context, IncomingConnection connection) {
    _showConfirmDialog(
      context: context,
      title: "Reject Connection",
      message:
          "Are you sure you want to reject the connection request from ${connection.connectorProfile?.verificationDetails?.name ?? 'this user'}?",
      confirmButtonText: "Reject",
      confirmButtonColor: MyColors.red,
      icon: Icons.highlight_off,
      iconColor: MyColors.red,
      onConfirm: () => Get.find<ConnectionInboxController>().rejectConnection(connection.id),
    );
  }

  // --- New Connection Request Dialogs ---

  static void showSendConnectionDialog(
    BuildContext context,
    Product product, {
    required bool isFromIn,
    required bool isConnect,
    required Function(String message, String date, String radius) onTap,
  }) {
    if (isConnect) {
      _showConfirmDialog(
        context: context,
        title: "Connection Already Requested",
        message: "You have already sent a connection request to this business.",
        confirmButtonText: "Okay",
        confirmButtonColor: MyColors.primary,
        icon: Icons.info_outline,
        onConfirm: () {},
      );
      return;
    }

    final TextEditingController messageController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController radiusController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Connect with Business", style: MyTexts.bold18),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Gap(16),
                Text(
                  "Send a message and details to connect with ${product.brand ?? 'this business'}.",
                  style: MyTexts.regular14.copyWith(color: MyColors.gra54),
                ),
                const Gap(20),
                CommonTextField(
                  controller: messageController,
                  hintText: "Write a message...",
                  headerText: "Message",
                  maxLine: 3,
                ),
                const Gap(16),
                CommonTextField(
                  controller: dateController,
                  hintText: "DD/MM/YYYY",
                  headerText: "Expected Delivery Date",
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                    }
                  },
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_month),
                ),
                const Gap(16),
                CommonTextField(
                  controller: radiusController,
                  hintText: "Enter radius (km)",
                  headerText: "Project Radius",
                  keyboardType: TextInputType.number,
                ),
                const Gap(24),
                RoundedButton(
                  onTap: () {
                    onTap(messageController.text, dateController.text, radiusController.text);
                  },
                  buttonName: "Send Request",
                  color: MyColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showSendServiceConnectionDialog(
    BuildContext context,
    dynamic service, {
    required bool isFromIn,
    required bool isConnect,
    required Function(String message, String date, String radius) onTap,
  }) {
    // Similar to showSendConnectionDialog but for services
    showSendConnectionDialog(
      context,
      Product(brand: service.name), // Mocking product for basic compatibility
      isFromIn: isFromIn,
      isConnect: isConnect,
      onTap: onTap,
    );
  }
}
